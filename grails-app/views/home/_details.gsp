<div id="pl-details-template" class="well row-fluid" xmlns="http://www.w3.org/1999/html">
    <div  id="pl-details-template-div">
        <p class="details-label text-info"><strong></strong></p>
        <div class="details-button span3 offset1 hide ">
            <div id="but" class="hide">
                <button class="btn btn-large" type="button">Update details</button>
                <p><br></p>
                <label class="control-label" for="updatedet">Data as of date<span class="pl-detail-fields" id="updatedet">08/03/2013 </span></label>
            </div>
        </div>

        <div class="span3 hide" id="pl-details-table-dummy">
            <form class="form">
                <p class="pl-details-div-header text-info">
                    <strong>

                    </strong>
                </p>
                <div class="control-group " id="pl-details-template-controls-div-dummy" >

                </div>
            </form>
        </div>
        <div id="details-textfield" class="hide">
            <label class = "pl-details-control-label" for="pl-details-control-label" style id="display:inline"></label>
            <div class = "controls"><span class="pl-detail-fields" id="pl-details-control-label"></span>
            </div>
        </div>

        <table class="table table-striped hide" id="pl-details-div-table-dummy">
            <thead>
            <tr>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><a></a>
                </td>

            </tr>
            </tbody>
        </table>
        <div class="hide" id="pl-details-table-pagination-dummy">
            <ol class="pager">
                <li>
                    <a href="#" id="pl-details-table-pagination-before" class="align-left">before
                    </a>
                </li>
                <li>
                    <input class = "pagination-input" type="text" id="pl-details-table-pagination-input" >
                </input>
                </li>

                <li class="pagination-text">
                    Number of Pages:
                </li>
                <li>
                    <a href="#" id="pl-details-table-pagination-next" class="align-right">next
                    </a>
                </li>
                <li>
                    <select class="pagination-select" id="pl-details-table-pagination-select-box">
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

        <div id="details-link" class="hide">
            <label class="pl-details-control-label " for="pl-details-control-label"> </label>
            <div class="controls"><span class="pl-detail-fields" id="pl-details-controls-label"><p><a href="#"></a></p></span></div>
        </div>
    </div>

    <div class="pl-details-button-group">
        <button id="pl-details-edit-button" type="button" class="pl-details-button-group-button hide"><g:message code="edit.edit"/></button>
        <button id="pl-details-delete-button" type="button" class="pl-details-button-group-button hide"></i><g:message code="edit.delete"/></button>
    </div>
</div>

<div id="pl-subdetails-template" class="well ">
    <h5 class="text-info hide" id="pl-sub-details-sub-table-header" style="font-size:8pt"><strong></strong></h5>
    <div class="sub-details-tab-content tab-pane hide" id=""></div>
    <li class="sub-details-tab hide"><a href="#"  data-toggle="tab"></a></li>
    <div style="border:1px solid #e6e6e6; background-color:#ffffff">
        <ul class="nav nav-tabs" id="myTab" style="margin-bottom:0px;">

        </ul>

        <div id="pl-subdetails-template-linksdiv" class="hide">
            <table id="pl-subdetails-template-linkstable" class="pl-details-linkstable">
                <tr>
                    <th>Klasse</th>
                    <th>ID</th>
                </tr>
                <tr id="pl-subdetails-template-linkstable-row" class="">

                </tr>

            </table>
        </div>

        <div id="pl-subdetails-template-docsdiv" class="hide">
            <table id="pl-subdetails-template-docstable" class="pl-details-linkstable">

                <thead>
                <tr>
                    <th id="pl-subdetails-template-docstable-head" class="hide"></th>
                </tr>
                </thead>

                <tbody>
                <tr id="pl-subdetails-template-docstable-row" class="hide">

                </tr>
                </tbody>

            </table>
            <div id="pl-subdetails-upload" class="controll-group">
                <div id="pl-subdetails-upload-field">
                    <uploader:uploader
                            id="uploadDetails"
                            url="${[controller:'home', action:'upload']}"
                            params="${[ source: "details" ]}"
                            multiple="false">
                        <uploader:onComplete> pl_details_reload_documents(); </uploader:onComplete>
                    </uploader:uploader>
                </div>
            </div>
        </div>

        <div id="pl-subdetails-template-cashflowsdiv" class="hide">
            <div>
                <table id="pl-subdetails-template-cashflowsdiv-table1" class="pl-details-linkstable">
                    <tr>
                        <td>Kreditbetrag:</td>
                    </tr>
                    <tr>
                        <td>davon ausgezahlt:</td>
                    </tr>
                    <tr>
                        <td>Zinsen:</td>
                    </tr>
                    <tr>
                        <td>Servicegebühr:</td>
                    </tr>
                    <tr>
                        <td>Pflichtberatung:</td>
                    </tr>
                    <tr>
                        <td>Gesamt: </td>
                    </tr>
                    <tr>
                        <td>davon bezahlt: </td>
                    </tr>
                    <tr>
                        <td>noch offen: </td>
                    </tr>
                </table>
            </div>

            <div>
                <table id="pl-subdetails-template-cashflowsdiv-table2" class="pl-details-linkstable">
                    <thead>
                    <tr>
                        <th>Status</th><th>Kreditnehmer</th><th>Datum</th><th>Typ</th><th>Kontrollwert</th><th>Referenz</th><th>Zahlungsdatum</th><th>Betrag</th><th>Verzug</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>

                </table>
            </div>

        </div>

        <div class="tab-content" id="tabcontent"></div>
    </div>
