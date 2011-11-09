<html>
    <head>
        <r:require modules="jquery, bootstrap, common"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title><g:message code="snippet.label" default="Snippet"/></title>
    </head>
    <body>
        <div class="sidebar"></div>
        <div class="content">
            <g:if test="${flash.message}">
            <p class="message"><span>${flash.message}</span></p>
            </g:if>
        </div>
    </body>
</html>
