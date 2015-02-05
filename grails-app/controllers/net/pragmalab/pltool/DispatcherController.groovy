package net.pragmalab.pltool

import grails.plugins.springsecurity.Secured
import grails.converters.JSON
import org.codehaus.groovy.grails.web.json.*
class DispatcherController {

    def request() {

        JSONObject tz=JSON.parse(params.json)
        if (!val_json()){
            render "Error"

        }
        else{
            //  def tzz=JSON.parse('{"1":{"tab-refid":1,"tab-object-type":"Assets","active":true,"search-template":{"panel-hidden":false,"search-request":[["Asset ID","234721"],["Product Type","23"],["Contact Name","Holger Diedrich"],["Asset","Asset ID","=","123"],["Asset","Asset ID","=","124"],["asset_id=4815 and product_type=23"]],"panel-collapsed":false,"label-searched-object":"Searched object","searched-object":"Assets","label-quick-search":"Quick search","search-select-options":["Assets","Contacts","Buckets"],"quick-search":[["Asset ID","234721"],["Product Type","23"],["Contact Name","Holger Diedrich"]],"label-custom-search":"Custom search","custom-search-fields":{"Asset":{"value":["Asset ID","Contact Name"],"type":["number","text"]},"Contact":{"value":["Contact Name","Contact ID"],"type":["text","number"]},"Bucket":{"value":["Bucket ID","Bucket Name"],"type":["number","text"]},"Report":{"value":["Report Name","Report Type"],"type":["text","text"]}},"custom-search-relations":{"text":["like","not like"],"number":["equals","greater than","smaller than"]},"custom-search":[["and","or"],["Asset","Bucket","Contact"],["Asset ID","Contact Name"],["equals","not equal to","greater than","smaller than"]],"label-sql-search":"SQL Where search","sql-search":"asset_id=4815 and product_type=23"},"list-template":{"panel-hidden":false,"panel-collapsed":false,"list-template-generic":{"label-generic":"Asset List","header-names":["ASSET ID","CONTACT ID","CONTACT NAME","PROD TYPE","CCY","TAKEOVER EXPOSURE","TODAY EXPOSURE","STATUS","AMOUNT"],"row-types":["number-without-separator-link","number-without-separator","text","text","text","number-ccy","number-ccy","text","number-ccy"],"page-num":"1","cols-per-page":"10","num-of-pages":1,"rows":[[1,1,"Holger Diedrich","AC","EUR","5555.00","222.00","BLUE","5000.00"],[2,4,"Iosif Levant","AB","EUR","1234.12","235.00","GREEN","5000.00"],[3,2,"Dmitri Topaj","A","EUR","225.99","2.00","RED","5000.00"],[4,3,"Darja Schmidt","B","EUR","90.88","20.00","YELLOW","5000.00"]]}},"details-template":{"panel-hidden":true,"d-hidden":true,"panel-collapsed":true,"details-template-generic":{"data-as-of":"2013-03-07","label-generic":"Asset overview","elements":{"table1":[["ID",12342,"text"],["Asset ID",234721,"text"],["External ID",84912,"text"],["Contact ID",234721,"link","call-contacts-with-cp-id"],["Contact Name","Holger Diedrich","text"]],"table2":[["Product Type","Credit card","text"],["Division ID",12,"text"],["File ID",481516,"text"]]}},"details-template-sub":{"Overview":{"Current_Situation":[["Current Servicer","","text"],["Current Status"," ","text"],["Bucket ID","123","text"],["Current Status Valid From Date"," ","text"],["Campaign Id"," ","text"],["Current outstandig Amount"," ","text"],["Campaign Id"," ","text"],["Current Principial"," ","text"],["Current Interest"," ","text"],["Current Costs"," ","text"],["Current Overall Exposure"," ","text"],["Current Recovery"," ","text"]],"Original_Situation":[["Purchase Price","","text"],["Original Interest Rate","Aktiv","text"],["Contract Currency","123","text"]]},"Cashflow":{"Current_Situation":[["Product Type","Credit card","text"]]}}}}}')
            //println(get_controller_name(params.myAction))
            switch (get_controller_name(params.myAction))    {

                case "list":
                    //println("HALLO Liste")
                    redirect(controller: "home", action: "list",  params: [json: tz])


                    break
                case "details":
                    //println("HALLO Details")
                    redirect(controller: "home", action: "details",  params: [json: tz])

                    break
                default:
                    //println("default")
                    redirect(controller: "home", action: "list",  params: [json: tz])

                    break
            }



        }

    }
    def val_json(){
        def valdater=true



    }
    def get_controller_name(String action){

        return action }
    def test(){

        // def tzz=JSON.parse('{"1":{"tab-refid":1,"tab-object-type":"Assets","active":true,"search-template":{"panel-hidden":false,"search-request":[["Asset ID","234721"],["Product Type","23"],["Contact Name","Holger Diedrich"],["Asset","Asset ID","=","123"],["Asset","Asset ID","=","124"],["asset_id=4815 and product_type=23"]],"panel-collapsed":false,"label-searched-object":"Searched object","searched-object":"Assets","label-quick-search":"Quick search","search-select-options":["Assets","Contacts","Buckets"],"quick-search":[["Asset ID","234721"],["Product Type","23"],["Contact Name","Holger Diedrich"]],"label-custom-search":"Custom search","custom-search-fields":{"Asset":{"value":["Asset ID","Contact Name"],"type":["number","text"]},"Contact":{"value":["Contact Name","Contact ID"],"type":["text","number"]},"Bucket":{"value":["Bucket ID","Bucket Name"],"type":["number","text"]},"Report":{"value":["Report Name","Report Type"],"type":["text","text"]}},"custom-search-relations":{"text":["like","not like"],"number":["equals","greater than","smaller than"]},"custom-search":[["and","or"],["Asset","Bucket","Contact"],["Asset ID","Contact Name"],["equals","not equal to","greater than","smaller than"]],"label-sql-search":"SQL Where search","sql-search":"asset_id=4815 and product_type=23"},"list-template":{"panel-hidden":false,"panel-collapsed":false,"list-template-generic":{"label-generic":"Asset List","header-names":["ASSET ID","CONTACT ID","CONTACT NAME","PROD TYPE","CCY","TAKEOVER EXPOSURE","TODAY EXPOSURE","STATUS","AMOUNT"],"row-types":["number-without-separator-link","number-without-separator","text","text","text","number-ccy","number-ccy","text","number-ccy"],"page-num":"1","cols-per-page":"10","num-of-pages":1,"rows":[[1,1,"Holger Diedrich","AC","EUR","5555.00","222.00","BLUE","5000.00"],[2,4,"Iosif Levant","AB","EUR","1234.12","235.00","GREEN","5000.00"],[3,2,"Dmitri Topaj","A","EUR","225.99","2.00","RED","5000.00"],[4,3,"Darja Schmidt","B","EUR","90.88","20.00","YELLOW","5000.00"]]}},"details-template":{"panel-hidden":true,"d-hidden":true,"panel-collapsed":true,"details-template-generic":{"data-as-of":"2013-03-07","label-generic":"Asset overview","elements":{"table1":[["ID",12342,"text"],["Asset ID",234721,"text"],["External ID",84912,"text"],["Contact ID",234721,"link","call-contacts-with-cp-id"],["Contact Name","Holger Diedrich","text"]],"table2":[["Product Type","Credit card","text"],["Division ID",12,"text"],["File ID",481516,"text"]]}},"details-template-sub":{"Overview":{"Current_Situation":[["Current Servicer","","text"],["Current Status"," ","text"],["Bucket ID","123","text"],["Current Status Valid From Date"," ","text"],["Campaign Id"," ","text"],["Current outstandig Amount"," ","text"],["Campaign Id"," ","text"],["Current Principial"," ","text"],["Current Interest"," ","text"],["Current Costs"," ","text"],["Current Overall Exposure"," ","text"],["Current Recovery"," ","text"]],"Original_Situation":[["Purchase Price","","text"],["Original Interest Rate","Aktiv","text"],["Contract Currency","123","text"]]},"Cashflow":{"Current_Situation":[["Product Type","Credit card","text"]]}}}}}')
        //JsonNode foo = tzz.get("tab-object-type");
        //render (tzz["tab-object-type"])
        redirect( action: "test2")
        // return "asset"
    }
    def test2(){


        render "wer"
    }
}


