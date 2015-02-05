<script type="text/javascript">

    $(function () {
        $('#pl-search-template').ready(function () {

            $("#accordion_search_panel").hide()
            tstvar2 = tstvar[is_active()]
            if (tstvar2["search-template"]["panel-hidden"]==false){
                if (tstvar2["search-template"]["quick-search"]["header-names"]==undefined){
                    pl_search_get_elements()
                    pl_search_get_custom_search_elements()
                }

                pl_search_body_init()
                if (tstvar2["search-template"]["panel-collapsed"]==false){
                    $("#collapseSearch").myCollapse("show")
                }
                else
                {
                    $("#collapseSearch").myCollapse("hide")
                }
            }
            else if (tstvar2["search-template"]["sql-search"]!==""){
                $("#pl-search-template").parent().parent("fieldset").hide()
                tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"]=[1,10,0]
                pl_write_in_tstvar([[tstvar2["search-template"]["sql-search"]]])
                pl_list_render_list()
            }
            else
            {
                pl_search_body_init()
            }

        });

    })
    function pl_search_get_custom_search_elements(){
        var active_tab=is_active()
        var dfd = $.Deferred();
        var thisSearch = {'searched-object':tstvar[active_tab]["tab-object-type"],'pagination':[0,1111,1111]}
        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            method:"POST",
            data: {json: JSON.stringify(thisSearch),myAction:"customSearch"},
            async:false,
            success: function(dat) {
                var tabType=[]
                for (var i in dat["rows"]){
                    tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]={}
                    tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]["value"]=[]
                    tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]["type"]=[]
                }
                for (var i in dat["rows"]){
                    tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]["value"].push(dat["rows"][i][1])
                    tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]["type"].push(dat["rows"][i][2])
                    if (dat["lookup"]!=undefined){
                        tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]["lookup"]=dat["lookup"]
                    }
                    else{
                        tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]["lookup"]=[""]
                    }
                }


                dfd.resolve()
            } ,
            error:function(){
                dat={"row-types":["text","text","text"],"pagination":[0,1111,4],"rows":[["Assets","Asset ID","number"],["Assets","Contact Name","text"],["Contacts","Kontakt ID","number"],["Contacts","Kontakt Name","text"]],"header-names":["Class","Label","Typ"]}

                var tabType=[]
                for (var i in dat["rows"]){
                    tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]={}
                    tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]["value"]=[]
                    tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]["type"]=[]
                }
                for (var i in dat["rows"]){
                    tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]["value"].push(dat["rows"][i][1])
                    tstvar[active_tab]["search-template"]["custom-search-fields"][dat["rows"][i][0]]["type"].push(dat["rows"][i][2])
                }
                dfd.reject()
            }
        })
        return dfd.promise()
    }

    function pl_search_get_elements(){
        var active_tab=is_active()
        var dfd = $.Deferred();
        var thisSearch = {'searched-object':tstvar[active_tab]["tab-object-type"],'pagination':[0,1111,1111]}
        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            method:"POST",
            data: {json: JSON.stringify(thisSearch),myAction:"quickSearch"},
            async:false,
            success: function(dat) {
                tstvar[active_tab]["search-template"]["quick-search"]["value"]=[]
                tstvar[active_tab]["search-template"]["quick-search"]["header-names"]=[]
                tstvar[active_tab]["search-template"]["quick-search"]["row-types"]=[]
                for (var i in dat["rows"]){
                    tstvar[active_tab]["search-template"]["quick-search"]["value"].push(dat["rows"][i][2])
                    tstvar[active_tab]["search-template"]["quick-search"]["header-names"].push(dat["rows"][i][0])
                    tstvar[active_tab]["search-template"]["quick-search"]["row-types"].push(dat["row-types"][i])
                }

                dfd.resolve()
            } ,
            error:function(){

                switch (tstvar[active_tab]["tab-object-type"]){
                    case "assets":
                        dat = {"value":["","",""],
                            "types":["number","text","text"],
                            "header-names":["Asset ID","Product Type","Contact Name"]}
                        break;
                    case "contacts":
                        dat = {"value":["",""],
                            "types":["number","text"],
                            "header-names":["Contact ID","Contact Name"]}
                        break;
                    case "reports":
                        dat = {"value":["","",""],
                            "types":["text","text","text"],
                            "header-names":["Report Name","Report Owner","Report Description"]}
                        break;
                    case "cash Flows":
                        dat = {"value":["","",""],
                            "types":["number","number","text"],
                            "header-names":["Cash Flow ID","Asset ID","Booking Date"]}
                        break;
                }
                tstvar[active_tab]["search-template"]["quick-search"]["value"]=dat["value"]
                tstvar[active_tab]["search-template"]["quick-search"]["header-names"]=dat["header-names"]
                tstvar[active_tab]["search-template"]["quick-search"]["types"]=dat["types"]

                dfd.reject()
            }
        })
        return dfd.promise()
    }

    function pl_search_body_init() {

        tstvar2 = pl_get_active_tab_data() ;
        pl_search_make_elements()
        SearchVar=pl_search_push_button()

        pl_write_in_tstvar(SearchVar)
        pl_search_call_list_controller("list")

        $('#pl-search-button').click(function(e){
            e.preventDefault()
            SearchVar=pl_search_push_button()
           pl_write_in_tstvar(SearchVar)
            tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"]=[1,10,0]
            pl_list_render_list()

        })
    }

    function pl_write_in_tstvar(searchReq){
        tstvar[is_active()]["search-template"]["search-request"]=searchReq
        }

    function pl_search_make_elements() {
        var active_tab = is_active()
        if(tstvar[active_tab]["search-template"]["custom-search"][0][1]=="")
        {

            for (j in tstvar[active_tab]["search-template"]["custom-search"]){
                if( tstvar[active_tab]["search-template"]["custom-search"][j][1]=="")
                {
                    var tTempVar=[]
                    for (i in tstvar[active_tab]["search-template"]["custom-search-fields"]){
                        tTempVar.push(i)
                        tstvar[active_tab]["search-template"]["custom-search"][j][1].push(i)
                        tstvar[active_tab]["search-template"]["custom-search"][j][2]=tTempVar["value"]
                        tstvar[active_tab]["search-template"]["custom-search"][j][3]=tTempVar["type"]
                    }

                    tstvar[active_tab]["search-template"]["custom-search"][j][2]=tstvar[active_tab]["search-template"]["custom-search-fields"][tTempVar[0]]["value"]
                    var typeToRelations = tstvar[active_tab]["search-template"]["custom-search-relations"][tstvar[active_tab]["search-template"]["custom-search-fields"][tTempVar[0]]["type"][0]]
                    tstvar[active_tab]["search-template"]["custom-search"][j][3]=typeToRelations


                }
            }
        }



        $("#pl-search-template-searched-object p strong").text(tstvar2["search-template"]["label-searched-object"])
        $("#pl-search-template-searched-object").show()
        $("#pl-search-template-searched-object-form select").attr("disabled",true)
        for (var i in tstvar2["search-template"]["search-select-options"]) {
            $("#pl-search-template-searched-object-form select option:last")
                    .text(tstvar2["search-template"]["search-select-options"][i])
                    .clone()
                    .attr("disabled",true)
                    .appendTo("#pl-search-template-searched-object-form select")
        }

        $("#pl-search-template-searched-object-form select option:last").remove()
        $("#pl-search-button").removeClass("hide")
                .text( gui_messages[ "search.button.text" ] )
        $("#pl-search-template-searched-object-form option").each(function(){
            if ($(this).text()==tstvar2["tab-object-type"]){
                $(this).attr("disabled",false)

            }
        })
        $("#pl-search-template-searched-object-form select").val(tstvar2["search-template"]["searched-object"] )

        for (var i in tstvar2["search-template"]["quick-search"]["header-names"]) {

            var this_label = tstvar2["search-template"]["quick-search"]["header-names"][i]
            var this_field = tstvar2["search-template"]["quick-search"]["value"][i]
            var tmpStr = "#pl-search-template-quick-form-"+i
            $('#pl-search-template-quick-form-dummy')
                    .clone()
                    .removeClass('hide')
                    .attr("id","pl-search-template-quick-form-"+i)
                    .insertAfter($("[myId='quick-search-elements']:last"))

            $(tmpStr+" label")
                    .text(this_label)

            $(tmpStr+" input")
                    .attr("value",this_field)
                    .attr("id","pl-search-template-quick-label-"+i)
        }

        function addCol(myCol){
            $("#pl-search-template-custom-select").clone()
                    .attr("id","pl-search-template-custom-select-"+myCol)
                    .attr("mycustomsearchid",parseInt(myCol)+1)
                    .appendTo("#pl-search-template-custom-form")
            for (var i in tstvar2["search-template"]["custom-search"][myCol]) {

                var this_element = tstvar2["search-template"]["custom-search"][myCol][i]
                $("#pl-search-template-custom-select-"+myCol+" select:first")
                        .clone()
                        .attr("id","pl-search-template-custom-select-"+myCol+i)
                        .insertAfter($("#pl-search-template-custom-select-"+myCol+" select:last"))
            }

            for (var i in tstvar2["search-template"]["custom-search"][myCol]){
                var k=parseInt(i)+1
                for (var j in tstvar2["search-template"]["custom-search"][myCol][i]){

                    $("#pl-search-template-custom-select-"+myCol+" select:nth-child("+k+")")
                            .find("option:first")
                            .clone()
                            .text(tstvar2["search-template"]["custom-search"][myCol][i][j])
                            .attr("id","pl-search-template-custom-select-option"+myCol+k+j)
                            .appendTo("#pl-search-template-custom-select-"+myCol+" select:nth-child("+k+")")
                            .end()

                }
                $("#pl-search-template-custom-select-"+myCol+" select:nth-child("+k+") :first-child").remove()
            }
            $("#pl-search-template-custom-select-"+myCol+" select:last").remove()

        }

         for (var i in tstvar2["search-template"]["custom-search"]){

             addCol(i)
         }
        $("#pl-search-template-custom-select").remove()


        $("#pl-search-template-quick-form-dummy").remove()

        $("#pl-search-template input:not(#pl-additional-search),#pl-search-template textarea").change(function(){
            var that_id=$(this).attr("id")
            tstvar[is_active()]["search-template"]["changed_elements"][that_id]=$(this).val()
        })
        $("select[myID=custom-search-type-select]").change(function(){
                     var that_id=$(this).attr("id")
                     tempCount = $("#pl-search-template-custom-form div").length    //Anzahl der Zeilen ermitteln
                     var m=parseInt($(this).parent().attr("myCustomSearchID"))-1

                     var k = m*4+1 //Zählvariable zur Auswahl des Elements
                     var l=k+1

                     if($(this).is($("select[myID=custom-search-type-select] :eq("+k+")")))  //wenn k-te Element geändert wird ändere Options
                     {
                         var objT=$(this).attr("value")
                         tstvar2["search-template"]["custom-search"][m][2]= tstvar2["search-template"]["custom-search-fields"][$(this).attr("value")]["value"]
                         $(this).next().empty()
                         for (var i in tstvar2["search-template"]["custom-search"][m][2]){
                             $(this).next().append("<option>"+tstvar2["search-template"]["custom-search"][m][2][i]+"</option>")
                         }
                         pl_search_change_relation($(this).next(),$(this).parent().attr("myCustomSearchID"))
                     }
                     if($(this).is($("select[myID=custom-search-type-select] :eq("+l+")")))  //wenn k-te Element geändert wird ändere Options
                     {
                         pl_search_change_relation($(this),$(this).parent().attr("myCustomSearchID"))
                     }

                })
        $("[mycustomsearchid='1'] select:first").attr('disabled',true)

        //Akkordion-menü für CustomSearch und SQL Search
        $("#pl-additional-search a").click(function(e){
            e.preventDefault()
            $(this).next().slideToggle('slow')
                    .toggleClass("collapsed")
        })
        $("#pl-search-sql-text-area").val(tstvar2["search-template"]["sql-search"])
        if (tstvar[is_active()]["search-template"]["input-fields"]!=undefined){
            for (i in tstvar[is_active()]["search-template"]["input-fields"]){
                $("#pl-search-template input").eq(i).val(tstvar[is_active()]["search-template"]["input-fields"][i])
            }
        }


        $("[myname=search-custom-selection]").focusout(function() {
            var m=parseInt($(this).attr("myCustomSearchID"))-1
            var myVartemp=[]
            var optionsVar=[]
            that_id=$(this).attr("id")
            $(this).children("select").each(function(i){
                var optionsVar=[]
                $(this).children("option").each(function(j,obj){
                    optionsVar.push($(this).text())
                })
                tstvar[is_active()]["search-template"]["custom-search"][m][i]=optionsVar

                   myVartemp.push($(this).attr("value"))
            })

            tstvar[is_active()]["search-template"]["changed_elements"][that_id]= myVartemp

        } )
        if(tstvar[is_active()]["search-template"]["changed_elements"]!=undefined) {
            for (i in tstvar[is_active()]["search-template"]["changed_elements"]){
                if(jQuery.isArray(tstvar[is_active()]["search-template"]["changed_elements"][i])){
                    for (j in tstvar[is_active()]["search-template"]["changed_elements"][i]){
                        $("#"+i).children().eq(j).val(tstvar[is_active()]["search-template"]["changed_elements"][i][j])
                    }
                }
                else{
                    if(tstvar[is_active()]["search-template"]["changed_elements"][i]!=undefined)
                        $("#"+i).val(tstvar[is_active()]["search-template"]["changed_elements"][i])
                }

            }
        }

    }

    function pl_search_change_relation(that,col){     //Erzeugt Änderung in der Relationenauswahlbox

        for (j in tstvar2["search-template"]["custom-search-fields"][that.prev().attr("value")]["type"]){
            if (that.attr("value")==tstvar2["search-template"]["custom-search-fields"][that.prev().attr("value")]["value"][j])
            {
                var type = tstvar2["search-template"]["custom-search-fields"][that.prev().attr("value")]["type"][j]
                $("[myCustomSearchId="+col+"] select:last").empty()
                for (o in tstvar2["search-template"]["custom-search-relations"][type])
                {
                    $("[myCustomSearchId="+col+"] select:last").append("<option>"+tstvar2["search-template"]["custom-search-relations"][type][o]+"</option>")
                }

            }
        }
    }

    function pl_search_create_additional_selection(){

        var search_add_id = $("#pl-search-template-custom-form div").length+1
        tempCount = $("#pl-search-template-custom-form div").length+1
        $("div[myName=search-custom-selection] :last").after(
                $("div[myName=search-custom-selection] :last")
                        .clone()
                        .attr("id","pl-search-template-custom-select-"+search_add_id)
                        .attr("myCustomSearchId",search_add_id)

        )
        $("[myCustomSearchId="+search_add_id+"] select").each(function(i,val){
                 $(this).attr("id","pl-search-template-custom-select-"+search_add_id+i)
                })
        $("#pl-search-template-custom-form input").each(function(i,val){
            $(this).attr("id","pl-search-template-custom-input-"+i)
        })

    }

    function pl_search_delete_last_selection(){
        $("div[myName=search-custom-selection] :last").remove()
    }

    function pl_search_push_button(){
        var SearchIt=[]
        var tmpQSearch=pl_search_quick_search("[myId=quick-search-elements]")
        if (tmpQSearch!=[])SearchIt=pl_search_quick_search("[myId=quick-search-elements]")
        var tmpCSearch=pl_search_custom_search()


        if (tmpCSearch!=""){
            if (tmpCSearch[2]==false){
                tmpCSearch.pop()
                SearchIt.push(tmpCSearch)
            }
            else{
                for (i in tmpCSearch){
                    SearchIt.push(tmpCSearch[i])

                }
            }
        }

        SQLSearchVar=[$("#pl-search-sql-text-area").val()]
        if (SQLSearchVar[0]!=""){SearchIt.push(SQLSearchVar)}
        return SearchIt
    }

    function pl_search_quick_search(domFilter){
        var QuickSearch=[]
        $(domFilter).each(function(key){
            if ($(this).find("input").val()!=""){
                var tmpQS=[$(this).find("label").text(),$(this).find("input").val()]
                QuickSearch.push(tmpQS)
            }

        })
        return QuickSearch
    }

    function pl_search_logic(logic){
        logVar=true
        if (logic=="or")
        {
            logVar=false
        }

       return logVar
    }

    function pl_search_change_relation_to_symbol(toTest){
          for (i in relations){
              if (toTest==i.replace("_"," ")){
                    toTest=relations[i]
              }
          }
        return toTest
    }

    function pl_search_custom_search(){

        var tmp1=[]
        var tmp2=[]

        var andOr=true
        var countElements=$("[myId='custom-search-type-select']").length/$("[myCustomSearchId]").length

        if( $("#pl-search-template-custom").attr('class').indexOf("hide") >= 0 ) return []

        $("[myId='custom-search-type-select']").each(function(i){

            if (i==0||i==countElements){

                andOr=pl_search_logic($(this).attr("value"))

            }
            else{
                if (i<countElements+1){

                    tmp1.push(pl_search_change_relation_to_symbol($(this).val()))

                }
                else{
                    tmp2.push(pl_search_change_relation_to_symbol($(this).val()))

                }
            }
        })


        if ((andOr==false)&&(tmp1[3]!="")&&(tmp2[3]!="")){

            return [tmp1,tmp2,andOr]
        }
        else{
            if((tmp1[3]!="" && tmp1[3]!=null )&&(tmp2[3]!="" && tmp2[3]!=null)){
                return [tmp1,tmp2]
            }
            else{
                if(tmp2[3]!="" && tmp2[3]!=null){

                    return [tmp2]
                }
                else{
                    if (tmp1[3]!="" && tmp1[3]!=null){

                        return [tmp1]
                    }
                    else{
                        return []
                    }

                }
            }

        }

        /*if (tut!==null){
             return tut
        }*/

    }

    function pl_search_call_list_controller(pl_action) {
        var start =  time()
        var dfd = $.Deferred();
        tstvar[is_active()]["list-template"]["list-template-generic"]["rows"]=[]
        var thisSearch = {'searched-object':tstvar[is_active()]["tab-object-type"],'pagination':tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"],"search-request":tstvar[is_active()]["search-template"]["search-request"],"list-template-generic":tstvar[is_active()]["list-template"]["list-template-generic"]}

        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            method:"POST",
            data: {json: JSON.stringify(thisSearch),myAction:pl_action},
            async:false,
            success: function(dat) {
                if(dat==undefined)
                {
                    if(tstvar[is_active()]["tab-object-type"]=="reports")
                    {
                        tstvar[is_active()]["list-template"]["list-template-generic"]["rows"]=
                        [
                            [6, "statement of account 1", "statement of account", "daily", "Marx"],
                            [23, "holiday report 1", "holiday report", "weekly", "Keynes"]

                        ]
                        tstvar[is_active()]["list-template"]["list-template-generic"]["header-names"]= ["REPORT ID", "REPORT NAME", "REPORT CATEGORY", "DESCRIPTION", "OWNER"]
                    }
                }
                else
                {
                    tstvar[is_active()]["list-template"]["list-template-generic"]["rows"]=dat["rows"]
                    tstvar[is_active()]["list-template"]["list-template-generic"]["row-types"]=dat["row-types"]
                    tstvar[is_active()]["list-template"]["list-template-generic"]["header-names"]=dat["header-names"]
                    tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"]=dat["pagination"]
                    tstvar[is_active()]["list-template"]["list-template-generic"]["pointer-table"]=dat["pointer-table"]

                    if (dat["lookup"]!=undefined){
                        tstvar[is_active()]["list-template"]["list-template-generic"]["lookup"]=dat["lookup"]
                    }
                    else {
                        tstvar[is_active()]["list-template"]["list-template-generic"]["lookup"]=[""]
                    }
                }

                var ende = time() - start
                dfd.resolve()
            } ,
            error:function(){

                if(tstvar[is_active()]["tab-object-type"]=="reports")
                {

                    tstvar[is_active()]["list-template"]["list-template-generic"]["rows"]=
                    [
                        [6, "statement of account 1", "statement of account", "daily", "Marx"],
                        [23, "holiday report 1", "holiday report", "weekly", "Keynes"]
                    ]
                    tstvar[is_active()]["list-template"]["list-template-generic"]["header-names"]= ["REPORT ID", "REPORT NAME", "REPORT CATEGORY", "DESCRIPTION", "OWNER"]
                }
                dfd.reject()

            }
        })
        return dfd.promise()
    }
