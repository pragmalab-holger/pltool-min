<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<%@ page import='org.springframework.web.servlet.support.RequestContextUtils' contentType='text/html;charset=UTF-8' %>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>

<html>
<head>
    <title>PLtool</title>

    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/smoothness/jquery-ui.css" type="text/css">
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.min.js"></script>

    <r:require modules='bootstrap, customcss, fileuploader, mail' />

    <g:javascript src="datetimepicker.js" />

    <g:javascript src="chosen.jquery.js"/>

    <r:layoutResources disposition="defer" />

    <g:layoutHead/>
    <r:layoutResources disposition="head"/>

</head>
<body>



<div id="myModal" class="hide" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">



</div>
<div class="navbar navbar-inverse" style="margin-bottom: 3px">
    <div class="navbar-inner">
        <div class="container-fluid">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="brand" href="">PLtool | Minimalversion</a>
            <div class="nav-collapse collapse">
                <sec:ifLoggedIn>
                <div class="navbar-text pull-right" id ="pl-msgPlaceholder" cnt=0 content="No system messages">
                    <a href="#" data-toggle="tooltip" title="No system messages" id="pl-a-msgPlaceholder">
                        <b><sec:username/></b>
                    </a>
                    (<g:link controller='logout'><g:message code="springSecurity.login.password.logout" /></g:link>)

                </div>

                    %{--Holger: Parameter des Users--}%
                    <g:set var="loggedin" value="true" />
                    <g:set var="isAdmin" value="${sec.ifAllGranted(roles: 'ROLE_ADMIN', "true")}" />

                </sec:ifLoggedIn>


                </div><!--/.nav-collapse -->
        </div>
    </div>
</div>

<div id="message"></div>


<div id="plmain"  class="container-fluid">
    <div class="row-fluid">

        <g:layoutBody/>

    </div>
</div><!--/.fluid-container-->


<hr>
<footer>
    <p>PRAGMALAB 2014</p>
</footer>

<r:layoutResources disposition="defer"/>
</body>
</html>


