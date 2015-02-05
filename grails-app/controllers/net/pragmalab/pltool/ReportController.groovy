package net.pragmalab.pltool

import grails.converters.JSON
import groovy.json.JsonSlurper
import net.sf.jasperreports.engine.*
import net.sf.jasperreports.engine.data.JsonDataSource
import net.sf.jasperreports.engine.design.JasperDesign
import net.sf.jasperreports.engine.export.*
import net.sf.jasperreports.engine.export.ooxml.JRDocxExporter
import net.sf.jasperreports.engine.export.ooxml.JRPptxExporter
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter
import net.sf.jasperreports.engine.xml.JRPrintXmlLoader
import net.sf.jasperreports.engine.xml.JRXmlLoader
import org.springframework.ui.jasperreports.JasperReportsUtils

import javax.imageio.ImageIO
import javax.imageio.ImageWriter
import javax.imageio.stream.ImageOutputStream
import java.awt.image.BufferedImage

//import net.sf.jasperreports.engine.data.JRAbstractBeanDataSource
//import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource
class ReportController {

    def springSecurityService
    def index() {}

    def pngpages() {
        int repId = 0
        if(params.id){repId = params.id as int}
        Reports_Results reportResult = Reports_Results.load(repId)
        JRPrintXmlLoader printXmlLoader = new JRPrintXmlLoader()
        JasperPrint newReport = printXmlLoader.load(new ByteArrayInputStream(reportResult.jrpxml.getBytes("UTF-8")));

        // trying export to image

        BufferedImage pageImage = new BufferedImage(newReport.getPageWidth() + 1, newReport.getPageHeight() + 1, BufferedImage.TYPE_INT_ARGB)

        JRGraphics2DExporter graphicsExporter = new JRGraphics2DExporter();
        graphicsExporter.setParameter(JRExporterParameter.JASPER_PRINT, newReport);
        graphicsExporter.setParameter(JRGraphics2DExporterParameter.GRAPHICS_2D, pageImage.getGraphics());
        graphicsExporter.setParameter(JRExporterParameter.PAGE_INDEX, new Integer(0));
        graphicsExporter.exportReport();

        Iterator writers = ImageIO.getImageWritersByFormatName("png");
        ImageWriter writer = (ImageWriter) writers.next();
        ImageOutputStream ios = ImageIO.createImageOutputStream(new File(servletContext.getRealPath("reports/reportpage1.png")));
        writer.setOutput(ios);
        writer.write(pageImage);
        ios.flush()
        ios.close()
        HashMap out = new HashMap()
        out["nrPages"] = newReport.pages.size()

        render out as JSON
    }

    def create() {
        def search
        def slurper = new JsonSlurper()
        def tz = slurper.parseText(params.json)
        int repId = 1

        use( DeepFinder ){
            search=tz.findDeep( 'search-request' )
        }
        for(i in search){
            if (i[0]=="Report Id"){repId=i[1] as int}
        }

        if (params.id) {repId = params.id as int}
        Reports report = Reports.load(repId)

        // dima: set report_results meta data
        Reports_Results newReportResult
        int repResId = 1
        if(params.resultid){
            repResId = params.resultid as int
            newReportResult = Reports_Results.load(repResId)
        } else {
            newReportResult = new Reports_Results(Report: report)
        }

        newReportResult.RequestTimestamp = new Date()
        newReportResult.OutputTimestamp = new Date()
        newReportResult.SaveTimestamp = new Date()
        newReportResult.DatabaseDate = new Date()
        newReportResult.ReportDate = new Date()
        newReportResult.Bucket = Buckets.load(1)
        newReportResult.Requestor = SecUser.load(1)

        for(i in search){
            if (i[0]=="Report Date"){newReportResult.ReportDate  = new Date().parse("yyyy-MM-dd",i[1])}
        }

        // dima: here we insert data for the report,
        // i.e. invoke the report engine that transforms input json into an output json

        newReportResult.json = model_engine(repId, params.json.toString())

        JasperDesign jasperDesign = JRXmlLoader.load(new ByteArrayInputStream(report.jrxml.replace('\r\n','').getBytes("UTF-8")))
        JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign)