</div>

%{--Holger: Prüfe ob der Benutzer die Rolle ADMIN hat und merke das Ergebnis in Variable "isAdmin"--}%
<g:set var="isAdmin" value="${sec.ifAllGranted(roles: 'ROLE_ADMIN', "true")}" />

<g:if test="${request.xhr}">
    <r:layoutResources disposition="defer"/>
</g:if>


<script type="text/javascript">

    $(document).ready(function () {

        var tstvar2 = pl_get_active_tab_data()
        if (tstvar[is_active()]["details-template"]["panel-hidden"]===false){
            $("#accordion_details_panel").removeClass("hide")

            pl_details_init()
            if (tstvar[is_active()]["details-template"]["panel-collapsed"]==false){
                $("#collapseDetails").myCollapse("show")
            }
            else $("#collapseDetails").myCollapse("hide")
        }
        else {
            if(!$("#accordion_details_panel").hasClass("hide"))
            $("#accordion_details_panel").addClass("hide")
        }

        if( tstvar[is_active()]["tab-object-type"] != "documents"){ //Holger: Dokumente sollten nicht editierbar sein
            $('#pl-details-edit-button').removeClass("hide")
            $('#pl-details-edit-button').click( function(){ pl_details_open_edit_tab( tstvar[is_active()]["details-template"]["details-template-generic"]["searched-link"] ) } )
        }

        $('#pl-details-delete-button').removeClass("hide")
        $('#pl-details-delete-button').click( function(){
            pl_details_delete_data( tstvar[is_active()]["details-template"]["details-template-generic"]["searched-link"], tstvar[is_active()]["tab-object-type"], "list"  )
        })

    })

    function pl_details_init(){
            $("#accordion_details_panel").removeClass("hide")
            pl_details_body_init()
    }

    function pl_details_body_init() {

        tstvar2 = pl_get_active_tab_data()

        switch (tstvar[is_active()]["tab-object-type"]) {
            case "buckets":
                break;

            default:
                pl_details_input_label()
                pl_details_create_elements()
        }
    }

    function pl_details_input_label() {
        tstvar2 = pl_get_active_tab_data()
        $('.details-label')
                .find("strong")
                .text(tstvar2["details-template"]["details-template-generic"]["tabs"]["0"]["label"])
    }

    function pl_details_create_elements(){

        active_tab=  is_active()
        var tabs = tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"]
        var tabsArray =[]
        var tabsIndex=[]
        for (var i in tabs ){
            if( tabs[i]["label"] == "Links" ){
                if( '${isAdmin}' == "true" ){
                    tabsIndex.push(i)
                    tabsArray.push(tabs[i])
                }
            } else {
                tabsIndex.push(i)
                tabsArray.push(tabs[i])
            }
        }

        pl_details_create_content($("#pl-details-template-div"),tabsArray[0],tabsIndex[0])
        tabsArray.shift()
        tabsIndex.shift()
        for ( var i in tabsArray){
            $('#myTab')
                    .append(
                            $(".sub-details-tab")
                                    .clone()
                                    .removeClass("hide")
                                    .removeClass("sub-details-tab")
                                    .addClass("sub-details-tab"+tabsIndex[i])
                                    .attr("id","pl-sub-details-tab-"+tabsIndex[i])
                                    .find("a")
                                    .attr("href",("#"+tabsIndex[i]))
                                    .text(tabsArray[i]["label"])
                                    .end()
                    )
            $('#tabcontent')
                    .append(
                            $(".sub-details-tab-content")
                                    .clone()
                                    .removeClass("hide")
                                    .attr('id',"pl-details-"+tabsIndex[i]+"-content")
                    )
            if (tabsArray[i].active==true){
                pl_details_create_content($("#tabcontent"),tabsArray[i],tabsIndex[i])
                $("#pl-sub-details-tab-"+tabsIndex).addClass("active")
            }
        }

    }

    function pl_details_create_table($container,divIndex,divArray,tabIndex) {                        //Tabelleninhalt erstellen

        //Variablendeklaration
        var active_tab = is_active()
        var content = divArray["rows"]
        var headers = divArray["header-names"]
        var types = divArray["row-types"]
        var containerTable = "pl-details-div-table-"+tabIndex+"-"+divIndex
        var $containerTable = $("pl-details-div-table-"+tabIndex+"-"+divIndex)
        if (tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"]==undefined){

            tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"]=[1,10,1]
        }

        var items_per_page = tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][1]
        var maxentries = tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][2]
        function numPages() {
            return Math.ceil(maxentries/items_per_page);
        }
        StringNumPages =  "/"+numPages()
        $("#pl-details-div-table-"+tabIndex+"-"+divIndex).remove()
        $("#pl-details-table-pagination-"+tabIndex+"-"+divIndex).remove()

        $container.append(
                $("#pl-details-div-table-dummy").clone()
                        .removeClass("hide")
                        .attr("id",containerTable)
        )
        for (var i in headers) {

            $("#"+containerTable+" tr:last").before(
                    $("#"+containerTable+" th:last")
                            .clone()
                            .text(headers[i])

            )
        }
        $container.append(
                $("#pl-details-table-pagination-dummy").clone()
                        .removeClass("hide")
                        .attr("id","pl-details-table-pagination-"+tabIndex+"-"+divIndex)
                        )

        $("#pl-details-table-pagination-"+tabIndex+"-"+divIndex+" input")
                .attr("id","pl-details-table-pagination-input-"+tabIndex+"-"+divIndex)
                .val(tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][0])
                .change(function(){

                    if ($(this).val()<=numPages()){
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][0]=$(this).val()
                        $.when(pl_list_create_detail_div_elements(tabIndex,divIndex)).then(
                                $('#tablecontent >div')
                                        .load(pl_details_create_table($container,divIndex,divArray,tabIndex)
                                        )
                        )
                    }
                    else{
                        $(this).val(tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][0])
                    }

                })
        $("#pl-details-table-pagination-"+tabIndex+"-"+divIndex+" a:first")
                .attr("id","pl-details-table-pagination-before-"+tabIndex+"-"+divIndex)
                .click(function(e){

                    e.preventDefault()
                    var _this = $(this)

                    var myPage = $("#pl-details-table-pagination-input-"+tabIndex+"-"+divIndex).val()

                    if (myPage>1){
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][0]=parseInt(myPage)-1
                        $.when(pl_list_create_detail_div_elements(tabIndex,divIndex)).then(
                                $('#tablecontent >div')
                                        .load(pl_details_create_table($container,divIndex,divArray,tabIndex)

                                        )
                        )
                    }
                })
        $("#pl-details-table-pagination-"+tabIndex+"-"+divIndex+" a:last")
                .attr("id","pl-details-table-pagination-next-"+tabIndex+"-"+divIndex)
                .click(function(e){
                    var _this = $(this)
                    e.preventDefault()
                    var myPage = $("#pl-details-table-pagination-input-"+tabIndex+"-"+divIndex).val()
                    var items_per_page = tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][1]
                    var maxpages = Math.ceil(tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][2]/items_per_page)

                    if (myPage<maxpages){
                        tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][0]=parseInt(myPage)+1
                        $.when(pl_list_create_detail_div_elements(tabIndex,divIndex)).then(
                                $('#tablecontent >div')
                                        .load(pl_details_create_table($container,divIndex,divArray,tabIndex)

                                        )
                        )
                    }
                })
        $("#pl-details-table-pagination-"+tabIndex+"-"+divIndex+" li:contains('Number of Pages')").text(StringNumPages)

        if($("#pl-details-table-pagination-input-"+tabIndex+"-"+divIndex).val()<=1){$("#pl-details-table-pagination-"+tabIndex+"-"+divIndex+" a:first").remove()}

        if($("#pl-details-table-pagination-input-"+tabIndex+"-"+divIndex).val()==numPages()){$("#pl-details-table-pagination-next-"+tabIndex+"-"+divIndex).remove()}

        for (var i in content) {

            $("#"+containerTable+" tr:last").after(
                    $("#"+containerTable+" tbody tr:first")
                            .clone()
                            .attr("id",containerTable+"-row-number-"+i)

            )
            for (var j in content[i]) {

                if (types[j][0]=="{"){
                    $("#"+containerTable+" tbody tr:last td:last").before(
                        $("#"+containerTable+" tbody tr:last td:last")
                                .clone()
                                .append("<a href=\"#\">"+content[i][j]+"</a>")
                                .click(function(e){
                                    e.preventDefault()
                                    var obj_index = parseInt($(this).index())+1
                                    var header_name = $(this).parents("table").find("th").eq(obj_index).text()
                                    pl_which_action(types[j],content[i][j],header_name)
                                })
                )}
                else {
                    $("#"+containerTable+" tbody tr:last td:last").before(
                            $("#"+containerTable+" tbody tr:last td:last")
                                    .clone()
                                    .text(content[i][j])

                    )
                }

            }
        }


        /************************************
         * Manipulation der Spalteneinträge,*
         ******* je nach Spaltentyp *********
         * **********************************/

        $("#"+containerTable+" tbody tr:first").remove()
        $("#pl-details-table-pagination-"+tabIndex+"-"+divIndex+" select")
                .attr("id","pl-details-table-pagination-select-box-"+tabIndex+"-"+divIndex)
                .val(tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][1])
                .change(function(){
            if ($(this).val()=="alle"){
                if (parseInt(tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][2])>500){

                    tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][1]=500
                }
                else{
                    tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][1]=parseInt(tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][2])

                }
            }
            else{
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tabIndex]["divs"][divIndex]["pagination"][1]=parseInt($("#pl-details-table-pagination-select-box-"+tabIndex+"-"+divIndex).val())
            }

                    $.when(pl_list_create_detail_div_elements(tabIndex,divIndex)).then(
                            $('#tablecontent >div')
                                    .load(pl_details_create_table($container,divIndex,divArray,tabIndex)

                                    )
                    )
        })
    }

    function pl_details_create_content($container,tabArray,tabIndex){

        //Holger: Dokumente Tabelle verstecken
        if( tabArray["label"]!="Dokumente" && tabArray["label"]!="Agenda" ) $(document).find('#pl-subdetails-template-docsdiv').addClass('hide');


        for (var i in tabArray["divs"]){

            var tableDivId = "pl-details-template-controls-div-"+tabIndex+"-"+i
            var tableId=  "pl-details-table-"+tabIndex+"-"+i
            if(tabArray["divs"][i]["element-type"]=="table"){
                pl_details_create_table($container,i,tabArray["divs"][i],tabIndex)
            }
            else if(tabArray["type"]=="html"){
                $container.empty()
                $container.append(tabArray["divs"][i]["element-type"])
                $("img[id^='reportpage']").each(function(){ this.src = 'reports/'+this.id + '?' + Math.random() })

                //$container.load((tabArray["divs"][i]["element-type"]))
            }
            else{
                $container.append(
                        $("#pl-details-table-dummy")
                                .clone()
                                .removeClass("hide")
                                .addClass(tabArray["divs"][i]["class"])
                                .attr("id",tableId)
                                .find("strong")
                                .text(tabArray["divs"][i]["label"])
                                .end()
                                .find("#pl-details-template-controls-div-dummy")
                                .attr('id',tableDivId)
                                .end()
                )
                var $tableDivId = $("#pl-details-template-controls-div-"+tabIndex+"-"+i)
                var $tableId=$("#pl-details-table-"+tabIndex+"-"+i)

                $tableDivId.append(
                        $("#p-sub-details-sub-table-header")
                                .clone()
                                .removeClass("hide")
                                .attr("id","pl-sub-details-sub-table-header-"+tabIndex+i)
                                .attr("id","sublabel-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["label"])
                                .show()
                                .find("strong")
                                .text(tabArray["divs"][i]["label"])
                                .end()
                )
                for (var j in tabArray["divs"][i]["header-names"]){

                    var thisType = JSON.parse( tabArray["divs"][i]["row-types"][j] )["row-type"];
                    switch (pl_get_object_type(thisType)){
                        case "Object":
                            $tableDivId.append( $("#details-link")
                                    .clone()
                                    .attr('id',"details-link"+tabIndex+"-"+i+j)
                                    .removeClass("hide")
                                    .addClass("link")
                                    .find(".pl-details-control-label")
                                    .text(tabArray["divs"][i]["header-names"][j])
                                    .addClass(tabArray["divs"][i]["header-names"][j])
                                    .attr('for',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                    .end()
                                    .find(".controls")
                                    .find("span")
                                    .find("a")
                                    .data("type",thisType)
                                    .click(function(e){
                                        e.preventDefault()

                                        var header_name=$(this).attr("rel")
                                        pl_which_action(JSON.stringify($(this).data("type")),$(this).text(),header_name)
                                    })

                                    .text(tabArray["divs"][i]["rows"][0][j])
                                    .attr('id',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                    .attr("rel",tabArray["divs"][i]["header-names"][j])
                                    .end()
                                    .end()
                                    .end()
                            )
                            break;
                        case "String":

                            switch (thisType) {
                                case "text":
                                    $tableDivId.append($("#details-textfield")
                                            .clone()
                                            .attr('id',"details-textfield"+tabIndex+"-"+i+j)
                                            .removeClass("hide")
                                            .find(".pl-details-control-label")
                                            .text(tabArray["divs"][i]["header-names"][j])
                                            .addClass(tabArray["divs"][i]["header-names"][j])
                                            .attr('for',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .find(".controls")
                                            .find("span")
                                            .text(tabArray["divs"][i]["rows"][0][j])
                                            .attr('id',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .end()
                                    )
                                    break;

                                case "url":
                                    var tmpUrl = tabArray["divs"][i]["rows"][0][j];
                                    $tableDivId.append($("#details-textfield")
                                        .clone()
                                        .attr('id',"details-textfield"+tabIndex+"-"+i+j)
                                        .removeClass("hide")
                                        .find(".pl-details-control-label")
                                        .text(tabArray["divs"][i]["header-names"][j])
                                        .addClass(tabArray["divs"][i]["header-names"][j])
                                        .attr('for',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                        .end()
                                        .find(".controls")
                                        .find("span")
                                        .css("cursor","pointer")
                                        .click( function(event){
                                            window.open(tmpUrl);
                                            event.preventDefault();} )
                                        .text(tmpUrl)
                                        .attr('id',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                        .end()
                                        .end()
                                    )
                                    break;

                                case "mailto":
                                    var tmpMail = tabArray["divs"][i]["rows"][0][j];
                                    $tableDivId.append($("#details-textfield")
                                            .clone()
                                            .attr('id',"details-textfield"+tabIndex+"-"+i+j)
                                            .removeClass("hide")
                                            .find(".pl-details-control-label")
                                            .text(tabArray["divs"][i]["header-names"][j])
                                            .addClass(tabArray["divs"][i]["header-names"][j])
                                            .attr('for',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .find(".controls")
                                            .find("span")
                                            .css("cursor","pointer")
                                            .click( function(event){
                                                window.location = "mailto:"+tmpMail;
                                                event.preventDefault();} )
                                            .text( tmpMail )
                                            .attr('id',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .end()
                                    )
                                    break;

                                case "lookup":

                                    var tmpL = pl_lookup_set_value_id( JSON.parse( tabArray["divs"][i]["lookup"][j] ), tabArray["divs"][i]["rows"][0][j] );
                                    tmpL = find_lookup_value( tmpL );

                                    $tableDivId.append($("#details-textfield")
                                            .clone()
                                            .attr('id',"details-textfield"+tabIndex+"-"+i+j)
                                            .removeClass("hide")
                                            .find(".pl-details-control-label")
                                            .text(tabArray["divs"][i]["header-names"][j])
                                            .addClass(tabArray["divs"][i]["header-names"][j])
                                            .attr('for',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .find(".controls")
                                            .find("span")
                                            .text(tmpL)
                                            .attr('id',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .end()
                                    )
                                    break;

                                case "lookupmulti":

                                    var tmpLm = [];
                                    var arr = tabArray["divs"][i]["rows"][0][j].split(",");
                                    for( k=0; k < arr.length; k++ ){
                                        if( arr[k] != "" ){
                                            var tmp2 = pl_lookup_set_value_id( JSON.parse( tabArray["divs"][i]["lookup"][j] ), arr[k] );
                                            tmpLm.push( find_lookup_value( tmp2 ) );
                                        }
                                    }
                                    tmpLm = tmpLm.join(',');

                                    $tableDivId.append($("#details-textfield")
                                            .clone()
                                            .attr('id',"details-textfield"+tabIndex+"-"+i+j)
                                            .removeClass("hide")
                                            .find(".pl-details-control-label")
                                            .text(tabArray["divs"][i]["header-names"][j])
                                            .addClass(tabArray["divs"][i]["header-names"][j])
                                            .attr('for',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .find(".controls")
                                            .find("span")
                                            .text(tmpLm)
                                            .attr('id',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .end()
                                    )
                                    break;

                                case "lookupdomain":

                                    var tmpL = pl_lookup_set_value_id( JSON.parse( tabArray["divs"][i]["lookup"][j] ), tabArray["divs"][i]["rows"][0][j] );
                                    tmpL = find_lookup_value( tmpL );
                                    tmpL = find_domain_lookup( tmpL );

                                    $tableDivId.append($("#details-textfield")
                                            .clone()
                                            .attr('id',"details-textfield"+tabIndex+"-"+i+j)
                                            .removeClass("hide")
                                            .find(".pl-details-control-label")
                                            .text(tabArray["divs"][i]["header-names"][j])
                                            .addClass(tabArray["divs"][i]["header-names"][j])
                                            .attr('for',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .find(".controls")
                                            .find("span")
                                            .text(tmpL)
                                            .attr('id',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .end()
                                    )
                                    break;

                                case "number":
                                case "float":
                                case "pointer":
                                    var tmpNr = (tabArray["divs"][i]["rows"][0][j]==null) ? "" : tabArray["divs"][i]["rows"][0][j];
                                    $tableDivId.append($("#details-textfield")
                                            .clone()
                                            .attr('id',"details-textfield"+tabIndex+"-"+i+j)
                                            .removeClass("hide")
                                            .find(".pl-details-control-label")
                                            .text(tabArray["divs"][i]["header-names"][j])
                                            .addClass(tabArray["divs"][i]["header-names"][j])
                                            .attr('for',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .find(".controls")
                                            .find("span")
                                            .text(tmpNr)
                                            .attr('id',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .end()
                                    )
                                    break;

                                case "date":
                                case"datetime":
                                    var tmpDate = (tabArray["divs"][i]["rows"][0][j]==null) ? "" : tabArray["divs"][i]["rows"][0][j];
                                    $tableDivId.append($("#details-textfield")
                                            .clone()
                                            .attr('id',"details-textfield"+tabIndex+"-"+i+j)
                                            .removeClass("hide")
                                            .find(".pl-details-control-label")
                                            .text(tabArray["divs"][i]["header-names"][j])
                                            .addClass(tabArray["divs"][i]["header-names"][j])
                                            .attr('for',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .find(".controls")
                                            .find("span")
                                            .text(tmpDate)
                                            .attr('id',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                            .end()
                                            .end()
                                    )
                                    break;


                                default:

                                    $tableDivId.append($("#details-textfield")
                                        .clone()
                                        .attr('id',"details-textfield"+tabIndex+"-"+i+j)
                                        .removeClass("hide")
                                        .find(".pl-details-control-label")
                                        .text(tabArray["divs"][i]["header-names"][j])
                                        .addClass(tabArray["divs"][i]["header-names"][j])
                                        .attr('for',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                        .end()
                                        .find(".controls")
                                        .find("span")
                                        .text(tabArray["divs"][i]["rows"][0][j])
                                        .attr('id',"pl-details-control-label-"+tabIndex+"-"+i+"-"+tabArray["divs"][i]["header-names"][j])
                                        .end()
                                        .end()
                                )
                                    break;
                            }
                    }
                }
            }
        }

        // Holger: Anzeige von Links
        if( tabArray["label"]=="Links" ){

            $.ajax({
                url: "${createLink(controller: 'home', action: 'request')}",
                data: {json : JSON.stringify( {"id": tstvar[is_active()]["details-template"]["details-template-generic"]["searched-link"],
                    "klasse" : find_lookup_value( pl_lookup_set_value_id( {"lookup_code":"links.klasse"}, tstvar[is_active()]["tab-object-type"] ) ) } ),
                    myAction : "getLinks"},
                async: false,
                success: function(dat) {

                    if( dat != undefined && dat != [] ){
                        var tabc = $(document).find('#tabcontent');
                        var div = $(document).find('#pl-subdetails-template-linksdiv').clone();
                        var tab = div.find('#pl-subdetails-template-linkstable');
                        var kl, id, kl0;

                        $.each( dat, function(i, c){

                            kl1 = find_lookup_value( pl_lookup_set_value_id( {"lookup_code":"links.klasse"}, c["klasse1"] ) );
                            kl2 = find_lookup_value( pl_lookup_set_value_id( {"lookup_code":"links.klasse"}, c["klasse2"] ) );

                            if( kl1 == tstvar[is_active()]["tab-header"] ){
                                kl = kl2;
                                id = c["id2"];
                            } else {
                                kl = kl1;
                                id = c["id1"];
                            }

                            var tr = tab.find("tr[id='pl-subdetails-template-linkstable-row']").clone();
                            tr.append( "<td>" + find_domain_lookup( kl ) + "</td><td>" + id + "</td>" );
                            tr.attr( 'id', 'pl-subdetails-template-linkstable-row-'+i) ;
                            tr.click( function(){ pl_details_open_links_tab(kl,id) });
                            tab.append( tr );

                        });

                        div.attr('id','pl-subdetails-template-linksdiv-1');
                        div.removeClass("hide");
                        tabc.prepend( div );
                    }

                },
                error: function(response, status, xhr){
                    alert("Links konnten nicht abgerufen werden. Bitte kontaktieren Sie Ihren Admin.");
                }
            });
        }

        // Holger: Dokumente @ Kontakte
        if( tabArray["label"]=="Dokumente" ){

            $("#pl-subdetails-template-docstable > thead").find("th:not([class*=hide])").remove();
            $("#pl-subdetails-template-docstable > tbody").find("tr:not([class*=hide])").html("");
            $("#pl-subdetails-template-docsdiv").off( "click" );

            var klasse = find_lookup_value( pl_lookup_set_value_id( {"lookup_code":"links.klasse"}, tstvar[is_active()]["tab-object-type"] ) );
            var id = tstvar[is_active()]["details-template"]["details-template-generic"]["searched-link"];
            var ThisSearch={
                "searched-object": "Documents",
                "tab-type": "SubtabDocuments",
                "search-request": ["id in (select id2 from links where klasse1 = " + klasse + " and id1 = " + id + " union all select id1 from links where klasse2 = " + klasse + " and id2 = " + id + ")"],
                "pagination": [1,10,0]
            }

            $.ajax({
                url: "${createLink(controller: 'home', action: 'request')}",
                method:"POST",
                data: { json: JSON.stringify( ThisSearch ), myAction:"list"},
                async:false,
                success: function(dat) {
                    if( dat != undefined && dat != [] ){

                        var tabc = $(document).find('#tabcontent');
                        var div = $(document).find('#pl-subdetails-template-docsdiv');
                        var tab = div.find('#pl-subdetails-template-docstable');
                        var uuid = '';

                        $.each( dat["header-names"], function(i, c){
                            if( c != "UUID" ){
                                var th = tab.find("th[id='pl-subdetails-template-docstable-head']").clone();
                                th.attr('id','pl-subdetails-template-docstable-head-'+i);
                                th.text(c);
                                th.removeClass('hide');
                                tab.find("thead > tr").append( th );
                            }
                        });

                        $.each( dat["rows"], function(i, c){

                            var tr = tab.find("tr[id='pl-subdetails-template-docstable-row']").clone();
                            tr.attr('id','pl-subdetails-template-docstable-row-'+i);

                            $.each( c, function(j, d){
                                var header = dat["header-names"][j];
                                if( header == "Download" ){
                                    tr.append("<td><a href='/home/download?json=" + uuid + "'> Download </a></td>");
                                }
                                else if( header == "Löschen" ){
                                    tr.append("<td id='pl-subdetails-template-docstable-del-"+i+"'><a>Löschen</a></td>");
                                }
                                else if( header == "UUID" ){
                                    uuid = d;
                                }
                                else tr.append("<td>" + d + "</td>");

                            });
                            tr.removeClass('hide');
                            tab.find("tbody").append( tr );

                            $("#pl-subdetails-template-docsdiv").on( "click", "#pl-subdetails-template-docstable-del-"+i+" > a",function(ev){
                                pl_details_delete_data( c[ dat["header-names"].indexOf("ID") ], "documents", "details" );
                                ev.preventDefault();
                                ev.stopPropagation();
                                return false;
                            });
                        });
                        div.removeClass("hide");
                    }
                },
                error: function(response, status, xhr){

                }
            });
        }

        // Holger: Kontobewegungen @ Kontakte
        if( tabArray["label"].indexOf("Konto") > -1 ){

            $.ajax({
                url: "${createLink(controller: 'home', action: 'request')}",
                method:"POST",
                data: {json: JSON.stringify( { "id": tstvar[is_active()]["details-template"]["details-template-generic"]["searched-link"] } ),
                    myAction:"getKonto" },
                async:false,
                success: function(dat) {
                    if( dat != undefined && dat != [] ){
                        var tabc = $(document).find('#tabcontent');
                        var div = $(document).find('#pl-subdetails-template-cashflowsdiv').clone();

                        var kreditbetrag = 0, ausgezahlt = 0, zinsen = 0, service = 0, pflicht = 0, gesamt = 0, bezahlt = 0, offen = 0,
                                verzug, cfc;

                        $.each( dat, function(i, c){

                            cfc = c["zahlungsdatum"]!=null;
                            switch( c["typ"] ){

                                case 3: //Auszahlung
                                    kreditbetrag -= c["kontrollwert"];
                                    if( cfc ) ausgezahlt -= c["betrag"];
                                    break;
                                case 4: //Servicegebühr
                                    service += c["kontrollwert"];
                                    zinsen += c["kontrollwert"];
                                    if( cfc ) bezahlt += c["betrag"];
                                    break;
                                case 6: //Pflichtberatung
                                    pflicht += c["kontrollwert"];
                                    if( cfc ) bezahlt += c["betrag"];
                                    break;
                                case 2: //Rückzahlung
                                    zinsen += c["kontrollwert"];
                                    if( cfc ) bezahlt += c["betrag"];
                                    break;
                            }

                            verzug = "";
                            cfc = c["zahlungsdatum"]!=null;
                            if( cfc  ){
                                verzug = (new Date( c["zahlungsdatum"].substr(0,10) ) ).getTime() - (new Date( c["zeitpunkt"].substr(0,10) ) ).getTime();
                                verzug = Math.ceil( verzug /1000/60/60/24 );
                                if( verzug <= 0 ) verzug = ""; else verzug = verzug + " Tage";
                            }

                            if( [2,3,4,6].indexOf( c["typ"] ) > - 1 ){
                                var tmp = "<tr>";
                                tmp += (cfc)
                                        ? "<td><img src='images/icons/accept.png'></td>"
                                        : "<td><img src='images/icons/cancel.png'></td>";
                                tmp += "<td>" + c["name"]+"</td>";
                                tmp += "<td>" + c["zeitpunkt"].substr(0,10) + "</td>";
                                tmp += "<td>" + find_lookup_value( pl_lookup_set_value_id( {"lookup_code":"agenda.typ"}, c["typ"] ) ) + "</td>";
                                tmp += "<td>" + parseFloat(Math.round(c["kontrollwert"] * 100) / 100).toFixed(2) + " € </td>";
                                tmp += "<td>" + c["beschreibung"] + "</td>";
                                tmp += (cfc)
                                        ? "<td>" + c["zahlungsdatum"].substr(0,10) + "</td>"
                                        : "<td></td>";
                                tmp += "<td>" + parseFloat(Math.round(c["betrag"] * 100) / 100).toFixed(2) + " € </td>";
                                tmp += "<td>" + verzug + "</td>";
                                tmp += "<tr>";
                                tmp = tmp.replace("<td>null</td>","<td></td>");
                                div.find('#pl-subdetails-template-cashflowsdiv-table2 > tbody').append(tmp);
                            }
                        });

                        zinsen = zinsen - kreditbetrag;
                        gesamt = kreditbetrag + zinsen + pflicht;
                        offen = gesamt - bezahlt;
                        var werteArray = [ kreditbetrag, ausgezahlt, zinsen, service, pflicht, gesamt, bezahlt, offen ];

                        var t1 = div.find('#pl-subdetails-template-cashflowsdiv-table1');
                        $.each( t1.find("tr"), function(i){
                            $(this).append("<td>" + parseFloat(Math.round(werteArray[i] * 100) / 100).toFixed(2) + " €</td>");
                        });

                        div.removeClass("hide");
                        tabc.prepend( div );

                    }

                },
                error: function(response, status, xhr){
                    alert("Kontoinformationen konnten nicht abgerufen werden. Bitte kontaktieren Sie Ihren Admin.");
                }
            });
        }

        // Holger: Download Button @ Details
        if( tstvar[is_active()]["tab-object-type"]=="documents" ){

            var link = "<a href='/home/download?json="
            link = link + tstvar[is_active()]["details-template"]["details-template-generic"]["tabs"][0]["divs"][0]["rows"][0][4]
            link = link + "'> Dokument herunterladen </a>"
            $('#pl-details-table-0-0').append( "<div id='pl-download-button' class='pl-details-download-button'>" + link + "</div>" )

        }

    }


    /*
     *
     * Tabs aktiv machen*/


    $('#myTab > li ').click(function (e) {
        e.preventDefault()
        var active_tab=is_active()
        var details_tab = $(this).find("a").attr("href").split("#")
        details_tab=details_tab[1]
        pl_details_set_active_tab(details_tab)
        if (tstvar[active_tab]["tab-object-type"]!="reports")  pl_list_create_details_div_structure(details_tab,details_tab)
        $("#tabcontent").empty()
        pl_details_create_content($("#tabcontent"),tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][details_tab],details_tab)
        if ($(this).relatedTarget === null) {
            $(this).relatedTarget.removeClass("active");
        }


    })

    function pl_details_set_active_tab(tab) {
        active_tab=is_active()
        $.each(tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"], function (key, value) {
            tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][key].active = false;
            if (key == tab) {
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][key].active = true
            }
        })
    }

    function pl_details_open_edit_tab(id){

        var obj = "{\"action\":\"newTab\",\"tab-object-type\":\""
        var obj = obj + tstvar[is_active()]["tab-object-type"]
        var obj = obj + "\",\"search-template\":{\"panel-hidden\":true},\"list-template\":{\"panel-hidden\":true},\"edit-template\":{\"panel-hidden\":false},\"sql-search\":\"id=#value#\"}"
        var val = id
        var name = "ID"

        pl_which_action( obj, val, name )
    }

    function pl_details_delete_data(id, domain, render){

        if( render == undefined) render = "";
        var domain_id = find_lookup_value( pl_lookup_set_value_id( {"lookup_code":"links.klasse"}, domain ) );

        if( confirm( gui_messages["delete.confirm.text"] ) == true ){

            if( domain == undefined ) domain = tstvar[is_active()]["tab-object-type"];

            $.ajax({
                url: "${createLink(controller: 'home', action: 'request')}",
                method:"POST",
                data: {
                    json: JSON.stringify( { 'id':id, 'domain':domain, 'domain_id':domain_id } ),
                    myAction:"deleteData",
                    klasse: domain },
                async: false,
                dataType: "json",
                success: function(dat) {
                    if( dat["success"]==true ){
                        alert("Datensatz gelöscht.");
                        tstvar[is_active()]["details-template"]["panel-hidden"] = true;
                        tstvar[is_active()]["details-template"]["panel-collapsed"] = true;
                        $('#accordion_details_panel').addClass("hide");
                        if( render == "list" ){
                            pl_search_call_list_controller("list");
                            pl_list_render_list();
                        } else if( render == "details" ){
                            pl_details_reload_documents();
                            $('#au-uploadDetails').find('.qq-upload-list').empty();
                        }
                    } else if(dat["event"]!=undefined){
                        if(dat["event"]["errorCode"]==1451) alert("Sie können keinen Datensatz löschen, der mit einem anderen Datensatz verknüpt ist.");
                    } else alert("Löschung aus unbekanntem Grund fehlgeschlagen. Bitte kontaktieren Sie Ihren Admin.");
                },
                error: function(dat){
                    if(dat["event"]!=undefined){
                        if(dat["event"]["errorCode"]==1451) alert("Sie können keinen Datensatz löschen, der mit einem anderen Datensatz verknüpt ist.");
                    }
                    else alert("Löschung aus unbekanntem Grund fehlgeschlagen. Bitte kontaktieren Sie Ihren Admin.")
                }
            });
        }
    }

    function pl_details_open_links_tab(domain,id){

        var obj = "{\"action\":\"newTab\",\"tab-object-type\":\""
        var obj = obj + domain
        var obj = obj + "\",\"search-template\":{\"panel-hidden\":true},\"edit-template\":{\"panel-hidden\":true},\"upload-template\":{\"panel-hidden\":true},\"sql-search\":\"id=#value#\"}"
        var val = id
        var name = "ID"
        $( document ).ready(function() {
            pl_which_action( obj, val, name );
        });
    }

    function pl_details_reload_documents(){
        $("#accordion_details_panel").removeClass("hide");
        var tmp = $('#myTab').find("a").filter( function(index){ return $(this).text() == "Dokumente" } ).attr("href").split("#")[1];
        pl_details_set_active_tab(tmp);
        pl_list_create_details_div_structure( tmp, tmp);
        $("#tabcontent").empty();
        pl_details_create_content( $("#tabcontent"), tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][tmp], tmp );

    }

</script>