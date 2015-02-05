<div id="pl-reports-input-template" class="well row-fluid">
    <form class="form-inline">
        <div>
            <label>
                <p class="text-info">
                    <strong>
                        Input Form
                    </strong>
                </p>
            </label>
        </div>

        <div id="pl-reports-input-select-type-x"  class="span8 hide" myReportsInputId = "x" MyReportsInputElementNumber="x">
            <label myReportsInputId="x">

            </label>
            <select class="input-small" id="pl-reports-input-select-type-x-select" myReportsInputId="x">
                <option>

                </option>
            </select>
        </div>

        <div id="pl-reports-input-period-type-0"  class="span8 hide" myReportsInputId = "x" MyReportsInputElementNumber="x">

            <label myReportsInputId="x">
                  Report Period Type
            </label>
            <select class="input-small" id="pl-reports-input-period-type-x-select" myReportsInputId="x">
                <option>

                </option>
            </select>
            <br>
            <label myReportsInputId="x">
                  Report Period
            </label>
            <label>
                from
            </label>

            <input id="pl-reports-input-period-type-x-input-1"   myReportsInputId="x" value="">
            <label>
                to
            </label>
            <input id="pl-reports-input-period-type-x-input-2"   myReportsInputId="x" value="">

        </div>

        <div id="pl-reports-input-standard-type-x"  class="hide span8" myReportsInputId = "x" MyReportsInputElementNumber="x">
            <label myReportsInputId="x">
                Report CCY
            </label>
            <input id="pl-reports-input-standard-type-x-input"   myReportsInputId="x" value="">

        </div>

        <div id="pl-reports-input-date-type-x"  class="hide span8" MyReportsInputElementNumber="x">
            <label myReportsInputId="x">
                Report date
            </label>
            <input id="pl-reports-input-date-field-type-x-input"   myReportsInputId="x" value="">

        </div>


        <div class="span4" id="input-reports-do-it-button-div">
            <button class="mybutton" id="input-reports-do-it-button">Do It</button>
            <button class="mybutton" id="input-reports-update-button">Update Archive List</button>
        </div>

    </form>
    <br>

</div>

