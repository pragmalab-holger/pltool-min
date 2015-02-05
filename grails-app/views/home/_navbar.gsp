
%{--<ul class="nav nav-list">--}%

    %{--<li id="navbar-agenda" objectType = "agenda" >--}%
        %{--<a class = "menuicon agenda item">[<g:message code="domain.name.agenda" />]</a>--}%
    %{--</li>--}%

    %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
    %{--<li id="navbar-reminders" objectType = "reminders" >--}%
        %{--<a class = "menuicon reminders item">[<g:message code="domain.name.reminders" />]</a>--}%
    %{--</li>--}%
    %{--</sec:ifAnyGranted>--}%

    %{--<li id="navbar-contacts" objectType = "contacts">--}%
        %{--<a class = "menuicon contacts item" >[<g:message code="domain.name.contacts" />] </a>--}%
    %{--</li>--}%

    %{--<sec:ifAnyGranted roles="ROLE_ADMIN">--}%
    %{--<li id="navbar-links" objectType = "links">--}%
        %{--<a class = "menuicon links item" >[<g:message code="domain.name.links" />] </a>--}%
    %{--</li>--}%
    %{--</sec:ifAnyGranted>--}%

    %{--<li id="navbar-documents" objectType = "documents">--}%
        %{--<a class = "menuicon docs item" >[<g:message code="domain.name.documents" />]   </a>--}%
    %{--</li>--}%
    %{--<li id="navbar-cashflows" objectType = "cashflows">--}%
        %{--<a class = "menuicon cashflows item" >[<g:message code="domain.name.cashflows" />]   </a>--}%
    %{--</li>--}%
    %{--<li id="navbar-info" objectType = "info" >--}%
        %{--<a class = "menuicon info item">[<g:message code="domain.name.info" />]</a>--}%
    %{--</li>--}%

%{--</ul>--}%

<ul id="pl-navbar" class="nav nav-list">

    <li id="pl-navbar-item" class="hide">
        <a></a>
    </li>

</ul>

<script type="text/javascript"  charset="utf-8">

    var navvar = {};

    $(document).ready(function(){

        load_lookup_table();

        if( Object.keys(navvar).length == 0 ) pl_navbar_init();
        pl_navbar_build();

        $('[objectType] a').click(
                function () {
                    var tabAttr = {}
                    if ($("#pl-tab-template").hasClass("notshown"))$("#pl-tab-template").removeClass("notshown")
                    jQuery.extend(tabAttr,{"objectType": $(this).parent("li").attr('objectType')} )
                    if ($(this).parent("li").attr('tabType')) {
                        jQuery.extend(tabAttr,{"tabType": $(this).parent("li").attr('tabType')} )
                    }
                    pl_make_new_tab(tabAttr)
                }
        );

    });

    function pl_navbar_init(){

        var ThisSearch={
            "searched-object": "Navbar",
            "search-request": [],
            "pagination": [1,10,0]
        }

        $.ajax({
            url: "${createLink(controller: 'home', action: 'request')}",
            method:"POST",
            data: {json: JSON.stringify(ThisSearch), myAction:"items" },
            async: false,
            success: function(dat) {
                navvar = dat;
            },
            error: function(response, status, xhr){

            }
        });


    }

    function pl_navbar_build(){

        var navvar2 = navvar["rows"];

        for( var i = 0; i < navvar2.length; i++){

            var navitem = $('#pl-navbar-item').clone();
            navitem.attr('id','navbar-'+navvar2[i][1]);
            navitem.attr('objectType',navvar2[i][1]);
            navitem.find("a")
                    .addClass("menuicon " + navvar2[i][1] + " item")
                    .text("["+gui_messages["domain.name."+navvar2[i][1]]+"]")
                    .end();
            navitem.removeClass('hide');

            $('#pl-navbar').append( navitem );

        }

        delete navvar2;

    }
</script>