</script>

<div id="pl-search-template" class="row-fluid">
    <div class="span6 hide">
        <div class="row-fluid">
            <div class="span12" id="pl-search-template-searched-object">
                <p class="text-info" style="font-size:8pt"><strong>

                </strong>
                </p>

                <form class="form-horizontal simple-form">
                    <div class="control-group" id="pl-search-template-searched-object-form">
                        <select name="search-object" class="span10" style="border-radius:0px;min-height:20px;height:20px;padding:2px;font-size:8pt; ">
                            <option>

                            </option>
                        </select>
%{--                        <button class="mybutton span2" id="pl-search-button" style="padding:0px;height:20px;margin-left:0px;float:right;min-height:0;">

                        </button>--}%
                    </div>
                </form>
            </div>
            <div id="pl-additional-search" class="span12" style="margin-left: 0px;">
                <div id="pl-search-template-custom-search-main">
                    <a href="#">

                        <label class="border-bottom" style="font-size: 8pt;font-weight: bold">
                            Custom search
                        </label>

                    </a>

                    <h5 class="accordion-element">Custom search</h5>

                    <div class="hide collapse_container collapsed" id="pl-search-template-custom" >
                        <form class="simple-form border-small" style="background-color:#FBFBFB;padding-left: 17px; padding-top: 8px;" >
                            <div id="pl-search-template-custom-form" >
                                <div id="pl-search-template-custom-select" myName="search-custom-selection" myCustomSearchId="1">
                                    <select name="top5" myID="custom-search-type-select" size="1" style="width:100px;">
                                        <option></option>

                                    </select>

                                    <input name="top5" value="" myId="custom-search-type-select">
                                    <br>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div id="pl-search-template-sql-main" class="span12" style="margin-left:0px; ">
                    <a href="#" style="float:left">
                        <p class="text-info border-bottom" style="font-size: 8pt;font-weight: bold">
                            SQL 'WHERE' search
                        </p>

                    </a>
                    <div class="hide" id="pl-search-template-sql" >

                        <form class="simple-form">
                            <div id="pl-search-template-sql-form">
                                <textarea id="pl-search-sql-text-area" rows="1">
                                </textarea>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="span5" id="pl-search-template-quick">
        <p class="text-info" style="font-size:8pt"><strong>Schnellsuche</strong>
        </p>
        <form class="simple-form" style="margin-bottom:0px">
            <div id="pl-search-template-quick-form">
                <div id="pl-search-template-quick-form-dummy" myId="quick-search-elements" class="hide">
                    <label></label>

                    <input  id="pl-search-template-quick-label" value="" style="width:200px;">

                </div>
            </div>
            <button class="mybutton span2" id="pl-search-button" style="padding:0px;height:20px;margin-left:0px;float:right;min-height:0;">
            Suche starten
            </button>
        </form>
    </div>

</div>