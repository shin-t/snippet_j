

<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
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
            <g:hasErrors bean="${snippetInstance}">
            <div class="errors">
                <g:renderErrors bean="${snippetInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${snippetInstance?.id}" />
                <g:hiddenField name="version" value="${snippetInstance?.version}" />
                <div class="dialog">
                    <div class="header">${entityName}</div>
                    
                        <div class="prop">
                            <div class="name">
                              <label for="text"><g:message code="snippet.text.label" default="Text" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: snippetInstance, field: 'text', 'errors')}">
                                <g:textArea name="text" cols="40" rows="5" value="${snippetInstance?.text}" />
                            </div>
                        </div>
                    
                        <div class="prop">
                            <div class="name">
                              <label for="file"><g:message code="snippet.file.label" default="File" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: snippetInstance, field: 'file', 'errors')}">
                                <g:textArea name="file" cols="40" rows="5" value="${snippetInstance?.file}" />
                            </div>
                        </div>
                    
                        <div class="prop">
                            <div class="name">
                              <label for="recepting"><g:message code="snippet.recepting.label" default="Recepting" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: snippetInstance, field: 'recepting', 'errors')}">
                                <g:checkBox name="recepting" value="${snippetInstance?.recepting}" />
                            </div>
                        </div>
                    
                        <div class="prop">
                            <div class="name">
                              <label for="deadline"><g:message code="snippet.deadline.label" default="Deadline" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: snippetInstance, field: 'deadline', 'errors')}">
                                <g:datePicker name="deadline" precision="day" value="${snippetInstance?.deadline}" default="none" noSelection="['': '']" />
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