<script type="text/javascript">
    $(function(){
        $('#pl-reports-input-template').ready(function () {
            pl_reports_input_init();
        })
    })



    function pl_reports_input_init(){
        tstvar2 = pl_get_active_tab_data()

        if (tstvar2["tab-object-type"]=="Reports") {

            if (tstvar[is_active()]["reports-input-template"]["panel-hidden"]==false){
                pl_list_to_reports_input("giveInputReports")
                pl_reports_input_load_fields()
                pl_list_if_checked()
                pl_reports_input_update_reports_archive()
                if (tstvar[is_active()]["reports-input-template"]["panel-collapsed"]){
                    $("#collapseReportsInput").myCollapse("hide")
                }
                else{
                    $("#collapseReportsInput").myCollapse("show")
                }
            }
            else{

                 $("#accordion_reportsInput_panel").hide()
            }


        }
    }

    function pl_reports_input_load_fields(){

        var repInputElements = tstvar[is_active()]["reports-input-template"]["elements"]

        for(var element in repInputElements){

             switch(repInputElements[element]["element-type"]){
                 case "Period Type":
                         pl_reports_input_create_period_type(element,repInputElements[element])
                     break;
                 case "Standard Type":
                     pl_reports_input_create_standard_type(element,repInputElements[element])
                     break;
                 case "Date Type":
                     pl_reports_input_create_date_type(element,repInputElements[element])
                     break;
                 case "Select Type":
                     pl_reports_input_create_select_type(element,repInputElements[element])
             }

        }
        $("#pl-reports-input-template label")
                .filter(":contains('Database stamp')")
                .parent("div")
                .insertBefore($("[myReportsInputElementNumber]:first"))
        $("input[myReportsInputId]").not("[id^=pl-reports-input-select-type-]").change(function(){pl_reports_input_at_input_change($(this))})


        $("input[id^=pl-reports-input-period-type-]").change(function(){
            var MyElement = pl_reports_input_get_element_number($(this))
            var myTmpVar=[]
            $("[MyReportsInputElementNumber="+MyElement+"] input").each(function(key,obj){
                tstvar[is_active()]["reports-input-template"]["elements"][MyElement]["input"]["value"][key]=$(this).val()
                if (key==0){
                    myTmpVar=["from",$(this).val()]
                }
                else{
                    myTmpVar.push("to")
                    myTmpVar.push($(this).val())
                }
            })

            if (myTmpVar[1]!==""||myTmpVar[3]!==""){
                tstvar[is_active()]["reports-input-template"]["search-request"][MyElement]=myTmpVar

            }
            pl_list_if_checked()
        })

        $("select[id^=pl-reports-input-select-type-]").change(function(){
            var MyElement = pl_reports_input_get_element_number($(this))
            if ($(this).prev().contents().filter("Report Period")&&$(this).parent().next("label").contents().filter("Report Period")&&$(this).parent().next().next("label").contents().filter("Report Period")) {
                  switch($(this).val()){
                      case "fixed month":
                          break;
                      case "free choice":
                          var myInpElement = $(this).parent().next().find("input")
                          var myNextInpElement =   $(this).parent().next().next().find("input")

                          myInpElement.val(pl_get_current_date())
                          myNextInpElement.val(pl_get_current_date())

                          tstvar[is_active()]["reports-input-template"]["elements"][myInpElement.parent().attr("MyReportsInputElementNumber")]["input"]["value"]=myInpElement.val()
                          tstvar[is_active()]["reports-input-template"]["elements"][myNextInpElement.parent().attr("MyReportsInputElementNumber")]["input"]["value"]=myNextInpElement.val()
                          pl_reports_input_at_input_change(myInpElement)
                          pl_reports_input_at_input_change(myNextInpElement)
                          break;
                      case "last four weeks":
                          var myDate = new Date()
                          myDate.setDate(myDate.getDate()-28)
                          var myInpElement = $(this).parent().next().find("input")
                          var myNextInpElement =   $(this).parent().next().next().find("input")

                          myInpElement.val(pl_get_date(myDate))
                          myNextInpElement.val(pl_get_current_date())

                          myInpElement.parent().attr("MyReportsInputElementNumber")

                          tstvar[is_active()]["reports-input-template"]["elements"][myInpElement.parent().attr("MyReportsInputElementNumber")]["input"]["value"]=myInpElement.val()
                          tstvar[is_active()]["reports-input-template"]["elements"][myNextInpElement.parent().attr("MyReportsInputElementNumber")]["input"]["value"]=myNextInpElement.val()

                          pl_reports_input_at_input_change(myInpElement)
                          pl_reports_input_at_input_change(myNextInpElement)
                          break;
                  }
            }

            tstvar[is_active()]["reports-input-template"]["elements"][MyElement]["select-box"]["current_val"]=$(this).val()
            pl_list_if_checked()
        })
        $('#input-reports-do-it-button')
                .on('click',function(e){e.preventDefault(); pl_reports_input_do_it()})

        $("#input-reports-update-button").click(function(e){
            e.preventDefault()
            pl_reports_input_update_reports_archive()
        })



    }

    function pl_reports_input_at_input_change(_this){
        var active_tab=is_active()
        var MyElement = _this.parent("div").attr("MyReportsInputElementNumber")
        tstvar[active_tab]["reports-input-template"]["temp-search-req"]=[]
        tstvar[active_tab]["reports-input-template"]["temp-search-req"][MyElement]=[_this.prev().text(),_this.val()]
        tstvar[active_tab]["reports-input-template"]["elements"][MyElement]["input"]["value"][0]=_this.val()
        tstvar[active_tab]["reports-input-template"]["search-request"]=[]
        for(i in tstvar[active_tab]["reports-input-template"]["elements"]){

            var headers = tstvar[active_tab]["reports-input-template"]["elements"][i]["header"][0]
            var sVal = tstvar[active_tab]["reports-input-template"]["elements"][i]["input"]["value"][0]
            if (sVal!=""){
                if (tstvar[active_tab]["reports-input-template"]["elements"][i]["element-type"]=="Date Type"){
                    sVal = sVal+'%'//+" 02:00:00"

                }
                tstvar[active_tab]["reports-input-template"]["search-request"].push([headers,sVal])
            }

        }

        pl_list_if_checked()

    }

    function pl_reports_input_get_element_number(that){
        return that.parent("div").attr("MyReportsInputElementNumber")
    }

    function pl_reports_check_input_fields(){
                var checkRequiredFields=true

        $("[MyReportsInputElementNumber]:not('hidden')[pl-required='true']").children("input").each(function(){

            if($(this).val()==""){checkRequiredFields=false}
        })
       return checkRequiredFields
    }

    function pl_reports_input_create_select_type(rep_inp_nr,rep_input_el){
            var rep_inp_el_num = parseInt($("[myReportsInputElementNumber]:not(:hidden)").length)
            var rep_inp_this_num = parseInt($("div[id^=pl-reports-input-select-type]:not(:hidden)").length)+1
            var $inputStandardType = $("#pl-reports-input-select-type-x")
            $inputStandardType.clone()
                    .removeClass("hide")
                    .attr("id","pl-reports-input-select-type-"+rep_inp_this_num)
                    .attr("myReportsInputId",rep_inp_el_num+1)
                    .attr("myReportsInputElementNumber",rep_inp_nr)
                    .insertAfter($("div[id^=pl-reports-input-]:last"))
                    .find("label")
                    .attr("myReportsInputId",rep_inp_el_num+1)
                    .text(rep_input_el["header"][0])
                    .end()
                    .find("select")
                    .attr("id","pl-reports-input-select-type-"+rep_inp_this_num+"-select")
                    .attr("myReportsInputId",rep_inp_el_num+1)
                    .end()
            for (var options in rep_input_el["select-box"]["options"]){
                $("#pl-reports-input-select-type-"+rep_inp_this_num+"-select option:last")
                        .clone()
                        .text(rep_input_el["select-box"]["options"][options])
                        .attr("pl-format-type",rep_input_el["select-box"]["type"][options])
                        .appendTo("#pl-reports-input-select-type-"+rep_inp_this_num+"-select")
            }
            $("#pl-reports-input-select-type-"+rep_inp_this_num+"-select").val(rep_input_el["select-box"]["current_val"])
            $("#pl-reports-input-select-type-"+rep_inp_this_num+"-select option:first").remove()
    }

    function pl_reports_input_create_date_type(rep_inp_nr,rep_input_el){
        var rep_inp_el_num = parseInt($("[myReportsInputElementNumber]:not(:hidden)").length)
        var rep_inp_std_num = parseInt($("div[id^=pl-reports-input-date-type]:not(:hidden)").length)+1
        var $inputStandardType = $("#pl-reports-input-date-type-x")
        $inputStandardType.clone()
                .removeClass("hide")
                .attr("id","pl-reports-input-date-type-"+rep_inp_std_num)
                .attr("myReportsInputId",rep_inp_el_num+1)
                .attr("myReportsInputElementNumber",rep_inp_nr)
                .attr("pl-required",rep_input_el["required"])
                .insertAfter($("div[id^=pl-reports-input-]:last"))
                .find("label")
                .attr("myReportsInputId",rep_inp_el_num)
                .text(rep_input_el["header"][0])
                .end()
                .find("input")
                .attr("myReportsInputId",rep_inp_el_num+1)
                .attr("id","pl-reports-input-date-type-"+rep_inp_std_num+"-input")
                .val(rep_input_el["input"]["value"][0])
                .attr("pl-format-type",rep_input_el["input"]["type"][0])
                .click(function(e){
                    e.preventDefault
                    $(this).datepicker({ dateFormat: "yy-mm-dd" })
                })
                .end()
        if(rep_input_el["header"][0]=="Report date"&&rep_input_el["input"]["value"]==""){
            $("#pl-reports-input-standard-type-"+rep_inp_std_num+"-input")
                    .val(pl_get_current_date())
        }
    }

    function pl_reports_input_create_standard_type(rep_inp_nr,rep_input_el){
        var rep_inp_el_num = parseInt($("[myReportsInputElementNumber]:not(:hidden)").length)
        var rep_inp_std_num = parseInt($("div[id^=pl-reports-input-standard-type]").length)+1
        var $inputStandardType = $("#pl-reports-input-standard-type-x")
        if(rep_input_el["header"][0]=="Report Id"&&tstvar[is_active()]["reports-input-template"]["checked-items"].length==1) rep_input_el["input"]["value"][0]=tstvar[is_active()]["reports-input-template"]["checked-items"][0]
       $inputStandardType.clone()
            .removeClass("hide")
            .attr("id","pl-reports-input-standard-type-"+rep_inp_std_num)
            .attr("myReportsInputId",rep_inp_el_num+1)
            .attr("myReportsInputElementNumber",rep_inp_nr)
            .attr("pl-required",rep_input_el["required"])
            .insertAfter($("div[id^=pl-reports-input-]:last"))
            .find("label")
             .attr("myReportsInputId",rep_inp_el_num+1)
             .text(rep_input_el["header"][0])
            .end()
            .find("input")
             .attr("myReportsInputId",rep_inp_el_num+1)
             .attr("id","pl-reports-input-standard-type-"+rep_inp_std_num+"-input")
             .attr("value",rep_input_el["input"]["value"][0])
             .attr("pl-format-type",rep_input_el["input"]["type"][0])
            .end()
        if(rep_input_el["input"]["action"]!=undefined){
            $("#pl-reports-input-standard-type-"+rep_inp_std_num+"-input")
                    .attr("pl-action",rep_input_el["input"]["action"][0])
        }

    }
    function pl_reports_input_do_it(){

        doVar = []
        $("[id^=pl-reports-input-field-]").each(function(i){
            var doEachVar=[]
            $(this).children().each(function(j){
                if ($(this).get(0).tagName=="LABEL")
                {
                    doEachVar.push($(this).text())
                }
                else
                {
                    doEachVar.push($(this).val())
                }
            })
            if (doEachVar.slice(-1)[0]!==""){
                doVar.push(doEachVar)
            }

        })
        pl_reports_input_create_report()
    }

    function pl_reports_input_create_report(){
        var active_tab=is_active()
        var thisSearch = {
            "tab-obj-type":"Reports",
            "action":"giveReportsArchive",
            "search-request": tstvar[active_tab]["reports-input-template"]["search-request"]
        }
        $.ajax({
            url: "${createLink(controller: 'report', action: 'create')}",
            data: {json: JSON.stringify(thisSearch),myAction:"saveReport"},
            success: function(dat) {

            },
            error:function(){

                    tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["rows"]=
                            [

                                ["My New Report","Performance", pl_get_current_date(), "Wonderful","PPP"]
                            ]

                    tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["header-names"]= ["BUCKET NAME", "REPORT TYPE", "DATE", "DESCRIPTION","OWNER"]
                    tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["rows"]=dat["rows"]
                    tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["panel-collapsed"]=false


                    tstvar[is_active()]["reports-archive-template"]["save-button-disabled"]=false

            }

        })
        pl_reports_input_update_reports_archive()
    }
    function pl_reports_input_update_reports_archive(){

        var dfd = $.Deferred();
        var active_tab = is_active()
        var checked_items = tstvar[active_tab]["reports-input-template"]["checked-items"]
        if(checked_items.length < 1){tstvar[active_tab]["reports-input-template"]["search-request"]=[] }
        var thisSearch = {
                "tab-obj-type":"Reports",
                "action":"giveReportsArchive",
                "search-request": tstvar[active_tab]["reports-input-template"]["search-request"],
                "report-type-id": checked_items,
                "pagination": tstvar[active_tab]["reports-archive-template"]["reports-archive-list"]["pagination"],
                "checked-items":checked_items
        }
        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            data: {json: JSON.stringify(thisSearch),myAction:"updateReportsArchive"},
            success: function(dat) {
                tstvar[active_tab]["reports-archive-template"]["reports-archive-list"]["rows"]=dat["rows"]
                tstvar[active_tab]["reports-archive-template"]["reports-archive-list"]["header-names"]=dat["header-names"]
                if (dat["pagination"]!==undefined){
                    tstvar[active_tab]["reports-archive-template"]["reports-archive-list"]["pagination"]=dat["pagination"]
                }
                else{
                    tstvar[active_tab]["reports-archive-template"]["reports-archive-list"]["pagination"]=[1,tstvar[active_tab]["reports-archive-template"]["reports-archive-list"]["pagination"][1],1]
                }
                tstvar[active_tab]["reports-archive-template"]["panel-collapsed"]=false
                $('#collapseReportsArchive')
                        .load(
                        '${createLink(controller: 'Home', action: 'renderReportsArchive')}',
                        function(response, status, xhr){
                            $(window).scrollTop($("#collapseReportsArchive").offset().top)
                        }
                )
                    dfd.resolve()
            } ,
            error:function(){



                switch (checked_items.length){
                    default:
                    tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["header-names"]= ["BUCKET Name", "REPORT TYPE", "DATE", "DESCRIPTION","OWNER","CCY","Country"]
                    tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["rows"]=
                            [
                                ["1234233", "statement of account", "01-01-13", "Description 01", "PRAGMALAB","EUR",""],
                                ["Berlin travel", "holiday report", "02-01-13", "Description 02", "PRAGMALAB","","Germany"]
                            ]
                    break;
                    case 1:
                        var newTmp = ""
                        for (i in tstvar[active_tab]["list-template"]["list-template-generic"]["rows"]){

                            if ( tstvar[active_tab]["list-template"]["list-template-generic"]["rows"][i][0]==checked_items[0]){

                                newTmp =  tstvar[active_tab]["list-template"]["list-template-generic"]["rows"][i][2]
                            }
                        }
                        if (newTmp == "holiday report"){
                            tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["header-names"]= ["BUCKET Name", "REPORT TYPE", "DATE", "DESCRIPTION","OWNER","Country"]
                            tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["rows"]=
                                    [
                                        ["Berlin travel", "holiday report", "02-01-13", "Description 02", "PRAGMALAB","Germany"]
                                    ]
                        }
                            else{
                            tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["header-names"]= ["BUCKET Name", "REPORT TYPE", "DATE", "DESCRIPTION","OWNER","CCY"]
                            tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["rows"]=
                                    [
                                        ["1234233", "statement of account", "01-01-13", "Description 01", "PRAGMALAB","EUR"]
                                    ]
                            }
                            break;
                        }





                tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["panel-collapsed"]=false
                $('#collapseReportsArchive')
                        .load(
                        '${createLink(controller: 'Home', action: 'renderReportsArchive')}',
                        function(response, status, xhr){
                            $(window).scrollTop($("#collapseReportsArchive").offset().top)
                        }
                )
                dfd.reject()
            }
        })
        return dfd.promise()
    }

</script>