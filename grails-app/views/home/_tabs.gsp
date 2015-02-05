<div id="pl-tab-template" class="notshown">
    <ul class="nav nav-tabs" style="margin-bottom:0px; border: 1px solid #EEEEEE">
        <li id="pl-tab-li-template" class="hide">
            <a>
                <span style="font-weight:bold;font-size:8pt">Tab</span>
                <i class='icon-remove'></i>
            </a>
        </li>
    </ul>
</div>


<script type="text/javascript">

    function pl_tab_template_init(refid) {

        pl_tab_template_new(refid)


    }

    function pl_tab_get_tab(refid) {
        var result = 'li[id*=pl-tab-li-template-' + refid + ']'
        return result
    }

    function pl_tab_template_new(refid) {

        $.each(tstvar, function (key, value) {
                $('#pl-tab-li-template-' + key).removeClass('active')
        })

        $('#pl-tab-li-template').before(
                $('#pl-tab-li-template')
                        .clone()
                        .attr('refid', refid)
                        .attr('id', 'pl-tab-li-template-' + refid)
                        .addClass('pl-tab-li-template-' + refid)
                        .removeClass('hide')
                        .addClass('active')
                        .find('span')
                        .text(tstvar[refid]["tab-header"])
                        .end()
                        .before(function () {
                            pl_tab_template_on_focus_enter(refid)
                        })
                        .click(function () {
                            pl_tab_template_on_focus_enter(refid)
                        })
                        .find('i')
                        .click(function () {
                            pl_tab_template_delete(refid)
                        })
                        .end()
        )
        return refid
    }


    function pl_tab_template_on_focus_enter(refid) {

        $('ul').find('li').removeClass('active')

        $(pl_tab_get_tab(refid)).addClass('active')

        pl_set_active_tab(refid)

        if((tstvar[refid]["tab-object-type"]=="info")){
            $('#pltool-content').load( '${createLink(controller: 'Home', action: 'renderSplash')}' )
        } else {
            $('#pltool-content').load( '${createLink(controller: 'Home', action: 'renderContent')}' )
        }

    }

    function pl_tab_template_delete(refid) {

        $(pl_tab_get_tab(refid)).remove()

        delete tstvar[refid]

        if ((json_length()!=0)){
            letz=json_length()
            $('#pl-tab-li-template-' + letz).addClass('active')
            pl_set_active_tab(json_length().toString())
            if((tstvar[json_length()]["tab-object-type"]=="info")){
                $('#pltool-content').load( '${createLink(controller: 'Home', action: 'renderSplash')}' )}
            else{
                $('#pltool-content').load( '${createLink(controller: 'Home', action: 'renderContent')}' )}
        }
        else {
            $('#pltool-content').load( '${createLink(controller: 'Home', action: 'renderSplash')}' )
        }
    }

    function pl_tab_push_var(dummy){


    }
    function pl_tab_template_on_focus_leave() {

    }

    function pl_tab_template_find_prev_refid(refid) {

    }



</script>