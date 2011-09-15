

<%@ page import="snippet.Problem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'problem.label', default: 'Problem')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
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
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${problemInstance}">
            <div class="errors">
                <g:renderErrors bean="${problemInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${problemInstance?.id}" />
                <g:hiddenField name="version" value="${problemInstance?.version}" />
                <div class="dialog">
                    <div class="header">${entityName}</div>
                    
                        <div class="prop">
                            <div class="name">
                              <label for="text"><g:message code="problem.text.label" default="Text" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: problemInstance, field: 'text', 'errors')}">
                                <g:textArea name="text" cols="40" rows="5" value="${problemInstance?.text}" />
                            </div>
                        </div>
                    
                        <div class="prop">
                            <div class="name">
                              <label for="file"><g:message code="problem.file.label" default="File" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: problemInstance, field: 'file', 'errors')}">
                                <g:textArea name="file" cols="40" rows="5" value="${problemInstance?.file}" />
                            </div>
                        </div>
                    
                        <div class="prop">
                            <div class="name">
                              <label for="deadline"><g:message code="problem.deadline.label" default="Deadline" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: problemInstance, field: 'deadline', 'errors')}">
                                <g:datePicker name="deadline" precision="day" value="${problemInstance?.deadline}" default="none" noSelection="['': '']" />
                            </div>
                        </div>
                    
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
