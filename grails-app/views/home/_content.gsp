<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%@ page trimDirectiveWhitespaces="true" %>

<div id="overlay"/>

<fieldset id="accordion_upload_panel" class="myAccordion" panelType = "upload-template">
    <legend>
        <a data-parent="#accordion_upload_panel" href="#collapseUpload">Upload </a>
    </legend>
    <div id="collapseUpload" class="accordion_container">
        <g:render template="upload"/>
    </div>
</fieldset>

 <fieldset id="accordion-search-panel" class="myAccordion" panelType = "search-template">
     <legend>
         <a data-parent="#accordion_search_panel" href="#collapseSearch">Suche </a>
     </legend>
     <div id="collapseSearch" class="accordion_container">
             <g:render template="search"/>
     </div>
 </fieldset>


<fieldset id="accordion_list_panel" class="myAccordion" panelType = "list-template">
    <legend>
        <a data-parent="#accordion_list_panel" href="#collapseList">Liste </a>
    </legend>
    <div id="collapseList" class="accordion_container">
        <g:render template="list"/>
    </div>
</fieldset>

<fieldset id="accordion_reportsInput_panel" class="myAccordion" panelType = "reports-input-template">
    <legend>
        <a data-parent="#accordion_reportsInput_panel" href="#collapseReportsInput">Reports Input </a>
    </legend>
    <div id="collapseReportsInput" class="accordion_container">
        <g:render template="reportsInput"/>
    </div>
</fieldset>


<fieldset id="accordion_reportsArchive_panel" class="myAccordion" panelType = "reports-archive-template">
    <legend>
        <a data-parent="#accordion_reportsArchive_panel" href="#collapseReportsArchive">Reports Archive </a>
    </legend>
    <div id="collapseReportsArchive" class="accordion_container">
        <g:render template="reportsArchive"/>
    </div>
</fieldset>


<fieldset id="accordion_details_panel" class="myAccordion" panelType = "details-template">
    <legend>
        <a data-parent="#accordion_details_panel" href="#collapseDetails">Details </a>
    </legend>
    <div id="collapseDetails" class="accordion_container">
        <g:render template="details"/>
    </div>
</fieldset>


<fieldset id="accordion_buckets_panel" class="myAccordion" panelType = "bucket-template">
    <legend>
        <a data-parent="#accordion_buckets_panel" href="#collapseBuckets">Details </a>
    </legend>
    <div id="collapseBuckets" class="accordion_container">
        <g:render template="bucket"/>
    </div>
</fieldset>

<fieldset id="accordion_bucket_selection_list_panel" class="myAccordion" panelType = "bucket-selection-template">
    <legend>
        <a data-parent="#accordion_buckets_panel" href="#collapseBucketSelection">Details </a>
    </legend>
    <div id="collapseBucketSelection" class="accordion_container">
        <g:render template="bucketSelection"/>
    </div>
</fieldset>

<fieldset id="accordion_edit_panel" class="myAccordion" panelType = "edit-template">
    <legend>
        <a data-parent="#accordion_edit_panel" href="#collapseEdit">Edit </a>
    </legend>
    <div id="collapseEdit" class="accordion_container">
        <g:render template="edit"/>
    </div>
</fieldset>




<script type="text/javascript">

    $("#pl-inner").addClass("pl-content")

    $(document).ready(function () {

        $(".myAccordion").not("active").find('.accordion_container').hide();
        $(".myAccordion").find("legend").click( function(e) {
            e.preventDefault()
            var active_tab = is_active()
            var trig = $(this).parent(".myAccordion");
            var collapseTemplate = trig.attr("panelType")
            if ( trig.hasClass('active') ) {
                trig.find('.accordion_container').slideToggle('slow');
                trig.removeClass('active');
                tstvar[active_tab][collapseTemplate]["panel-collapsed"] = true;

            } else {
                trig.find('.accordion_container ').slideToggle('slow');
                trig.addClass('active');
                tstvar[active_tab][collapseTemplate]["panel-collapsed"] = false;
            };
            return false;
        });


        switch (tstvar[is_active()]["tab-object-type"]) {
            case ("buckets"):
                $('#accordion_details_panel').hide()
                if (!tstvar[is_active()]["bucket-template"]["panel-collapsed"]) $('#collapseBucket').collapse();
                if (!tstvar[is_active()]["bucket-selection-template"]["panel-collapsed"]) $('#collapseBucket').collapse();
                $('#accordion_reportsInput_panel').hide()
                $('#accordion_reportsArchive_panel').hide()
                break;

            case ("assets"):
                if (!tstvar[is_active()]["details-template"]["panel-collapsed"]) $('#collapseDetails').show();
                $('#accordion_buckets_panel').hide()
                $('#accordion_bucket_selection_list_panel').hide()
                $('#accordion_reportsInput_panel').hide()
                $('#accordion_reportsArchive_panel').hide()
                break;

            case ("contacts"):
                if (!tstvar[is_active()]["details-template"]["panel-collapsed"]) $('#collapseDetails').show();
                $('#accordion_buckets_panel').hide()
                $('#accordion_bucket_selection_list_panel').hide()
                $('#accordion_reportsInput_panel').hide()
                $('#accordion_reportsArchive_panel').hide()
                break;

            case ("reports"):
                if (!tstvar[is_active()]["reports-input-template"]["panel-collapsed"]) $('#collapseDetails').show();
                if (!tstvar[is_active()]["reports-archive-template"]["panel-collapsed"]) $('#collapseDetails').show();
                $('#accordion_buckets_panel').hide()
                $('#accordion_bucket_selection_list_panel').hide()
                break;

            case ("documents"):
                if( tstvar[is_active()]["id"]==undefined){
                    $('#accordion_upload_panel').show();
                    tstvar[is_active()]["upload-template"]["panel-hidden"] = false;
                }


            default:
                $('#accordion_buckets_panel').hide()
                $('#accordion_bucket_selection_list_panel').hide()
                $('#accordion_reportsInput_panel').hide()
                $('#accordion_reportsArchive_panel').hide()

        }


    });


</script>


<g:if test="${request.xhr}">
    <r:layoutResources disposition="defer"/>
</g:if>