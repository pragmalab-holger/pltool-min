package net.pragmalab.pltool

class Reports_Results {

    static constraints = {
        jrpxml (size:0..2147483646)
        json (size:0..2147483646)
    }


    // report output info
    SecUser Requestor
    Date RequestTimestamp
    Date OutputTimestamp
    Date SaveTimestamp

    // report inputs - general
    Buckets Bucket
    Date ReportDate
    Date DatabaseDate
    Reports Report

    // dima - this is new
    String jrpxml
    String json

    Reports_Results( _report, _user ){
        Requestor = _user;
        RequestTimestamp = new Date();
        OutputTimestamp = new Date();
        SaveTimestamp = new Date();
        Bucket = Buckets.load(1);
        ReportDate = new Date();
        DatabaseDate = new Date();
        Report = _report;
        jrpxml = "";
        json = "";


    }


}
