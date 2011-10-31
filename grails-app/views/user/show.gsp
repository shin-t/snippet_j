<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
        <r:require modules="jquery-ui, common, snippet"/>
    </head>
    <body>
        <div id="contents">
            <g:if test="${flash.message}">
            <p class="message"><span>${flash.message}</span></p>
            </g:if>
            <g:render template="user"/>
            <g:if test="${params.status}">
                <div id="lists">
                    <g:include controller="user" action="${params.status}" params="[username:params.username, status:params.status]"/>
                </div>
            </g:if>
        </div>
        <div id="sidebar">
            <g:include controller="user" action="following" params="[status:params.status, username:userInstance.username, max:5]"/>
            <g:include controller="user" action="followers" params="[status:params.status, username:userInstance.username, max:5]"/>
        </div>
    </body>
</html>
