<div id="pl-upload-template" class="well row-fluid" xmlns="http://www.w3.org/1999/html"
     xmlns="http://www.w3.org/1999/html">
    <div id="pl-upload-template-table" class="controll-group">
        <div id="pl-upload-template-table-field">
                <uploader:uploader
                        id="upload"
                        url="${[controller:'home', action:'upload']}"
                        params="${[ source: "upload" ]}"
                        multiple="false">
                <uploader:onComplete> pl_list_render_list(); </uploader:onComplete>
                </uploader:uploader>
        </div>
    </div>

</div>





<script type="text/javascript">

    $(function () {

        $('#pl-upload-template').ready(function () {

            $("#accordion_upload_panel").hide();

            if( tstvar[is_active()]["upload-template"]["panel-hidden"]==false ){
                $("#accordion_upload_panel").show();
            }

            if ( tstvar[is_active()]["upload-template"]["panel-collapsed"]==false) $("#collapseupload").myCollapse("show");
            else $("#collapseupload").myCollapse("hide");

        })


    });


</script>