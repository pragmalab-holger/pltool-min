<div id="pl-bucket-selection-template" class="well row-fluid">
    <div id="pl-bucket-selection-template-div">
        <p class="text-info"><strong></strong>
        </p>
        <table class="table table-striped table-hover table-condensed" id="pl-bucket-selection-table">
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
        <div class="pagination pagination-mini pagination-centered">
            <ul>
                <li>
                    <a href="#">&lt;&lt;
                    </a>
                </li>
                <li id="page-bucket-selection-1">
                    <a href="#">1
                    </a>
                </li>
                <li>
                    <a href="#">&gt;&gt;
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <button class="btn btn-small" id="save-new-bucket-button">Save New Bucket</button>
</div>

<script type="text/javascript">


    function o(txt) {
        var now = new Date()
        // console.log(" " + now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds() + "." + now.getMilliseconds() + " > " + txt + "<br>")
    }

    $(function () {
        $('#pl-bucket-selection-template').ready(function () {
            //  o("the page has been loaded, invoking \"bucketSelection-template\" init")
            switch(jsonVar["tab-object-type"]) {
                case "Buckets":
                    $('#accordion_details_panel').hide()
                    if (tstvar2["bucket-selection-template"]["panel-collapsed"]==false){
                        $("#collapseBucketSelection").myCollapse("show")
                    }
                    else{
                        $("#collapseBucketSelection").myCollapse("hide")
                    }
                    pl_bucket_selection_list_init()
                    break;
                case ("Assets"||"Contacts"):
                    $('#accordion_buckets_panel').hide()
                    $('#accordion_bucket_selection_list_panel').hide()
            }
            //   o("done")
        });
    })


    function pl_bucket_selection_list_init() {
        tstvar2 = pl_get_active_tab_data()                                            //Zustandsvariable holen
        //o("data loaded, tab-1 (tab-refid) = " + tstvar["tab-refid"])
        //$('#pl-bucket-selection-template').empty()                                           //Templage leeren
        pl_bucket_selection_list_create_label()                                                   //Label erzeugen
        //$('#pl-bucket-selection-table').empty()                                              //Tabelle leeren
        pl_bucket_selection_list_create_header()                                                  //Tabelle und Tabellenüberschriften erzeugen
        pl_bucket_selection_list_create_body()                                                    //Tabelle ausfüllen
        /*$('#pl-bucket-selection-table  a').on('click', function () {                         //Link hinzufügen der Asset ID an Controller gibt und
         pl_bucket_selection_list_to_details(this.text)                                       //Details öffnen soll, bisher nur Ausgabe der Asset ID
         }
         )   */

        $('li#page-bucket-selection').on('click', function () {
                    call_bucket_selection_list_controller()
                }
        )
        $('#save-new-bucket-button').click(function(){
            if($(this).text()=="")
            {
                alert("Nothing selected")
            }
            else
            {
                pl_bucket_selection_list_save_new_bucket($(this))
            }

        })


    }
    /*****************
     * Erzeuge Label**
     * **************/
    function pl_bucket_selection_list_create_label() {          //Label erzeugen
        $("#pl-bucket-selection-template-div p strong").text(tstvar2["bucket-selection-template"]["bucket-selection-list-template-generic"]["label-generic"])
    }

    /*****************
     * Erzeuge Header **
     * **************/

    function pl_bucket_selection_list_create_header() {                 //Header und dazugehörige Tabelle erstellen
        var headers = tstvar2["bucket-selection-template"]["bucket-selection-list-template-generic"]["header-names"]
        for (var i in headers) {
            $("#pl-bucket-selection-table th :last").before(
                    $("#pl-bucket-selection-table th :last")
                            .clone()
                            .text(headers[i])

            )
        }
    }
    /*****************
     * Erzeuge Body **
     * **************/

    function pl_bucket_selection_list_create_body() {                        //Tabelleninhalt erstellen
        //Variablendeklaration
        var content = tstvar2["bucket-selection-template"]["bucket-selection-list-template-generic"]["rows"]           //Schreibe rowsinhalte aus Zustandsvariable in Variable content

        for (var i in content) {                                                                     //Erzeuge Schleife - Zugriff auf einzelne rows mit i
            $("#pl-bucket-selection-table tr:last").after(
                    $("#pl-bucket-selection-table tbody tr:first")
                            .clone()
                            .attr("id","i")
            )
            for (var j in content[i]) {
                $("#pl-bucket-selection-table tbody tr:last td:last").before(
                        $("#pl-bucket-selection-table tbody tr:last td:last")
                                .clone()
                                .text(content[i][j])
                )
            }
        }
        $("#pl-bucket-selection-table th :first").before(
                $("#pl-bucket-selection-table th :first")
                        .clone()
                        .empty()
        )

        for (var i in content) {                                                                     //Erzeuge Schleife - Zugriff auf einzelne rows mit i

            for (var j in content[i]) {

                switch (tstvar2["bucket-selection-template"]["bucket-selection-list-template-generic"]["row-types"][i]){

                    case "number-ccy":
                        k=parseInt(i)+2
                        l=parseInt(j)+1

                        $("#pl-bucket-selection-table tbody tr:nth-child("+k+") td:nth-child("+l+")").append(pl_list_get_currency())
                        break;
                    case "number-without-separator-link":
                        k=parseInt(i)+2
                        l=parseInt(j)+1

                        $("#pl-bucket-selection-table tbody tr:nth-child("+k+") td:nth-child("+l+")")
                                .html("<a href=\"#\">"+content[i][j]+"</a>")
                        break;
                }
            }
        }

        $("#pl-bucket-selection-table tbody tr:first").remove()

        $("#pl-bucket-selection-table tbody tr").each
        (  function(index){
                    tmpInd=parseInt(index)+1
                    $("#pl-bucket-selection-table tbody :nth-child("+tmpInd+") td:first")
                            .clone()
                            .html("<input type=\"checkbox\" id=\"pl-bucket-selection-list-checkbox-"+tmpInd+"\" myId=\""+tmpInd+"\"/>")
                            .insertBefore($("#pl-bucket-selection-table tbody :nth-child("+tmpInd+") td:first"))

                    //  .insertBefore("#pl-bucket-selection-table tbody :nth-child("+index+") td:first")

                }
        )
        $('#pl-bucket-selection-table input[type=checkbox]').click(function() {
            if (!$(this).is(':checked')) {
                $(this).parents('tr').removeClass('success')
            }
            else{
                $(this).parents('tr').addClass('success')
            }
        })
    }
    function pl_bucket_selection_list_save_new_bucket(that){
        tmplist=[]
        $('#pl-bucket-selection-table input[type=checkbox]').each(

                function() {
                    if ($(this).is(':checked')){
                        tmplist.push($(this).attr('myId'))
                    }

                }
        );
        if (tmplist=="")
        {
            alert("nothing selected")
        }
        else
        {
            alert("You have selected the following rows:"+ tmplist)
        }
    }
    function pl_bucket_selection_list_to_details(link) {           //Übergabe Asset ID an Controller, um Details zu erneuern
        //alert(link)
    }

    function pl_bucket_selection_list_get_currency() {   //Auswahl des Währungssymbols
        return " €"
    }

    function call_bucket_selection_list_controller() {

    }

</script>
