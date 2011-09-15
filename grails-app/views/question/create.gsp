

<%@ page import="snippet.Question" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
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
        </div>
        <div class="body">
            <div class="sidebar"></div>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${questionInstance}">
            <div class="errors">
                <g:renderErrors bean="${questionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <div class="header">${entityName}</div>
                    
                        <div class="prop">
                            <div class="name">
                                <label for="text"><g:message code="question.text.label" default="Text" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: questionInstance, field: 'text', 'errors')}">
                                    <g:textArea name="text" cols="40" rows="5" value="${questionInstance?.text}" />
                            </div>
                        </div>
                    
                        <div class="prop">
                            <div class="name">
                                <label for="file"><g:message code="question.file.label" default="File" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: questionInstance, field: 'file', 'errors')}">
                                    <g:textArea name="file" cols="40" rows="5" value="${questionInstance?.file}" />
                            </div>
                        </div>
                    
                        <div class="prop">
                            <div class="name">
                                <label for="recepting"><g:message code="question.recepting.label" default="Recepting" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: questionInstance, field: 'recepting', 'errors')}">
                                    <g:checkBox name="recepting" value="${questionInstance?.recepting}" />
                            </div>
                        </div>
                    
                    <div class="buttons">
                        <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    </div>
                </div>
            </g:form>
        </div>
    </body>
</html>
