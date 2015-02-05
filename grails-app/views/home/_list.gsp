<div id="pl-list-template" class="well row-fluid">
    <div id="pl-list-template-div span12">
        <p class="text-info"><strong></strong>
        </p>
        <table class="table table-striped" id="pl-list-table">
            <thead>
            <tr>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                </td>

            </tr>
            </tbody>
        </table>
        <div id="pl-list-pagination">
            <ol class="pager">
                <li>
                    <a href="#" id="pl-list-before" class="align-left">before
                    </a>
                </li>
                <li>
                    <input class = "pagination-input" type="text" id="pl-list-paginate-input" >
                    </input>
                </li>

                <li class = "pagination-text">
                    Number of Pages:
                </li>
                <li>
                    <a href="#" id="pl-list-next" class="align-right">next
                    </a>
                </li>
                <li>
                    <select class="pagination-select" id="pl-list-pagination-select-box">
                        <option>
                            10
                        </option>
                        <option>
                            20
                        </option>
                        <option>
                            50
                        </option>
                        <option>
                            100
                        </option>
                        <option>
                            alle
                        </option>
                    </select>
                </li>
            </ol>

        </div>
    </div>
    <button id="pl-list-new-button" type="button" class="pl-details-button-group-button hide" >Neuer Datensatz</button>

</div>