<script type="text/javascript"  charset="utf-8">

    var tstvar = { };
    var lookupTable=[];
    var relations = {"equals":"=","greater_than":">","smaller_than":"<","not_equal_to":"!=","like":"like","not_like":"not like"};
    var gui_messages;

    var modalWidth = $("#myModal").width();
    $("#img-spinner").width(modalWidth);
    $("#myModal").modal();
    $(document)
            .ajaxStart(function() {
                $("#myModal").modal("show");
                $("#overlay").height($("#pltool-content").height());
                $("#overlay").width($("#pltool-content").width());
                $("#overlay").removeClass("hide");
            })
            .ajaxStop(function() {
                $("#overlay").addClass("hide");
                $("#myModal").modal("hide");
            })
            .ajaxError(function() {
                $("#myModal").modal("hide");
                $("#overlay").addClass("hide");
            });

    $.ajaxSetup({
        cache: false,
        type: "POST"
    });

    $.ajax({
        url: "${g.createLink(controller:'admin',action:'gui_messages')}",
        type: 'POST',
        dataType: "json",
        async: false,
        success: function(dat){
            gui_messages = dat;
        },
        error: function(){
            alert("GUI Elemente konnten nicht abgerufen werden. Bitte kontaktieren Sie Ihren Admin.")
        }
    });

    $(document).ready(function () {

        if( '${loggedin}' ){ //Holger: nur ausführen wenn User eingeloggt

            var active_tab = is_active()

            if( json_length() > 0 ){

                $.each(tstvar, function (key, value) {
                    pl_tab_template_init(key)
                })
                pl_set_active_tab(is_active())
                $.each(tstvar, function (key, value) {
                    if(active_tab!=key) {
                        $('#pl-tab-li-template-' + key).removeClass('active')
                    }
                })
                $('#pl-tab-li-template-' + active_tab).addClass('active')
                $('#pltool-content').load(
                        '${createLink(controller: 'Home', action: 'renderContent')}'
                )

            } else {

                var tabAttr = {}
                if ($("#pl-tab-template").hasClass("notshown"))$("#pl-tab-template").removeClass("notshown")
                $.extend(tabAttr,{"objectType": "agenda"} )
                if ($(this).parent("li").attr('tabType')) {
                    jQuery.extend(tabAttr,{"tabType": $(this).parent("li").attr('tabType')} )
                }
                $( document ).ready(function() {
                    pl_make_new_tab(tabAttr);
                });
            }

        }

    });

    function oo(){ //Beliebige Anzahl von Parametern
        for (var i = 0; i < arguments.length; i++) {
            console.debug(arguments[i]);
        }

    }

    function load_lookup_table(){
        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            method:"POST",
            data: {json:JSON.stringify({}),myAction:"lookupRequest"},
            async:false,
            success: function(dat) {
                lookupTable = dat;
            },
            error:function(response, status){
                lookupTable = [{"LOOKUP_ID":"","LOOKUP_STRING":"","LOOKUP_CODE":"Currency","LOOKUP_VALUE":"0024"},{"LOOKUP_VALUE_ID":3,"LOOKUP_VALUE_ID_string":"EUR","LOOKUP_CODE":"CURRENCY","LOOKUP_VALUE":"20AC"}]
            }
        });

        for (var i in lookupTable) lookupTable[i]["lookup_code"] = lookupTable[i]["lookup_code"].toLowerCase();
    }

    function find_lookup_value(this_lookup){

        var LArr = []
        var ret_val=[]

        for( var i in lookupTable) if( this_lookup["lookup_code"]==lookupTable[i]["lookup_code"] ) LArr.push(lookupTable[i]);

        //oo("---------------", this_lookup.toSource() );

        for( var i in LArr ){

            //oo(LArr[i].toSource());
            //oo( LArr[i]["lookup_value"], this_lookup["lookup_value_id_string"], (LArr[i]["lookup_value"] == this_lookup["lookup_value_id_string"]), this_lookup["lookup_value_id"]=="" )

            if( ( LArr[i]["lookup_value_id"] == this_lookup["lookup_value_id"] || LArr[i]["lookup_value"] == this_lookup["lookup_value_id_string"] ) && LArr[i]["lookup_code"]=="currency" ){
                ret_val = "&#x".concat(LArr[i]["lookup_value"]);
                break;
            } else if( ( LArr[i]["lookup_value_id"] == this_lookup["lookup_value_id"] ) && (this_lookup["lookup_value_id"]!="") ){
                ret_val = LArr[i]["lookup_value"];
                break;
            } else if( (LArr[i]["lookup_value"] == this_lookup["lookup_value_id_string"]) && this_lookup["lookup_value_id"]=="" ){
                ret_val = LArr[i]["lookup_value_id"];
                break;
            }
        }

        //oo(ret_val);

        if( ret_val==undefined ){
            ret_val=[]
            for (var i in LArr){
               ret_val.push( LArr[i]["lookup_value"] )
            }
        }
        return ret_val

    }

    function find_lookup_values( attr ){

        var newArr = lookupTable.filter(function(x){
            return x.lookup_code == attr;
        });

        return newArr;
    }

    function find_domain_lookup( name ){
        return gui_messages["domain.name."+name];
    }

    function set_refid(){
        if (typeof refid === "undefined") {
            refid = 1
        }
        else {
            refid++
        }
    }

    function json_length(){
        var len=0
        $.each(tstvar, function (key, value) {
            len=key
        })
        return parseInt(len);
    }

    function is_active() {
        akt=null
        $.each(tstvar, function (key, value) {
            if(tstvar[key].active) {
                akt=key
            }
        } )
        return akt;
    }

    function time(){
        var thisDate = new Date
        return (thisDate.getTime()/1000)
    }

    function pl_get_active_tab_data() {
        jsonVar = null
        for (tab in tstvar) {
            if( tstvar[tab]["active"] ){
                jsonVar = tstvar[tab]
                break
            }
        }
        return jsonVar
    }

    function pl_set_active_tab(id) {

        //Holger: Zwischenspeicherung von edit/new abfangen
        if( is_active() != null ){
            if( tstvar[is_active()]["edit-template"]["panel-hidden"] == false ){
                pl_edit_save_guidata_to_dom();
            }

        }
        $.each(tstvar, function (key, value) {
            tstvar[key].active = false;
            if(key==id){
                tstvar[key].active = true
            }
        })
    }

    function pl_get_current_date() {
        var fullDate = new Date()
        return pl_get_date(fullDate)
    }

    function pl_get_date(fullDate) {
        var twoDigitMonth = ((fullDate.getMonth().length+1) === 1)? (fullDate.getMonth()+1) : '0' + (fullDate.getMonth()+1);
        var currentDate = fullDate.getDate() + "/" + twoDigitMonth + "/" + fullDate.getFullYear();
        return currentDate
    }

    function pl_find_array_element(thisArray,val){
        for (var i = 0; i < thisArray.length; i++) {
            if (thisArray[i] === val) {
                return i
            }
        }
        return -1;
    }

    function pl_delete_array_element(thisArray,val){
         var del_index=pl_find_array_element(thisArray,val)
         if (del_index==(-1)){
             return thisArray
         }
        else{
             thisArray.splice(del_index, 1);
         }
    }

    function pl_change_two_JSON(obj, key, newVal){
        var treeElementsString = ""
        pl_get_tree(obj,key,"","",true)
        treeElements=treeElementsString.split(":")
        pl_reset_val(obj,treeElements,newVal)

        function pl_reset_val(obj,tree,newVal){
            if (tree.length>2){
                tree.shift()
                pl_reset_val(obj[tree[0]],tree,newVal)
            }
            else if (tree.length==2){

                tree.shift()

                obj[tree[0]][newVal[0]]= newVal[1]
            }
        }

        function pl_get_tree(obj, key, val, newEntry,aktiv) {
            var objects = "";
            for (var i in obj) {
                if (!obj.hasOwnProperty(i)) continue;
                if (typeof obj[i] == 'object') {
                    k=val
                    k=k+":"+i
                    if (i == key ) {
                        treeElementsString = k
                        return k
                    }
                    objects=objects+pl_get_tree(obj[i], key, k, newEntry,false )
                }
                else if (i == key ) {
                    return ""
                }

            }
            if (aktiv){
                return objects
            }
            else{ return ""}

        }
    }

    function pl_get_objects(obj, key, val, newEntry) {
            var objects = [];
            for (var i in obj) {
                if (!obj.hasOwnProperty(i)) continue;
                if (typeof obj[i] == 'object') {
                    objects = objects.concat(pl_get_objects(obj[i], key, val, newEntry));
                } else if (i == key ) {
                    obj[key]= newEntry
                    objects.push(obj);
                }
            }

        return objects;
    }

    function pl_modify_global_var_by_format(toChange){

        var active_tab=is_active()

        if (pl_get_object_type(toChange)=="Object"){

            for (var i in toChange){

                if (pl_get_object_type(toChange[i])=="String"){
                    pl_get_objects(tstvar[active_tab],i,"",toChange[i])
                }
                else if ((pl_get_object_type(toChange[i])=="Object")) {
                    for (var j in toChange[i]) {

                        pl_change_two_JSON(tstvar[active_tab],i,[j,toChange[i][j]])
                    }
                }
            }
        }
    }

    function pl_which_action(obj,val,name){

        //oo(obj, val, name)

        obj = obj.replace("#value#",val)
        obj = JSON.parse(obj)

        if (obj.action=="sendToDetails"){
            pl_modify_global_var_by_format(obj)
            pl_list_call_details_controller("Details")
        }

        if (obj.action=="newTab"){
            var tab_header = gui_messages[ "domain.name." + obj["tab-object-type"] ]+" "+name + ":" + val;
            pl_make_new_tab(obj["tab-object-type"],obj,tab_header);
            tstvar[is_active()]["id"] = val;
        }

    }

    function pl_make_new_tab(obj_type,dummy_change,tab_header){

//        oo(obj_type)
//        oo(dummy_change)

        //Variablen setzen
        var tmp_dt = obj_type
        if (tmp_dt["objectType"]) obj_type = tmp_dt["objectType"]
        var tab_type = obj_type
        if(tmp_dt["tabType"]) tab_type = tmp_dt["tabType"]
        set_refid()
        len=json_length()+1
        var dummy = {}

        //Tab Daten erzeugen
        jQuery.extend(dummy, {}, pl_get_tab_dummy(tab_type));   // neue logik - getting dummy by tabType
        dummy["tab-refid"]= len
        tstvar[len.toString()]=dummy

        //Header setzen
        if( tab_header == undefined ) tstvar[len.toString()]["tab-header"] = gui_messages["domain.name."+obj_type];
        else tstvar[len.toString()]["tab-header"] = tab_header;

        //Tab aktivieren
        pl_set_active_tab(len.toString())

        //Tab definieren
        pl_tab_template_init(len.toString())

        //Addons
        if( dummy_change!=undefined ){

            pl_modify_global_var_by_format(dummy_change)

        }

    }


    // Funktion zum Herausfinden, welcher Typ die Variable ist
    var stringConstructor = "test".constructor;
    var arrayConstructor = [].constructor;
    var objectConstructor = {}.constructor;

    function pl_get_object_type(object) {
        if (object === null) {
            return "null";
        }
        else if (object === undefined) {
            return "undefined";
        }
        else if (object.constructor === stringConstructor) {
            return "String";
        }
        else if (object.constructor === arrayConstructor) {
            return "Array";
        }
        else if (object.constructor === objectConstructor) {
            return "Object";
        }
        else {
            return "don't know";
        }
    }

    // usage: zahl.format([, number]  [, bool]  )



    Number.decPoint = ',';

    Number.thousand_sep = '.';



    Number.prototype.format = function(k, fixLength) {
        if(!k) k = 0;
        var neu = '';
        // Runden
        var f = Math.pow(10, k);
        var zahl = '' + parseInt(this * f + (.5 * (this > 0 ? 1 : -1)) ) / f ;
        // Komma ermittlen
        var idx = zahl.indexOf('.');
        // fehlende Nullen einfügen
        if(fixLength && k) {
            zahl += (idx == -1 ? '.' : '' )
                    + f.toString().substring(1);
        }
        // Nachkommastellen ermittlen
        idx = zahl.indexOf('.');
        if(idx == -1) idx = zahl.length;
        else neu = Number.decPoint + zahl.substr(idx + 1, k);
        // Tausendertrennzeichen
        while(idx > 0)
        {
            if(idx - 3 > 0)
                neu = Number.thousand_sep + zahl.substring( idx - 3, idx) + neu;
            else
                neu = zahl.substring(0, idx) + neu;
            idx -= 3;
        }

        return neu;

    };

    $.fn.myCollapse = function(dec){
        var thisParent = $(this).parent("fieldset")
        if (dec=="show"){
            if (!thisParent.hasClass("active"))  thisParent.addClass("active");
            $(this).animate("show")
            $(this).show(10)
        }
        else{
            if (thisParent.hasClass("active"))thisParent.removeClass("active")
            $(this).hide()
        }
    }

    function pl_set_locale(localeStr){

        var tmp = pl_get_object_type(localeStr)
        if( tmp=="null" ){
            tmp = "de"
        }
        else {
            tmp = "?lang=" + localeStr
        }
        $.ajax({
            url: "${createLink(controller: 'home', action: 'locale')}" + tmp,
            type: "POST",
            dataType: "json",
            async:false,
            success: function(){
                oo("Sprache gesetzt: " + localeStr);
            },
            error: function(){
                alert("Sprache konnte nicht gesetzt werden.");
            }
        });


    }

    function pl_set_locale_btn(){

        return -1;
    }

    function pl_msg(msg, localeStr){
        var tmp_dt = msg
        $.ajax({
            url: "${createLink(controller: 'home', action: 'gmsg')}",
            type: "POST",
            data: {"loc":localeStr, "msg":msg},
            dataType: "json",
            async:false,
            success: function(data) {
                tmp_dt = data["msg"]
            }
        })
        return tmp_dt
    }

    function send_prototyp_mail(){

        $.ajax({
            url: "${g.createLink( controller:'home', action:'request' )}",
            data: {
                json : JSON.stringify({
                    "text" : "A quick movement of the enemy will jeopardize six gunboats."
                }),
                myAction : "sendMail"
            },
            success : function(){
            },
            async: true,
            global: false
        });

    }








</script>
