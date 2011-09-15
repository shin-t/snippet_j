
<%@ page import="snippet.Question" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require modules="jquery-ui, common" />
        <r:script>
            $(function(){
                $("input:submit, input:button").button().css("font-size","8pt");
                $("#searchableForm button").button({icons:{primary:"ui-icon-search"},text:false}).css("font-size","8pt");
            });
        </r:script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <div class="sidebar"></div>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                
                <g:each in="${questionInstanceList}" status="i" var="questionInstance">
                <div id="${questionInstance.id}" class="reply_form"></div>
                <div class="content">
                
                    <div class="header">${fieldValue(bean: questionInstance, field: "user")}</div>
                
                    <div>${fieldValue(bean: questionInstance, field: "text")}</div>
                
                    <div>${fieldValue(bean: questionInstance, field: "file")}</div>
                
                    <div><g:formatBoolean boolean="${questionInstance.recepting}" /></div>
                
                    <div><g:link action="show" id="${questionInstance.id}"><g:formatDate date="${questionInstance.lastUpdated}" /></g:link></div>
                    <div class="reply_button"><g:remoteLink action="create" update="reply_${questionInstance.id}" onLoaded="clearForm()">Reply</g:remoteLink></div>
                </div>
                </g:each>
                <div class="paginateButtons">
                    <g:paginate total="${questionInstanceTotal}" />
                </div>
            </div>
            <r:script>
                function clearForm() { $(".reply_form").empty() }
            </r:script>
        </div>
    </body>
</html>