<script type="text/javascript"  charset="utf-8">
    $(document).ready( function () {

        $('#pl-list-template').ready(function () {

            $("#accordion_list_panel").hide()

            listvar = pl_get_active_tab_data()

            if( listvar["list-template"]["panel-hidden"]==false ) $("#accordion_list_panel").show()

            if( listvar["tab-object-type"]!=="info" && (listvar["list-template"]["panel-hidden"]==false)) {

                pl_list_init()

                if (listvar["list-template"]["panel-collapsed"]==false) $("#collapseList").myCollapse("show")
                else $("#collapseList").myCollapse("hide")

            }

            if( tstvar[is_active()]["tab-object-type"] != "documents" ){

                $('#pl-list-new-button').removeClass("hide")
                $('#pl-list-new-button').click( function(){ pl_details_open_edit_tab( 0 ) } )
            }

//            if( tstvar[is_active()]["list-template"]["list-template-generic"]["rows"].length==1 && tstvar[len.toString()]["tab-object-type"]!=="reports" ){
//                pl_       list_to_details( tstvar[is_active()]["list-template"]["list-template-generic"]["rows"][0][0] );
//            }

        });

    })

    function pl_list_init() {

        listvar = pl_get_active_tab_data()                                         //Zustandsvariable holen
        pl_list_create_label()                                                   //Label erzeugen
        pl_list_create_header()                                                  //Tabelle und Tabellenüberschriften erzeugen
        pl_list_create_body()                                                    //Tabelle ausfüllen

    }

    function pl_list_create_label() {          //Label erzeugen
        $("#pl-list-template-div p strong").text(listvar["list-template"]["list-template-generic"]["label-generic"])

    }

    function pl_list_create_header() {                 //Header und dazugehörige Tabelle erstellen
        var headers = listvar["list-template"]["list-template-generic"]["header-names"]
        for (var i in headers) {
            $("#pl-list-table th").last().before(
                    $("#pl-list-table th").last()
                            .clone()
                            .text(headers[i])
            )

        }
    }

    function pl_list_create_body() {                        //Tabelleninhalt erstellen

        //Variablendeklaration

        var content = listvar["list-template"]["list-template-generic"]["rows"], format, row_type;

        for (var i in content) {

            $("#pl-list-table tr").last().after(
                    $("#pl-list-table tbody tr").first()
                            .clone()
                            .attr("id","pl-list-row-number-"+i)

            )
            for (var j in content[i]) {

                format = JSON.parse( listvar["list-template"]["list-template-generic"]["row-types"][j] );
                row_type = format["row-type"];

                if( listvar["list-template"]["list-template-generic"]["lookup"][j]!="null"
                        &&listvar["list-template"]["list-template-generic"]["lookup"][j]!=""
                        &&listvar["list-template"]["list-template-generic"]["lookup"][j]!=undefined
                        &&listvar["list-template"]["list-template-generic"]["lookup"][j]!="to be defined"){

                    if( row_type=="lookup" ){
                        var lookingFor = JSON.parse(listvar["list-template"]["list-template-generic"]["lookup"][j]);
                        pl_lookup_set_value_id( lookingFor, content[i][j], false );
                        var found_lookup = find_lookup_value(lookingFor);
                        content[i][j] = (found_lookup=="") ? content[i][j] : found_lookup;
                    } else if( row_type=="lookupmulti" ){
                        var mylook = content[i][j].split(',');
                        var res=[];
                        for( k in mylook ){

                            var lookingFor = JSON.parse(listvar["list-template"]["list-template-generic"]["lookup"][j] );
                            pl_lookup_set_value_id( lookingFor, mylook[k], true);
                            var found_lookup = find_lookup_value(lookingFor);
                            res.push( (found_lookup=="") ? mylook[k] : found_lookup );
                        }
                        content[i][j] = res.join(",");
                    } else if( row_type=="lookupdomain" ){
                        var lookingFor = JSON.parse(listvar["list-template"]["list-template-generic"]["lookup"][j]);
                        pl_lookup_set_value_id( lookingFor, content[i][j], false );
                        var found_lookup = find_domain_lookup( find_lookup_value(lookingFor) );
                        content[i][j] = (found_lookup=="") ? content[i][j] : found_lookup;
                    } else {
                        oo( "_list.gsp: Fehler bei Bestimmung der Lookup-Werte von ", listvar["list-template"]["list-template-generic"]["header-names"][j] );
                    }
                }

                if( row_type==undefined && format["action"]!=undefined ){
                    $("#pl-list-table tbody tr:last td:last").before(
                            $("#pl-list-table tbody tr:last td:last")
                                    .clone()
                                    .append("<a href=\"#\">"+content[i][j]+"</a>")
                                    .data("value",j)
                                    .click(function(e){
                                        e.preventDefault()

                                        j=$(this).data("value")
                                        var obj_index = parseInt($(this).index())
                                        var header_name = $(this).parents("table").find("th").eq(obj_index).text()
                                        pl_which_action(listvar["list-template"]["list-template-generic"]["row-types"][j],$(this).find("a").text(),header_name)
                                    })
                    )
                }
                else if(row_type=="number-with-separator-2-decimal"){
                    $("#pl-list-table tbody tr:last td:last").before(
                            $("#pl-list-table tbody tr:last td:last")
                                    .clone()
                                    .html(parseInt(content[i][j]).format(2,true))

                    )
                }
                else if(row_type=="bool" && content[i][j]==true ){
                    $("#pl-list-table tbody tr:last td:last").before(
                            $("#pl-list-table tbody tr:last td:last")
                                    .clone()
                                    .html( "x" )

                    )
                }
                else if( row_type=="pointer" ){

                    if( content[i][j] != null ){
                        $("#pl-list-table tbody tr:last td:last").before(
                            $("#pl-list-table tbody tr:last td:last")
                                .clone()
                                .append("<a href=\"#\">"+content[i][j]+"</a>")
                                .data("value",j)
                                .click(function(e){
                                    e.preventDefault()
                                    j=$(this).data("value")
                                    var obj_index = parseInt($(this).index())
                                    var header_name = $(this).parents("table").find("th").eq(obj_index).text()
                                    pl_details_open_links_tab( listvar['list-template']['list-template-generic']['pointer-table'][j], content[i][j] )
                                })

                        )
                    }
                }
                else {
                    var tmp = "";
                    var z = 35;
                    if( content[i][j] != null ){
                        if( content[i][j].toString().length > z ) tmp = content[i][j].toString().substr( 0, z ) + "[...]";
                        else tmp = content[i][j].toString();
                    } else tmp = "";

                    $("#pl-list-table tbody tr:last td:last").before(
                            $("#pl-list-table tbody tr:last td:last")
                                    .clone()
                                    .html( tmp )

                    )
                    delete tmp, z;
                }

            }
        }


        if($("#pl-list-table tr").length==3&&listvar["tab-object-type"]!=="reports"){

        }
        /************************************
         * Manipulation der Spalteneinträge,*
         ******* je nach Spaltentyp *********
         * **********************************/


        $("#pl-list-table tbody tr:first").remove()



        /*************************
         *****  Report List  *****
         *************************/
        if (listvar["tab-object-type"]=="reports")
        {
            tstvar[is_active()]["reports-input-template"]["panel-hidden"]=false
            tstvar[is_active()]["reports-input-template"]["panel-collapsed"]=false
            tstvar[is_active()]["reports-archive-template"]["panel-hidden"]=false

            $("#pl-list-table th :first").before(
                    $("#pl-list-table th :first")
                            .clone()
                            .empty()
            )
            $("#pl-list-table tbody tr").each
            (  function(index){
                        if(tstvar[is_active()]["list-template"]["list-template-generic"]["rows"].length>0){
                        tmpInd=parseInt(index)+1
                        $("#pl-list-table tbody :nth-child("+tmpInd+") td:first")
                                .clone()
                                .html("<input type=\"checkbox\" id=\"pl-list-table-checkbox-"+tmpInd+"\" myId=\""+tmpInd+"\"/>")
                                .insertBefore($("#pl-list-table tbody :nth-child("+tmpInd+") td:first"))
                        }

                    }
            )

            $('#pl-list-table input[type=checkbox]').each(function(){
                var this_id = $(this).parent().next("td").text()
                var used_array = tstvar[is_active()]["reports-input-template"]["checked-items"]
                var el_index = pl_find_array_element(used_array,this_id)
                if (el_index!==(-1))
                {
                    $(this).parents('tr').addClass('success')
                    $(this).attr("checked",true)
                }
            })

            $('#pl-list-table input[type=checkbox]').click(function() {
                if (!$(this).is(':checked')) {

                    $(this).parents('tr').removeClass('success')

                    pl_delete_array_element(tstvar[is_active()]["reports-input-template"]["checked-items"],$(this).parent().next("td").text())
                }
                else{
                    tstvar[is_active()]["reports-input-template"]["checked-items"].push($(this).parent().next("td").text())

                    $(this).parents('tr').addClass('success')
                }
                pl_list_if_checked()
                pl_list_to_reports_input("giveReportsInput")


                    $('#collapseReportsInput')
                            .load(
                            '${createLink(controller: 'Home', action: 'renderReportsInput')}',
                            function(response, status, xhr){

                            }
                    )

            })
        }


        pl_list_paginate(listvar["list-template"]["list-template-generic"]["pagination"][0],listvar["list-template"]["list-template-generic"]["pagination"][1])
        $("#pl-list-before").click(function(e){
            e.preventDefault()
            var myPage = $("#pl-list-paginate-input").val()
            if (myPage>1){
            tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"][0]=parseInt($("#pl-list-paginate-input").val())-1
                pl_list_render_list()
            }

        })
        $("#pl-list-next").click(function(e){
            e.preventDefault()
            var myPage = $("#pl-list-paginate-input").val()

            var items_per_page = tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"][1]
            var maxpages = Math.ceil(tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"][2]/items_per_page)
            if (myPage<maxpages){
                tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"][0]=parseInt($("#pl-list-paginate-input").val())+1
                pl_list_render_list()
            }

        })
        $("#pl-list-paginate-input").change(function(){
            if($(this).val()<=numberOfPages&&$(this).val()>0){
                tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"][0]=parseInt($("#pl-list-paginate-input").val())
                pl_list_render_list()
            }
            else{
                $(this).val(tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"][0])
            }

        })
        $("#pl-list-pagination-select-box").change(function(){
            if ($("#pl-list-pagination-select-box").val()=="alle"){
                if (parseInt(listvar["list-template"]["list-template-generic"]["pagination"][2])>500){

                    tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"][1]=500
                }
                else{
                    tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"][1]=parseInt(listvar["list-template"]["list-template-generic"]["pagination"][2])

                }
            }
            else{
                tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"][1]=parseInt($("#pl-list-pagination-select-box").val())
            }

            pl_list_render_list()
        })
    }

    function pl_lookup_set_value_id( lookFor, element, multiple ){

        //oo("-----------------", lookFor, element);

        multiple = multiple != undefined ? multiple : false;
        lookFor["lookup_code"].toLowerCase();

        if( !multiple ){

            if( isNaN( parseInt(element) ) ){
                lookFor["lookup_value_id_string"]=element
                lookFor["lookup_value_id"]=""
            }
            else{
                lookFor["lookup_value_id"]=element
                lookFor["lookup_value_id_string"]=""
            }
        } else {
            var arr = element.split(',');
            var brr = true;
            for( var i in arr ) if( isNaN( parseInt(i) ) ) brr = false;
            if( brr ){
                lookFor["lookup_value_id_string"]="";
                lookFor["lookup_value_id"]=parseInt( element );
            } else {
                lookFor["lookup_value_id_string"]=element;
                lookFor["lookup_value_id"]="";
            }

        }
        return lookFor

    }

    function pl_list_to_details(link) {
                 
        tstvar[is_active()]["details-template"]["details-template-generic"]["searched-link"] = link;

        var ThisSearch={
            "searched-object":  tstvar[is_active()]["tab-object-type"],
            "search-request": [],
            "pagination": tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"]
        }
        tstvar[is_active()]["details-template"]["panel-hidden"]=false

        pl_list_call_details_controller("Details")
    }

    function pl_list_to_reports(){

    }

    function pl_list_get_currency() {
        return " €"
    }

    function pl_list_if_checked(){
        tmplist=0
        $('#pl-list-table input[type=checkbox]').each(
                function() {
                    if ($(this).is(':checked')){
                        tmplist=tmplist+1
                    }
                }
        );

        if (tmplist==1&&pl_reports_check_input_fields()==true)
        {
            $("#input-reports-do-it-button").removeAttr("disabled")
            pl_list_to_reports()
        }
        else
        {
            $("#input-reports-do-it-button").attr("disabled","disabled")
        }
    }

    function pl_list_to_reports_input(plAction){
        plAction = "giveInputReports"

        var active_tab = is_active()
        var thisSearch = {
            "tab-object-type":tstvar[active_tab]["tab-object-type"],
            "search-request": tstvar[active_tab]["reports-input-template"]["checked-items"]
        }

        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            method:"POST",
            data: {json: JSON.stringify(thisSearch),myAction:"giveInputReports"},
            async:false,
            success: function(dat) {
                tstvar[active_tab]["reports-input-template"]["elements"]={}
                var pointer_var = tstvar[active_tab]["reports-input-template"]["elements"]
                 for (var i in dat["header-names"]) {
                    pointer_var[i.toString()]={}
                    if(dat["row-types"][i]=="date"){
                        pointer_var[i.toString()]["element-type"]="Date Type"
                    }
                    else{
                        pointer_var[i.toString()]["element-type"]="Standard Type"
                    }
                    pointer_var[i.toString()]["header"]=[dat["header-names"][i]]
                    pointer_var[i.toString()]["input"]={}
                    pointer_var[i.toString()]["input"]["value"]= (dat["rows"][i]!=undefined) ? [dat["rows"][i]]:[""]

                    pointer_var[i.toString()]["input"]["type"]=[dat["row-types"][i]]
                    pointer_var[i.toString()]["required"] = true
                   }
            },
            error: function() {
                tstvar[active_tab]["reports-input-template"]["elements"]=[]
                switch (thisSearch["search-request"].length) {
                    default:

                        tstvar[active_tab]["reports-input-template"]["elements"]={
                        "1":{"element-type":"Standard Type",
                            "header":["Bucket ID"],
                            "input":{
                                "value":[""],
                                "type":["currency"]
                            },
                            "required":true

                        },
                        "2":{"element-type":"Standard Type",
                            "header":["Report date"],
                            "input":{
                                "value":[""],
                                "type":["date"]
                            }  ,
                            "required":true
                        },
                        "3":{"element-type":"Standard Type",
                            "header":["Database stamp"],
                            "input":{
                                "value":[""],
                                "type":["date"]
                            },
                            "required":true
                        },
                        "4":{"element-type":"Standard Type",
                            "header":["Report Name"],
                            "input":{
                                "value":[""],
                                "type":["number"],
                                "action":["Controller-Bucket"]
                            },
                            "required":true
                        }

                    }
                        break;
                    case 1:
                            var newTmp = ""
                        for (i in tstvar[active_tab]["list-template"]["list-template-generic"]["rows"]){

                            if ( tstvar[active_tab]["list-template"]["list-template-generic"]["rows"][i][0]==thisSearch["search-request"][0]){

                                newTmp =  tstvar[active_tab]["list-template"]["list-template-generic"]["rows"][i][2]
                            }
                        }
                                if (newTmp == "holiday report"){

                                    tstvar[active_tab]["reports-input-template"]["elements"]={
                                        "1":{"element-type":"Standard Type",
                                            "header":["Bucket ID"],
                                            "input":{
                                                "value":[""],
                                                "type":["currency"]
                                            },
                                            "required":true

                                        },
                                        "2":{"element-type":"Standard Type",
                                            "header":["Report date"],
                                            "input":{
                                                "value":[""],
                                                "type":["date"]
                                            }  ,
                                            "required":true
                                        },
                                        "3":{"element-type":"Standard Type",
                                            "header":["Database stamp"],
                                            "input":{
                                                "value":[""],
                                                "type":["date"]
                                            },
                                            "required":true
                                        },
                                        "4":{"element-type":"Standard Type",
                                            "header":["Report Name"],
                                            "input":{
                                                "value":[""],
                                                "type":["text"]

                                            },
                                            "required":true
                                        },
                                        "5":{"element-type":"Standard Type",
                                            "header":["Hotel"],
                                            "input":{
                                                "value":[""],
                                                "type":["text"]

                                            },
                                            "required":true
                                        },
                                        "6":{"element-type":"Standard Type",
                                            "header":["Country"],
                                            "input":{
                                                "value":[""],
                                                "type":["text"]

                                            },
                                            "required":true
                                        },
                                        "7":{"element-type":"Standard Type",
                                            "header":["year of holiday"],
                                            "input":{
                                                "value":[""],
                                                "type":["number"]

                                            },
                                            "required":true
                                        }

                                    }
                                }
                            else{
                                    tstvar[active_tab]["reports-input-template"]["elements"]={
                                        "1":{"element-type":"Standard Type",
                                            "header":["Bucket ID"],
                                            "input":{
                                                "value":[""],
                                                "type":["currency"]
                                            },
                                            "required":true

                                        },
                                        "2":{"element-type":"Standard Type",
                                            "header":["Report date"],
                                            "input":{
                                                "value":[""],
                                                "type":["date"]
                                            }  ,
                                            "required":true
                                        },
                                        "3":{"element-type":"Standard Type",
                                            "header":["Database stamp"],
                                            "input":{
                                                "value":[""],
                                                "type":["date"]
                                            },
                                            "required":true
                                        },
                                        "4":{"element-type":"Standard Type",
                                            "header":["Report Name"],
                                            "input":{
                                                "value":[""],
                                                "type":["text"]

                                            },
                                            "required":true
                                        },
                                        "5":{"element-type":"Standard Type",
                                            "header":["Bank Name"],
                                            "input":{
                                                "value":[""],
                                                "type":["text"]

                                            },
                                            "required":true
                                        },
                                        "6":{"element-type":"Standard Type",
                                            "header":["Currency"],
                                            "input":{
                                                "value":[""],
                                                "type":["text"]

                                            },
                                            "required":true
                                        },
                                        "7":{"element-type":"Standard Type",
                                            "header":["Calculation Method"],
                                            "input":{
                                                "value":[""],
                                                "type":["number"]

                                            },
                                            "required":true
                                        }

                                    }
                                }
                                 break;
                            }
                tstvar[active_tab]["reports-input-template"]["panel-hidden"]=false
                tstvar[active_tab]["reports-input-template"]["panel-collapsed"]=false
            }
        })
    }

    function pl_list_call_details_controller(pl_action) {
         var ThisSearch={
            "searched-object":  tstvar[is_active()]["tab-object-type"],
            "search-request":[],
            "pagination": [1,10,0]
        }

        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            method:"POST",
            data: {json: JSON.stringify(ThisSearch),myAction:pl_action},
            async:false,
            success: function(dat) {
                pl_list_create_details_tab_structure(dat)
                pl_list_create_details_div_structure(dat["rows"][0][0])
                tstvar[is_active()]["details-template"]["panel-hidden"]=false
                tstvar[is_active()]["details-template"]["panel-collapsed"]=false
                $("#accordion_details_panel").removeClass("hide")
                $('#collapseDetails')
                        .load(
                        '${createLink(controller: 'Home', action: 'renderDetails')}',
                        function(response, status, xhr){
                            $(window).scrollTop($("#collapseDetails").offset().top)
                        }
                )
            },
            error: function(response, status, xhr){
                tstvar[is_active()]["details-template"]["panel-hidden"]=false
                tstvar[is_active()]["details-template"]["panel-collapsed"]=false
                $("#accordion_details_panel").removeClass("hide")
                $("#collapseDetails").myCollapse("show")
                $('#collapseDetails')
                        .empty()
                        .append("<label class=\"label label-warning\">Sorry, this report was not found.</label>")



            }
        })


    }

    function pl_list_create_details_tab_structure(dat){

        tstvar[is_active()]["details-template"]["details-template-generic"]["tabs"]={}
        for (var i in dat["rows"]){
            tstvar[is_active()]["details-template"]["details-template-generic"]["tabs"][dat["rows"][i][0]]={}
            tstvar[is_active()]["details-template"]["details-template-generic"]["tabs"][dat["rows"][i][0]]["label"]=dat["rows"][i][1]
            tstvar[is_active()]["details-template"]["details-template-generic"]["tabs"][dat["rows"][i][0]]["type"]=dat["row-types"][1]
            tstvar[is_active()]["details-template"]["details-template-generic"]["tabs"][dat["rows"][i][0]]["header-name"]=dat["header-names"][1]

        }
    }

    function pl_list_create_details_div_structure(tab){
        var ThisSearch={
            "searched-object":  tstvar[is_active()]["tab-object-type"],
            "search-request":[[tstvar[is_active()]["tab-object-type"],"Tab Id","=",tab]],
            "pagination": [1,10,0]
        }
        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            method:"POST",
            data: {json: JSON.stringify(ThisSearch),myAction:"detailsdiv"},
            async:false,
            success: function(dat_div) {
                var active_tab = is_active()
                if (tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"]==undefined)
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"]={}
                if (ThisSearch["searched-object"]=="Assets"){
                    for (var i in dat_div["rows"]){
                        if (tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][dat_div["rows"][i][2]]==undefined){
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][dat_div["rows"][i][2]]={}
                        }
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][dat_div["rows"][i][2]]["label"]=dat_div["rows"][i][1]
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][dat_div["rows"][i][2]]["type"]=dat_div["row-types"][i]
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][dat_div["rows"][i][2]]["class"]=dat_div["rows"][i][0]
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][dat_div["rows"][i][2]]["element-type"]=dat_div["rows"][i][3]

                    }
                }
                else{
                    for (var i in dat_div["rows"]){

                        if( tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][dat_div["rows"][i][2]]==undefined ){
                            tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][dat_div["rows"][i][0]]={}
                        }
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][dat_div["rows"][i][0]]["label"]=dat_div["rows"][i][1]
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["header-name"]=dat_div["header-names"][i]
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["type"]=dat_div["row-types"][i]
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["class"]=dat_div["rows"][i][2]
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["element-type"]=dat_div["rows"][i][3]
                    }
                }

                for (var i in tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"]) {
                    pl_list_create_detail_div_elements(tab,i)
                }
            },
            error:function(response, status){


            }
        })   
    }

    function pl_list_create_detail_div_elements(tab,div){
        var detailsSearch=[[listvar["tab-object-type"], listvar["list-template"]["list-template-generic"]["header-names"][0],"=",tstvar[is_active()]["details-template"]["details-template-generic"]["searched-link"]]]
        var myPagination = tstvar[is_active()]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][div]["pagination"]

        if (myPagination==undefined){
            myPagination = [1,10,1]
        }

        var ThisSearch={
            "searched-object":  tstvar[is_active()]["tab-object-type"],
            "search-request": detailsSearch,
            "pagination":myPagination
        }
        var dfd = $.Deferred();
        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            method:"POST",
            data: {json: JSON.stringify(ThisSearch),myAction:"details"+"tab"+tab+"div"+div},
            async:false,
            success: function(dat_elements) {
                var active_tab=is_active()
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][div]["rows"]=dat_elements["rows"]
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][div]["header-names"]=dat_elements["header-names"]
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][div]["row-types"]=dat_elements["row-types"]
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][div]["lookup"]=dat_elements["lookup"]

                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][div]["pagination"]=dat_elements["pagination"]
                dfd.resolve()
            },
            error:function(response,status,xhr){
/*
                var active_tab=is_active()
                var dat_elements={
                    "header-names":["Label 1","Label 2","Label 3","Label 4"],
                    "row-types":["text","text","text","text"],
                    "rows": [
                        ["1","2","3","4"]
                    ]
                }


                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][div]["rows"]=dat_elements["rows"]
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][div]["header-names"]=dat_elements["header-names"]
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tab]["divs"][div]["row-types"]=dat_elements["row-types"]*/
                dfd.reject()
            }

        })
        dfd.promise()
    }

    function pl_list_render_list(){

        $.when(pl_search_call_list_controller("list")).then(
            $('#collapseList')
            .load(
                '${createLink(controller: 'Home', action: 'renderList')}',
                function(response, status, xhr){
                    $(window).scrollTop($("#collapseList").offset().top);
                }
            )
        )
    }

    function pl_list_paginate (page, items_per_page){
        var tstvar2 = pl_get_active_tab_data()
        var maxentries = tstvar2["list-template"]["list-template-generic"]["pagination"][2]

        function numPages() {
            return Math.ceil(maxentries/items_per_page);
        }
        numberOfPages =  numPages()
        StringNumPages = "/"+ numberOfPages
        $("#pl-list-pagination li:contains('Number of Pages')").text(StringNumPages)
        $("#pl-list-paginate-input").val(page)

        $("#pl-list-pagination-select-box").val(tstvar2["list-template"]["list-template-generic"]["pagination"][1])
        if($("#pl-list-paginate-input").val()==1){$("#pl-list-pagination a:first").remove()}
        if($("#pl-list-paginate-input").val()==numPages()){$("#pl-list-next").remove()}
    }


</script>

