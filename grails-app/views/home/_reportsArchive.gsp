<div id="pl-reports-archive-template" class="well row-fluid" >
    <div class=hide id="reports-dummy"></div>
    <div id="pl-reports-archive-template-div">
        <table class="table table-striped table-hover table-condensed" id="pl-reports-archive-list-table">
            <thead>
            <tr>
                <th>

                </th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>

                </td>
            </tr>
            </tbody>
        </table>
        <div id="pl-reports-archive-list-pagination">
            <ol class="pager">
                <li>
                    <a href="#" id="pl-archive-list-before" class="align-left">before
                    </a>
                </li>
                <li>
                    <input class = "pagination-input" type="text" id="pl-archive-list-paginate-input" >
                </input>
                </li>

                <li class = "pagination-text">
                    Number of Pages:
                </li>
                <li>
                    <a href="#" id="pl-archive-list-next" class="align-right">next
                    </a>
                </li>
                <li>
                    <select class="pagination-select" id="pl-archive-list-pagination-select-box">
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
    <div class="span4" id="reports-archive-button">
        <button class="mybutton" id="reports-archive-save-button" disabled>
            Save generated Report
        </button>
        <div class="btn-group dropup" id="reports-archive-export-grp">
            <button class="mybutton" id="reports-archive-export-button" rep_id="" disabled>Export</button>
            <button class="mybutton dropdown-toggle" id="reports-archive-export-caret" data-toggle="dropdown" disabled>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu menuicon export item" id="reports-archive-export-dropmenu" role="menu" aria-labelledby="dropdownMenu">
                <li ><a tabindex="-1" href="#" >Pdf</a></li>
                <li ><a tabindex="-1" href="#" >Rtf</a></li>
                <li ><a tabindex="-1" href="#" >Xlsx</a></li>
                <li ><a tabindex="-1" href="#" >Docx</a></li>
                <li ><a tabindex="-1" href="#" >Pptx</a></li>
                <li ><a tabindex="-1" href="#" >Odt</a></li>
                <li class="divider"></li>
                <li ><a tabindex="-1" href="#">Print</a></li>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        $('#pl-reports-archive-template').ready(function () {

            pl_reports_archive_init();

        })
    })

    function pl_reports_archive_init(){
        var tstvar2 = pl_get_active_tab_data()
        if (tstvar2["tab-object-type"]=="Reports") {
            if (tstvar[is_active()]["reports-archive-template"]["panel-collapsed"]){
                $("#collapsedReportsArchive").myCollapse("hide")
            }
            else{

                $("#collapseReportsArchive").myCollapse("show")
            }
            pl_reports_archive_load()
            if (tstvar[is_active()]["reports-archive-template"]["save-button-disabled"]==false)
            {$("#reports-archive-save-button").removeAttr("disabled")}
        }



    }



    function pl_reports_archive_load(){
        $('#pl-reports-archive-template')
        $("#pl-reports-archive-template div p strong").text(tstvar2["reports-archive-template"]["reports-archive-list"]["label-generic"])
        var content = tstvar2["reports-archive-template"]["reports-archive-list"]["rows"]
        var headers = tstvar2["reports-archive-template"]["reports-archive-list"]["header-names"]

        for (var i in headers) {
            if(i==0)continue;
            $("#pl-reports-archive-list-table th :last").before(
                    $("#pl-reports-archive-list-table th :last")
                            .clone()
                            .text(headers[i])
            )
        }


        for (var i in content) {

            $("#pl-reports-archive-list-table tr:last").after(
                    $("#pl-reports-archive-list-table tbody tr:first")
                            .clone()
                            .attr("id","pl-reports-archive-list-row-number-"+i)
                            .attr("rep_id",content[i][0])
            )

            for (var j in content[i]) {

                if(j==0) continue;

                if (tstvar2["reports-archive-template"]["reports-archive-list"]["lookup"]){
                    if (tstvar2["reports-archive-template"]["reports-archive-list"]["lookup"][j]!="null"&&listvar["list-template"]["list-template-generic"]["lookup"][j]!=""&&listvar["list-template"]["list-template-generic"]["lookup"][j]!=undefined&&listvar["list-template"]["list-template-generic"]["lookup"][j]!="to be defined"){

                        var lookingFor = JSON.parse(tstvar2["reports-archive-template"]["reports-archive-list"]["lookup"][j])
                        pl_lookup_set_value_id(lookingFor,content[i][j])
                        var found_lookup = find_lookup_value(lookingFor)
                        content[i][j] = (found_lookup=="") ? content[i][j] : found_lookup
                    }
                }
                if (tstvar2["reports-archive-template"]["reports-archive-list"]["row-types"][j][0]=="{")
                {
                    $("#pl-reports-archive-list-table tbody tr:last td:last").before(
                            $("#pl-reports-archive-list-table tbody tr:last td:last")
                                    .clone()
                                    .append("<a href=\"#\">"+content[i][j]+"</a>")
                                    .data("value",j)
                                    .click(function(e){
                                        e.preventDefault()
                                        j=$(this).data("value")
                                        var obj_index = parseInt($(this).index())
                                        var header_name = $(this).parents("table").find("th").eq(obj_index).text()
                                        pl_which_action(tstvar2["reports-archive-template"]["reports-archive-list"]["row-types"][j],$(this).find("a").text(),header_name)
                                    })
                    )
                }
                else if(listvar["list-template"]["list-template-generic"]["row-types"][j]=="number-with-separator-2-decimal"){
                    $("#pl-reports-archive-list-table tbody tr:last td:last").before(
                            $("#pl-reports-archive-list-table tbody tr:last td:last")
                                    .clone()
                                    .html(parseInt(content[i][j]).format(2,true))
                    )
                }
                else{

                    $("#pl-reports-archive-list-table tbody tr:last td:last").before(
                            $("#pl-reports-archive-list-table tbody tr:last td:last")
                                    .clone()
                                    .text(content[i][j])
                    )
                }
            }
        }

        $("#pl-reports-archive-list-table tbody tr:first").remove()
        $('#pl-reports-archive-list-table tr')
                .click(function() {
                    $('#pl-reports-archive-list-table tr').each(

                            function() {
                                if ($(this).hasClass('success')){
                                    $(this).removeClass('success')
                                }
                            }
                    );
                    $(this).addClass('success')
                    pl_reports_archive_load_details($(this).attr("rep_id"))
                })

        $('#pl-reports-archive-list-table tr').each(

                function() {
                    if ($(this).is(':checked')){
                        tmplist.push($(this).attr('myId'))
                    }

                }
        );

        $('#reports-archive-export-grp ul li a').on('click',function(e) {
            e.preventDefault()
            //console.log("call: report/show?repId="+$('#reports-archive-export-button').attr("rep_id")+"&fmt="+$(this).text())
            window.open("report/show?repId="+$('#reports-archive-export-button').attr("rep_id")+"&fmt="+$(this).text(),"show document")
        })

        $("#reports-archive-save-button").click(function(e){
            e.preventDefault()
            $.ajax({
                url: "${createLink(controller: 'home', action: 'request')}",
                data: {json:JSON.stringify([]),myAction:"makeReportStatic"}
            }).done(function(dat){
                        //alert("saved")
                    })
                    .fail(function(){
                        //alert("error")
                    })
        })

        pl_archive_list_paginate(tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][0],tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][1])

        $("#pl-archive-list-before").click(function(e){
            e.preventDefault()
            var myPage = $("#pl-archive-list-paginate-input").val()
            if (myPage>1){
                tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][0]=parseInt($("#pl-archive-list-paginate-input").val())-1
                pl_archive_list_render_archive_list()
            }

        })
        $("#pl-archive-list-next").click(function(e){
            e.preventDefault()
            var myPage = $("#pl-archive-list-paginate-input").val()

            var items_per_page = tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][1]
            var maxpages = Math.ceil(tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][2]/items_per_page)
            if (myPage<maxpages){
                tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][0]=parseInt($("#pl-archive-list-paginate-input").val())+1
                pl_archive_list_render_archive_list()
            }

        })

        $("#pl-archive-list-paginate-input").change(function(){
            if($(this).val()<=numberOfPages&&$(this).val()>0){
                tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][0]=parseInt($("#pl-archive-list-paginate-input").val())
                pl_archive_list_render_archive_list()
            }
            else{
                $(this).val(tstvar[is_active()]["list-template"]["list-template-generic"]["pagination"][0])
            }

        })
        $("#pl-archive-list-pagination-select-box").change(function(){
           if ($("#pl-archive-list-pagination-select-box").val()=="alle"){
                if (parseInt(tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][2])>500){

                    tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][1]=500
                }
                else{
                    tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][1]=parseInt(tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][2])

                }
            }
            else{
                tstvar[is_active()]["reports-archive-template"]["reports-archive-list"]["pagination"][1]=parseInt($("#pl-archive-list-pagination-select-box").val())
            }

            pl_archive_list_render_archive_list()
        })
    }

    function pl_reports_archive_load_details(that){
        var active_tab = is_active()
        var thisRep="report"+that
        var divStructure = { "row-types":["reports"],"header-names":["Div Id","Label","class","Content Type","Tab Id"],"rows":[[0,"   ","span9","reports",0]]}
        var tabStructure = {"rows":[[0,"Report Overview"]],"header-names":["tabs","label"],"row-types":["number","html"]}
        var repPages = 0;

        var repPages = pl_reports_get_png_pages(that)
        $("#reports-archive-export-button")
                .attr("rep_id",that)
                .removeAttr("disabled")
        $("#reports-archive-export-caret").removeAttr("disabled")
        for (var i=1; i<=repPages;++i){
            tabStructure["rows"].push([i,"Page "+i])
            divStructure["rows"].push([0,"   ","span9",'<img id="reportpage' + i + '.png" alt="preview image ' + i + '" src="reports/reportpage' + i + '.png?' + Math.random()+'">',0])
        }

            pl_list_create_details_tab_structure(tabStructure)
            var shifted = divStructure["rows"].shift()
            tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][0]["divs"]={}
            tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][0]["divs"]["0"]={}
            for (var i in divStructure["rows"]){

                j=parseInt(i)+1

                if (tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][j]["divs"]==undefined)
                    tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][j]["divs"]={}
                if (tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][j]["divs"][divStructure["rows"][i][0]]==undefined){
                    tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][j]["divs"][divStructure["rows"][i][0]]={}
                }
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][j]["divs"][divStructure["rows"][i][0]]["label"]=divStructure["rows"][i][1]
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][j]["divs"][divStructure["rows"][i][0]]["type"]=divStructure["row-types"][i]
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][j]["divs"][divStructure["rows"][i][0]]["class"]=divStructure["rows"][i][2]
                tstvar[active_tab]["details-template"]["details-template-generic"]["tabs"][j]["divs"][divStructure["rows"][i][0]]["element-type"]=divStructure["rows"][i][3]
            }
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

    }

    function pl_archive_list_paginate (page, items_per_page){
        var tstvar2 = pl_get_active_tab_data()
        var maxentries = tstvar2["reports-archive-template"]["reports-archive-list"]["pagination"][2]

        function numPages() {
            return Math.ceil(maxentries/items_per_page);
        }
        var numberOfPages = numPages()
        var StringNumPages =  "/"+numberOfPages
        $("#pl-reports-archive-list-pagination li:contains('Number of Pages')").text(StringNumPages)
        $("#pl-archive-list-paginate-input").val(page)

        $("#pl-archive-list-pagination-select-box").val(tstvar2["reports-archive-template"]["reports-archive-list"]["pagination"][1])
        if($("#pl-archive-list-paginate-input").val()==1){$("#pl-reports-archive-list-pagination a:first").remove()}
        if($("#pl-archive-list-paginate-input").val()==numPages()){$("#pl-archive-list-next").remove()}
    }

    function pl_archive_list_render_archive_list(){
        $.when(pl_reports_input_update_reports_archive()).then(
                $('#collapseReportsArchive')
                        .load(
                        '${createLink(controller: 'Home', action: 'renderReportsArchive')}',
                        function(response, status, xhr){
                            $(window).scrollTop($("#collapseReportsArchive").offset().top)
                        }
                )
        )
    }

    function pl_reports_get_png_pages(nr_rep_res){
        var out = 1
        $.ajax({
            url: "${createLink(controller: 'report', action: 'pngpages')}",
            data: {id:nr_rep_res}

        }).done(function(dat){
                    out = dat["nrPages"]
                })
                .fail(function(){
                    alert("getting pages failed")
                })
        return out
    }



</script>