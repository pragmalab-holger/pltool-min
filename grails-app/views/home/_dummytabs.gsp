<script>

    function pl_get_tab_dummy(tab_type){

        dummyvar =
        {
            "tab-refid": 1,
            "tab-object-type": "assets",
            "active": true,
            "search-template": {
                "panel-hidden":false,
                "search-request":{},
                "panel-collapsed": false,
                "label-searched-object": "Searched object",
                "searched-object": "Assets",
                "label-quick-search": "Quick search",
                "search-select-options": ["Assets","Contacts","Buckets"],
                "quick-search": [

                ],
                "label-custom-search": "Custom search",
                "custom-search-fields":
                {

                },
                "custom-search-relations":
                {
                    "text":["like","not like"],
                    "number":["equals","greater than","smaller than"]
                },
                "changed_elements":[],

                "custom-search": [
                    [
                        ["and", "or"],
                        [],
                        [],
                        []
                    ],[
                        ["and", "or"],
                        [],
                        [],
                        []
                    ]

                ],
                "custom-search-selected-options":[],

                "label-sql-search": "SQL Where search",
                "sql-search": ""

            },
            "list-template": {
                "panel-hidden":false,
                "panel-collapsed": false,
                "list-template-generic": {
                    "pagination":[1,10,100],
                    "rows": [
                    ]
                }
            },
            "details-template": {
                "panel-hidden":true,
                "d-hidden":true,
                "panel-collapsed": true,
                "details-template-generic": {
                    "elements": {
                    }
                },
                "details-template-sub": {
                }
            },

            "edit-template": {
                "panel-hidden": true,
                "d-hidden": true,
                "panel-collapsed": false
            },

            "upload-template": {
                "panel-hidden": true,
                "d-hidden": true,
                "panel-collapsed": false
            }
        }

        switch (tab_type) {

            case ("info"):
                jQuery.extend(dummyvar,{
                    "tab-refid": 1,
                    "tab-object-type": "info",
                    "active": true,
                    "splash-content": {
                        "version":"0.1",
                        "dab-name":"pltooldef",
                        "gversion":"2.1",
                        "jversion":"1.7",
                        "firstdate":"1 April 2013"
                    }
                })
                $.ajax({
                    url: "${createLink(controller: 'splash', action: 'index')}",
                    success: function(data) {
                        dummyvar["splash-content"]["version"]=data["currentVersion"]
                        dummyvar["splash-content"]["dab-name"]=data["dbName"]
                        dummyvar["splash-content"]["gversion"] =data["grailsVersion"]
                        dummyvar["splash-content"]["jversion"]= data["javaVersion"]
                        dummyvar["splash-content"]["firstdate"]= data["releaseDate"]
                    }
                })
                break;

            case ("contacts"):
                jQuery.extend(dummyvar,{

                    "tab-refid": 2,
                    "tab-object-type": "contacts",
                    "active": false
                })
                break;

            case ("agenda"):
                jQuery.extend(dummyvar,{
                    "tab-refid": 2,
                    "tab-object-type": "agenda",
                    "active": false
                })
                break;

            case ("reminders"):
                jQuery.extend(dummyvar,{
                    "tab-refid": 2,
                    "tab-object-type": "reminders",
                    "active": false
                })
                break;

            case ("links"):
                jQuery.extend(dummyvar,{
                    "tab-refid": 2,
                    "tab-object-type": "links",
                    "active": false
                })
                break;

            case ("documents"):
                jQuery.extend(dummyvar,{
                    "tab-refid": 2,
                    "tab-object-type": "documents",
                    "active": true
                })
                break;

            case ("cashflows"):
                jQuery.extend(dummyvar,{
                    "tab-refid": 2,
                    "tab-object-type": "cashflows",
                    "active": true
                })
                break;

                default:
                jQuery.extend(dummyvar,{})
        }

        %{--jQuery.extend(dummyvar,{"tab-type":tab_type})--}%
        %{--$.ajax({--}%
            %{--url: "${createLink(controller: 'home', action: 'locale')}",--}%
            %{--type: 'GET',--}%
            %{--dataType: "json",--}%
            %{--async:false,--}%
            %{--success: function(data) {--}%
                %{--jQuery.extend(dummyvar,{"locale":data["loc"]})--}%
            %{--}--}%
        %{--})--}%

        return dummyvar;


    }



</script>