        JsonDataSource ds = new JsonDataSource(new ByteArrayInputStream(newReportResult.json.getBytes("UTF-8")))
        def pars=new HashMap()
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, pars, ds)

        JRXmlExporter xmlExporter = new JRXmlExporter();
        xmlExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        xmlExporter.setParameter(JRExporterParameter.OUTPUT_FILE, new File(servletContext.getRealPath("reports/temp_rep")));
        xmlExporter.exportReport();
        newReportResult.jrpxml = xmlExporter.exportReportToBuffer().toString()
        newReportResult.save()
        render "ddd"
    }

    private model_engine(int repId, String inputJson){
        switch (repId) {
            case 1: // model validation report - here just load dummy json
                def tmpimp = new File(servletContext.getRealPath("reports/json.txt"))
                def slurper = new JsonSlurper()
                def js = slurper.parseText(tmpimp.text)
                js.data_header[0].'report_date'= new Date().format("yyyy-MM-dd hh:mm:ss")
                return (js as JSON).toString()
                break
            default: // return empty json
                return "{}"
        }
    }

    def show(){
        String formt = 'unknown'
        if(params.fmt){formt = params.fmt}
        int repResId = 0
        if(params.repId){repResId = params.repId as int}
        Reports_Results reportResult = Reports_Results.load(repResId)
        JRPrintXmlLoader printXmlLoader = new JRPrintXmlLoader()
        JasperPrint newReport = printXmlLoader.load(new ByteArrayInputStream(reportResult.jrpxml.getBytes("UTF-8")))
        JRExporter exporter
        switch (formt.toLowerCase()) {
            case "pdf":
                exporter = new JRPdfExporter()
                response.contentType="application/pdf"
                break
            case "rtf":
                exporter = new JRRtfExporter()
                response.contentType="application/rtf"
                break
            case "xlsx":
                exporter = new JRXlsxExporter()
                response.contentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
                //exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
                exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
                exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
                exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, Boolean.TRUE);
                //exporter.setParameter(JRXlsExporterParameter.IS_COLLAPSE_ROW_SPAN, Boolean.TRUE);
                //
                break
            case "docx":
                exporter = new JRDocxExporter()
                response.contentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                break
            case "pptx":
                exporter = new JRPptxExporter()
                response.contentType="application/vnd.openxmlformats-officedocument.presentationml.presentation"
                break
            case "odt":
                exporter = new JRPptxExporter()
                response.contentType="application/vnd.oasis.opendocument.text"
                break
            case "html":
                exporter = new JRHtmlExporter()
                exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI,"../servlets/image?image=");
                break

            default:
                exporter = new JRPrintServiceExporter()
                exporter.setParameter(JRPrintServiceExporterParameter.DISPLAY_PRINT_DIALOG, Boolean.TRUE)
                exporter.setParameter(JRPrintServiceExporterParameter.DISPLAY_PAGE_DIALOG, Boolean.FALSE)
                break
                }

        exporter.setParameter(JRExporterParameter.JASPER_PRINT, newReport);
        //exporter.setParameter(JRExporterParameter.OUTPUT_FILE, new File(servletContext.getRealPath("reports/temp_rep")))
        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, response.outputStream)
        exporter.exportReport()
        response.outputStream.flush()
        response.outputStream.close()
    }


    private getXhtmlReport(int repId, String json) {

        def pars = new HashMap(), ret, slurper = new JsonSlurper(), tmp, js;
        StringWriter writer = new StringWriter();

        pars["LOGO_URL"] = "http://pragmalab.info/images/tk_logo.gif";

        js = slurper.parseText(json);

        Reports report = Reports.load(repId);
        Reports_Results newReportResult = new Reports_Results( report, springSecurityService.currentUser );
        newReportResult.json = (js as JSON).toString();

        JasperDesign jasperDesign = JRXmlLoader.load(new ByteArrayInputStream(report.jrxml.replace('\r\n','').getBytes("UTF-8")))
        JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign)

        JsonDataSource ds = new JsonDataSource(new ByteArrayInputStream(newReportResult.json.getBytes("UTF-8")))

        JasperPrint jasperPrint = JasperFillManager.fillReport( jasperReport, pars, ds );
        JRXhtmlExporter exporter = new JRXhtmlExporter();
        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);

        JasperReportsUtils.render( exporter, jasperPrint, writer );
        String output = writer.getBuffer().toString();

        return output;

    }

}
