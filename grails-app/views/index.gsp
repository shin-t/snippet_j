<html>
    <head>
        <r:require modules="jquery-ui, common, snippet"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title><g:message code="snippet.label" default="Snippet"/></title>
    </head>
    <body>
        <div id="contents">
            <g:if test="${flash.message}">
            <p class="message"><span>${flash.message}</span></p>
            </g:if>
        </div>
        <div id="sidebar"></div>
    </body>
</html>
