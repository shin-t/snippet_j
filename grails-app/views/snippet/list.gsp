

<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
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
        <div class="body">
            <div class="sidebar"></div>
            <div class="contents">
                <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
                </g:if>
                <g:render template="form" model="[snippetInstance:snippetInstance]" />
                <div class="list">
                    <div id="update"></div>
                    <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
                    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
                    <div class="content">
                    
                        <div class="header">${fieldValue(bean: snippetInstance, field: "user")}</div>
                    
                        <div>${fieldValue(bean: snippetInstance, field: "text")}</div>
                    
                        <div>${fieldValue(bean: snippetInstance, field: "file")}</div>
                    
                        <div><g:formatBoolean boolean="${snippetInstance.recepting}" /></div>
                    
                        <div><g:formatDate date="${snippetInstance.deadline}" /></div>
                    
                        <div>${fieldValue(bean: snippetInstance, field: "root")}</div>
                    
                        <div>${fieldValue(bean: snippetInstance, field: "parent")}</div>
                    
                        <div><g:link action="show" id="${snippetInstance.id}"><g:formatDate date="${snippetInstance.lastUpdated}" /></g:link></div>
                        <div class="reply_button"><g:remoteLink action="create" id="${snippetInstance.id}" update="reply_${snippetInstance.id}" onLoaded="clearForm()">Reply</g:remoteLink></div>
                    </div>
                    </g:each>
                    <div class="paginateButtons">
                        <g:paginate total="${snippetInstanceTotal}" />
                    </div>
                </div>
                <r:script>
                    function clearForm() { $(".reply_form").empty() }
                </r:script>
            </div>
        </div>
    </body>
</html>
