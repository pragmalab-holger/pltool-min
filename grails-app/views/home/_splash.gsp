<r:script>

    $(function(){
        pl_info_init()
    })

    function pl_info_init() {

       $(".pl-content").removeClass("pl-content")

        if (is_active()==null){
            tstvar2 = pl_get_tab_dummy("Info");
        }
        else{
            tstvar2 = pl_get_active_tab_data()
            $("#pl-splash-screen").css("margin-top","0px")
        }



        j = 0
        for (var i in tstvar2["splash-content"]) {

            j=j+3

            $("#pl-splash-screen-labels :nth-child("+j+")")

                    .text(tstvar2["splash-content"][i])
        }
        j = j + 3;
        $("#pl-splash-screen-labels :nth-child("+j+")")
            .text( new Date() )




    }

</r:script>

<div class="row-fluid" id="pl-splash-screen">
    <div class="span9">
        <div class = "span9" id="pltool-splash-header">
            <span class="splash-fields">
                <a href="/">
                    <g:img dir="images" file="pltool_logo.png" alt="PL Tool" width="200px"/>
                </a>
            </span>
            <div class="splash-fields" id="pl-splash-screen-labels">

                <br>

                <label>
                    <g:message code="splash.version" />
                </label>
                <label>

                </label>
                <br>
                <label>
                    <g:message code="splash.datenbank" />
                </label>
                <label>

                </label>
                <br>
                <label>
                    <g:message code="splash.grails" />
                </label>
                <label>

                </label>
                <br>
                <label>
                    <g:message code="splash.java" />
                </label>
                <label>

                </label>
                <br>
                <label>
                    <g:message code="splash.aktivierung" />
                </label>
                <label>

                </label>
                <br>
                <label>
                    <g:message code="splash.serverzeit" />
                </label>
                <label>

                </label>
                <br>
                <label>
                    <g:message code="splash.umgebung" />
                </label>
                <label>
                    <g:if env="development">
                        Dev
                    </g:if>

                    <g:if env="production">
                        Prod
                    </g:if>

                    <g:if env="test">
                        Test
                    </g:if>
                </label>

            </div>

        </div>
        <div id="pltool-splash-content">

        </div>
    </div><!--/span-->
</div><!--/row-->




<g:if test="${request.xhr}">
    <r:layoutResources disposition="defer"/>
</g:if>