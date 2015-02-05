<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <script>

    </script>
    <meta name="layout" content="main"/>
    <title>Home Controller</title>
</head>
<body>

<g:render template="/home/dummytabs"/>
%{--Holger: Linke Navbar--}%

<div id="pltool-navbar" class="well sidebar-nav span2">
    <g:render template="navbar"/>
</div>

<div id="pl-inner" class="pl-content span10">
    <g:render template="/home/tabs"/>
    %{--Holger: Unterscheidung zwischen Splash-Screen und Anzeige von Tabs--}%
    <div id="pltool-content">
    <div id="overlay" class="hide"></div>

    </div>
</div>
</body>

</html>