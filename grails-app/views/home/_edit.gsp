<div id="pl-edit-template" class="well row-fluid" xmlns="http://www.w3.org/1999/html">
    <div id="pl-edit-template-table" class="controll-group">
        <div class="hide" id="pl-edit-template-table-field">
            <label class="pl-edit-labels"></label>
        </div>


        <textarea elastic rows="1" class="pl-edit-fields hide" id="pl-edit-template-table-field-span"></textarea>
        <img src="images/icons/zoom_in.png" class="pl-edit-datetime-icon hide" id="pl-edit-template-table-field-span-icon"/>
        <textarea elastic rows="1" id="pl-edit-template-table-field-datetime" class="pl-edit-datetime hide"></textarea>
        <img src="images/icons/date_magnify.png" class="pl-edit-datetime-icon hide" id="pl-edit-template-table-field-datetime-icon"/>
        <select id="pl-edit-template-table-field-selectone" class="pl-edit-dropdown hide"></select>
        <select id="pl-edit-template-table-field-selectmulti" class="pl-edit-dropdown hide" multiple="multiple"></select>
        <div id="pl-edit-template-table-field-pointer-dialog" class="pl-edit-dialog"></div>
        <div id="pl-edit-template-table-field-pointer-dialog-row" class="pl-edit-dialog-row hide"></div>

    </div>
    <button id="pl-edit-save-button" type="button" class="pl-details-button-group-button">
        </i><g:message code="edit.save"/>
    </button>


</div>





