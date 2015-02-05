<div id="pl-bucket-template" class="well row-fluid">
    <div class="span12" id="pl-bucket-template-header">
        <p class="text-info">
            <strong>Bucket Details </strong>
        </p><div id="pl-bucket-header-buttons">
        <p>
            <button class="btn btn-small" id="pl-bucket-template-buttons-add-level">
                Add Level
            </button>
            <button class="btn btn-small" id="pl-bucket-template-buttons-delete-level">
                Delete Level
            </button>
            <button class="btn btn-small">
                Copy Level
            </button>
            <button class="btn btn-small">
                <i class="icon-chevron-up">

                </i>
            </button>
            <button class="btn btn-small">
                <i class="icon-chevron-down">

                </i>
            </button>
        </p>
    </div>
        <div class="span12" id="pl-bucket-template-select-form">
            <br>
            <form class="simple-form">
                <div class="span10" id="pl-bucket-template-select-form-header">
                    <div style="width:150px;height:15px;float:left;">
                    </div>
                    <div style="width:115px;height:15px;float:left;">

                    </div>
                </div>
            </form>
            <br>
            <div class="span12" id="pl-bucket-template-select-all-forms">
                <div type="bucket-select" id="pl-bucket-template-select-form-1">
                    <select name="top5" size="1" style="width:110px;">
                        <option>

                        </option>
                    </select>
                    <input class="search-query" input="" value="" style="width:130px;" name="top5">
                    <br>

                </div>
            </div>
            <div class="span12" id="pl-bucket-template-end-button">
                <button class="btn  btn-small" id="pl-bucket-template-end-button-view">
                    View Elements
                </button>
                <button class="btn  btn-small" id="pl-bucket-template-end-button-cancel">
                    Cancel
                </button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(function () {
        $('#pl-bucket-template').ready(function () {
            switch(jsonVar["tab-object-type"]) {
                case "Buckets":
                    $('#accordion_details_panel').hide()
                    if (tstvar2["bucket-template"]["panel-collapsed"]==false){
                        $("#collapseBucket").myCollapse("show")
                    }
                    else{
                        $("#collapseBucket").myCollapse("hide")
                    }
                    pl_bucket_body_init()
                    break;
                case ("Assets"||"Contacts"):
                    $('#accordion_buckets_panel').hide()
                    $('#accordion_bucket_selection_list_panel').hide()
            }

        });
    })

    //Initialer Aufruf, JSON Objekt auslesen
    function pl_bucket_body_init() {
        bucketVar = pl_get_active_tab_data()
        //  $('#pl-bucket-template').empty()

        pl_bucket_make_elements()
        $("#pl-bucket-template-buttons-add-level").click(function(){
            pl_bucket_add_selection_line($(this))
        }  )
        $("#pl-bucket-template-buttons-delete-level").click(function(){
            pl_bucket_delete_selection_line($(this))
        })
        $("#pl-bucket-template-end-button-view").click(function(){
            pl_bucket_read_select_values()
        })
        $("#pl-bucket-template-end-button-cancel").click(function(){
//            alert($(this).text())
        })

    }

    //Aufbau der einzelnen Panels
    function pl_bucket_make_elements() {


        //  $("#pl-bucket-template-selection").append('<ul style=\"display:table;width=500px;\" id=\"pl-bucket-template-selection-head\"></ul>')
        for (var i in bucketVar["bucket-template"]["bucket-template-selection"]["header"]){
            var tmpVar = bucketVar["bucket-template"]["bucket-template-selection"]["header"][i]
            $("#pl-bucket-template-select-form-header div:last").before(
                    $("#pl-bucket-template-select-form-header div:nth-child(2)")
                            .clone()
                            .text(tmpVar)
            )
        }
        $("#pl-bucket-template-select-form-header div:nth-child(2)").remove()
        $("#pl-bucket-template-select-form-header div:last").remove()

        for (var i in bucketVar["bucket-template"]["bucket-template-selection"]["elements"]) {

            var this_element = bucketVar["bucket-template"]["bucket-template-selection"]["elements"][i]
            //k=parseInt(i)+1

            $("#pl-bucket-template-select-form-1 select:first")
                    .clone()
                    .insertAfter($("#pl-bucket-template-select-form-1 select:last"))
        }

        for (var i in bucketVar["bucket-template"]["bucket-template-selection"]["elements"]){
            k=parseInt(i)+1

            for (var j in bucketVar["bucket-template"]["bucket-template-selection"]["elements"][i]){
                //alert(bucketVar["bucket-template"]["bucket-template-selection"]["elements"][i][j])
                $("#pl-bucket-template-select-form-1 select:nth-child("+k+")")
                        .find("option:first")
                        .clone()
                        .text(bucketVar["bucket-template"]["bucket-template-selection"]["elements"][i][j])
                        .appendTo("#pl-bucket-template-select-form-1 select:nth-child("+k+")")
                        .end()
            }
            $("#pl-bucket-template-select-form-1 select:nth-child("+k+") :first-child").remove()
        }

        $("#pl-bucket-template-select-form-1 select:last option").remove()
        $("#pl-bucket-template-select-form-1 select:last").remove()
    }

    function pl_bucket_add_selection_line(){
        var tempCount = $("#pl-bucket-template-select-all-forms div").length
        $("#pl-bucket-template-select-form-1")
                .clone()
                .insertAfter($("#pl-bucket-template-select-form-"+tempCount))
                .attr("id","pl-bucket-template-select-form-"+(tempCount+1))
        $("#pl-bucket-template-select-form input.search-query:last").attr("value","")


    }

    function  pl_bucket_delete_selection_line(that){
        var tempCount = $("#pl-bucket-template-select-all-forms div").length
        if (tempCount!==1)
        {
            $("#pl-bucket-template-select-form-"+tempCount).remove()
        }
    }
    function pl_bucket_read_select_values(){
        //$("#pl-bucket-template-select-all-forms").css("background-color","red")
        var tmpVar2=""
        $("div[type='bucket-select'] select,#pl-bucket-template-select-all-forms input.search-query").each(function(i){
            if (i==$("#pl-bucket-template-select-form-1 select").length)
            {
                tmpVar2=tmpVar2+" "+$(this).val()+"\n"
            }
            else
            {
                tmpVar2=tmpVar2+" "+$(this).val()
            }
        })
    }

</script>