<script type="text/javascript">

    $(document).ready(function () {

        $("#accordion_edit_panel").hide();

        if( !(tstvar[is_active()]["edit-template"]["panel-hidden"]) ){

            $('#pl-edit-template').ready(function () {

                var editvar = pl_get_active_tab_data();
                editvar = editvar["edit-template"];

                if( editvar["data"] == undefined ) pl_edit_init();
                else pl_edit_create_body();

                if( editvar["panel-hidden"]==false ) $("#accordion_edit_panel").show();

                if (editvar["panel-collapsed"]==false) $("#collapseEdit").myCollapse("show");
                else $("#collapseEdit").myCollapse("hide");

            })

            $('#pl-edit-save-button').click( function(){
                pl_edit_save_guidata_to_dom();
                pl_edit_save_domdata_to_database();
            })
        }
    });

    function pl_edit_init() {
        pl_edit_getdata();
    }

    function pl_edit_getdata() {

        var ThisSearch={
            "searched-object": tstvar[is_active()]["tab-object-type"],
            "id": tstvar[is_active()]["tab-header"]
        }
        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            method:"POST",
            data: {json: JSON.stringify(ThisSearch),myAction:"getEditData"},
            async:false,
            success: function(dat) {
                pl_edit_create_structure(dat);
                pl_edit_create_body();
            },
            error: function(response, status, xhr){
                alert("Fehler Edit-View");
            }
        });

    }

    function pl_edit_create_structure(dat){

        tstvar[is_active()]["edit-template"]["data"] = {};
        $.each( dat, function(index, content){
            tstvar[is_active()]["edit-template"]["data"][index] = content;
        });

    }

    function pl_edit_create_body(){

        var content = tstvar[is_active()]["edit-template"]["data"];
        var id = tstvar[is_active()]["id"];

        $.each(content, function( index, value ) {

            var field = $('#pl-edit-template-table-field').clone();

            //Label
            field.find('label').text( value["element_header"] );

            //Eingabefeder nach Typ
            switch( JSON.parse(value["element_format"])["row-type"] ){

                //Text: Es muss ein einfaches Eingabefeld gezeigt werden
                //TODO: Länge beschränken
                case [ "text", "url", "mailto" ] :

                    var box = $(document).find('#pl-edit-template-table-field-span').clone();
                    box.attr('id','pl-edit-template-table-field-span-'+index);
                    if( value["dataset"] != undefined ) box.val( value["dataset"] );
                    box.removeClass("hide");
                    box.addClass("pl-edit-targets");
                    field.append( box );

                    break;

                //Number: Es muss ein einfaches Eingabefeld gezeigt werden, dass nur die Eingabe von Zahlen erlaubt
                case "number" :

                    var box = $(document).find('#pl-edit-template-table-field-span').clone();
                    box.attr('id','pl-edit-template-table-field-span-number-'+index);

                    if( value["dataset"] != undefined ) box.val( value["dataset"] );
                    box.removeClass("hide");
                    box.addClass("pl-edit-targets");
                    field.append( box );
                    break;

                //Float: Es muss ein einfaches Eingabefeld gezeigt werden, dass nur die Eingabe von Zahlen und Komma erlaubt
                case "float":

                    var box = $(document).find('#pl-edit-template-table-field-span').clone();
                    box.attr('id','pl-edit-template-table-field-span-float-'+index);

                    if( value["dataset"] != undefined ) box.val( value["dataset"] );
                    box.removeClass("hide");
                    box.addClass("pl-edit-targets");
                    field.append( box );
                    break;

                //Date: Es muss ein einfaches Eingabefeld angezeigt werden, das bei onClick einen Kalender anzeigt
                case "date":

                    var box = $(document).find('#pl-edit-template-table-field-datetime').clone();
                    box.attr('id','pl-edit-template-table-field-datetime-'+index);
                    if( value["dataset"] != undefined ) box.val( value["dataset"] );
                    box.removeClass("hide");
                    box.addClass("pl-edit-targets");

                    field.append( box );

                    var icon = $(document).find('#pl-edit-template-table-field-datetime-icon').clone();
                    icon.attr('id','pl-edit-template-table-field-datetime-icon-'+index);
                    icon.click( function(){
                        NewCssCal (box.attr('id'),'yyyyMMdd','arrow',false);
                    });
                    icon.removeClass("hide");

                    field.append( icon );

                    break;

                //Datetime: Es muss ein einfaches Eingabefeld angezeigt werden, das bei onClick einen Kalender inkl Uhrzeit anzeigt
                case "datetime":

                    var box = $(document).find('#pl-edit-template-table-field-datetime').clone();
                    box.attr('id','pl-edit-template-table-field-datetime-'+index);
                    if( value["dataset"] != undefined ) box.val( value["dataset"] );
                    box.removeClass("hide");
                    box.addClass("pl-edit-targets");

                    field.append( box );

                    var icon = $(document).find('#pl-edit-template-table-field-datetime-icon').clone();
                    icon.attr('id','pl-edit-template-table-field-datetime-icon-'+index);
                    icon.click( function(){
                        NewCssCal (box.attr('id'),'yyyyMMdd','arrow',true,'24');
                    });
                    icon.removeClass("hide");

                    field.append( icon );

                    break;

                //Lookup: Es muss ein Dropdown anzeigt werden, dass alle möglichen Werte darstellt und das den angeklickten Wert in das Feld schreibt
                case "lookup":

                    var attr = JSON.parse( value["element_lookup"] )["lookup_code"];
                    var lu = find_lookup_values( attr );
                    var box = $(document).find('#pl-edit-template-table-field-selectone').clone();
                    $.each(lu, function( index2, value2 ) {
                        box.append( "<option value='" + value2["lookup_value"] + "'>" + value2["lookup_value"] + "</option>");
                    });
                    box.attr('id','pl-edit-template-table-field-selectone-'+index);

                    //Wert setzen
                    if( value["dataset"] != undefined ){

                        var lookingFor = JSON.parse( value["element_lookup"] );
                        pl_lookup_set_value_id( lookingFor, value["dataset"], false );
                        var found_lookup = find_lookup_value(lookingFor);
                        box.val(  (found_lookup=="") ? value["dataset"] : found_lookup );

                    }

                    box.removeClass('hide');
                    box.addClass("pl-edit-targets");
                    field.append( box );
                    break;

                //Lookupmulti: Es muss ein Auswahlliste anzeigt werden, aus der beliebig viele Werte gewählt werden können
                case "lookupmulti":

                    var attr = JSON.parse( value["element_lookup"] )["lookup_code"];
                    var lu = find_lookup_values( attr );
                    var box = $(document).find('#pl-edit-template-table-field-selectmulti').clone();
                    $.each(lu, function( index2, value2 ) {
                        box.append( "<option value='" + value2["lookup_value"] + "'>" + value2["lookup_value"] + "</option>");
                    });
                    box.attr('id','pl-edit-template-table-field-selectmulti-'+index);

                    //Wert setzen
                    if( value["dataset"] != undefined ){
                        var mylook = value["dataset"].split(',');
                        var res=[];
                        for( k in mylook ){
                            var lookingFor = JSON.parse( value["element_lookup"] );
                            pl_lookup_set_value_id( lookingFor, mylook[k], true);
                            var found_lookup = find_lookup_value(lookingFor);
                            res.push( (found_lookup=="") ? mylook[k] : found_lookup );
                        }
                        box.val( res );
                    }

                    box.removeClass('hide');
                    box.addClass("pl-edit-targets");
                    field.append( box );
                    break;

                //Lookup: Es muss ein Dropdown anzeigt werden, dass alle möglichen und übersetzen Werte darstellt und das den angeklickten Wert in das Feld schreibt
                case "lookupdomain":

                    var attr = JSON.parse( value["element_lookup"] )["lookup_code"];
                    var lu = find_lookup_values( attr );
                    var box = $(document).find('#pl-edit-template-table-field-selectone').clone();
                    $.each(lu, function( index2, value2 ) {
                        box.append( "<option value='" + value2["lookup_value"] + "'>" + find_domain_lookup( value2["lookup_value"] ) + "</option>");
                    });
                    box.attr('id','pl-edit-template-table-field-selectone-'+index);

                    //Wert setzen
                    if( value["dataset"] != undefined ){

                        var lookingFor = JSON.parse( value["element_lookup"] );
                        pl_lookup_set_value_id( lookingFor, value["dataset"], false );
                        var found_lookup = find_lookup_value(lookingFor);
                        box.val(  (found_lookup=="") ? value["dataset"] : found_lookup );

                    }

                    box.removeClass('hide');
                    box.addClass("pl-edit-targets");
                    field.append( box );
                    break;

                //Pointer: Es wird auf eine Domain verwiesen. Daher müssen alle Objekte dieser Domain zur Auswahl angezeigt werden.
                case "pointer":

                    var box = $(document).find('#pl-edit-template-table-field-selectone').clone();
                    box.attr('id','pl-edit-template-table-field-select-'+index);

                    $.ajax({
                        url: "${createLink(controller: 'home', action: 'request')}",
                        method:"POST",
                        data: {json: "{\"table\":\""+value['pointer_table']+"\",\"attr\":\"" + value['pointer_rule'] + "\"}", myAction:"getPointerElements"},
                        async:false,
                        success: function(dat) {
                            box.append( "<option></option>" );
                            $.each(dat, function(index, value){
                                box.append( "<option>" + value["id"] + ": " + value["attr"] + "</option>" );
                            });

                        },
                        error: function(response, status, xhr){
                        }
                    });

                    if( value["dataset"] != undefined ){
                        var x = value["dataset"];
                        for(var i = 0, j = box[0].options.length; i < j; ++i) {
                            if( box[0].options[i].value.split(':')[0] == x ) {
                                box[0].selectedIndex = i;
                                break;
                            }
                        }
                    }
                    box.removeClass("hide");
                    box.addClass("pl-edit-targets");

                    field.append( box );

                    break;
                default:

                    var box = $(document).find('#pl-edit-template-table-field-span').clone();
                    box.attr('id','pl-edit-template-table-field-span-'+index);
                    if( value["dataset"] != undefined ) box.val( value["dataset"] );
                    box.removeClass("hide");
                    box.addClass("pl-edit-targets");
                    field.append( box );

            }

            //Autoresize für Textareas
            field.on( 'keyup', 'textarea', function (e){
                $(this).css('height', 'auto' );
                $(this).height( (this.scrollHeight<40) ? 20 : this.scrollHeight );
            });
            field.find( '.pl-edit-fields' ).keyup();

            //Anzeigen
            field.removeClass('hide');
            field.attr('id','pl-edit-template-table-field-'+index);

            $('#pl-edit-template-table').append(field);

        })

        //Einschränkung Typ Number/Float
        $("textarea[id^='pl-edit-template-table-field-span-number']").keydown( function(e){
            var key = e.keyCode ? e.keyCode : e.which;
            if( [8,37,39,46].indexOf(key) < 0 ) if( isNaN( String.fromCharCode(key) ) ) return false;
        });
        $("textarea[id^='pl-edit-template-table-field-span-float']").keydown( function(e){
            var key = e.keyCode ? e.keyCode : e.which;
            if( [8,37,39,46,190].indexOf(key) < 0 ) if( isNaN( String.fromCharCode(key) ) ) return false;
        });

        //Chosen
        $.each( $('#pl-edit-template-table').find("select:not([class*=hide])"), function(i,v){

            $(this).chosen({
                disable_search_threshold: 10,
                no_results_text: gui_messages["edit.select.noresults"],
                inherit_select_classes: true,
                placeholder_text_single: gui_messages["edit.select.chooseone"],
                placeholder_text_multiple: gui_messages["edit.select.choosesome"],
                allow_single_deselect: true
            });
        });

    }

    function pl_edit_save_guidata_to_dom(){

        var data_transfer = [];

        $( "[class*=pl-edit-targets]:not([class*=chosen])" ).each(function( index, element ) {

            data_transfer = tstvar[is_active()]["edit-template"]["data"];
            row_type = JSON.parse(data_transfer[index]["element_format"])["row-type"];
            if( row_type=="lookup" ){
                var tmp = pl_lookup_set_value_id( JSON.parse( data_transfer[index]["element_lookup"]), $(element).val() );
                tmp = find_lookup_value( tmp );
                data_transfer[index]["dataset"] = tmp;

            } else if( row_type=="lookupmulti" ){
                var arr = [];
                if( $(element).val() != null ){
                    for( i=0; i < $(element).val().length; i++ ){
                        if( $(element).val()[i] != "" ){
                            var tmp = pl_lookup_set_value_id( JSON.parse( data_transfer[index]["element_lookup"] ), $(element).val()[i] );
                            arr.push( find_lookup_value( tmp ) )
                        }
                    }
                    data_transfer[index]["dataset"] = arr.join(',');
                }
                else data_transfer[index]["dataset"] = "";

            } else if( row_type=="lookupdomain" ){
                var tmp = pl_lookup_set_value_id( JSON.parse( data_transfer[index]["element_lookup"]), $(element).val() );
                tmp = find_lookup_value( tmp );
                data_transfer[index]["dataset"] = tmp;

            } else if( row_type=="pointer" ) data_transfer[index]["dataset"] = $(element).val().split(":")[0];
            else data_transfer[index]["dataset"] = $(element).val();

        });

        tstvar[is_active()]["edit-template"]["data"] = data_transfer;

    }

    function pl_edit_save_domdata_to_database(){

        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            method:"POST",
            data: {
                json: JSON.stringify( tstvar[is_active()]["edit-template"]["data"]  ),
                myAction:"setEditData",
                id: tstvar[is_active()]["id"],
                domain: tstvar[is_active()]["tab-object-type"] },
            async:false,
            success: function(dat) {
                if( dat[0] == undefined) alert("Daten gespeichert.");
                else alert("Daten gespeichert, ID: " + dat[0][0] + ".");
            },
            error: function(response, status, xhr){
                alert("Speicherung fehlgeschlagen. Bitte stellen Sie sicher, dass alle Pflichtfelder mit korrekten Werten befüllt sind.");
            }
        });



        window.scrollTo(0, 0);

    }


</script>