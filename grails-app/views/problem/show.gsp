
<%@ page import="snippet.Problem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'problem.label', default: 'Problem')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
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
            <g:if test="${session.user}"><span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></g:if>
        </div>
        <div class="body">
            <div class="sidebar"></div>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                
                        
                <div class="header">
                        
                        
                        <div class="value"><g:link controller="user" action="show" id="${problemInstance?.user?.id}">${problemInstance?.user?.encodeAsHTML()}</g:link></div>
                        
                        
                    </div>
                        
                
                        
                        
                        <div class="value">${fieldValue(bean: problemInstance, field: "text")}</div>
                        
                        
                
                        
                        
                        <div class="value">${fieldValue(bean: problemInstance, field: "file")}</div>
                        
                        
                
                        
                        
                        <div class="value"><g:formatDate date="${problemInstance?.deadline}" /></div>
                        
                        
                
                        
                        
                    <div style="text-align: left;" class="value">
                        <ul>
                        <g:each in="${problemInstance.children}" var="c">
                            <li><g:link controller="snippet" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                        </g:each>
                        </ul>
                    </div>
                        
                        
                
                <div><g:link action="show" id="${problemInstance.id}"><g:formatDate date="${problemInstance.lastUpdated}" /></g:link></div>
                <div class="buttons">
                    <g:form>
                        <g:hiddenField name="id" value="${problemInstance?.id}" />
                        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </g:form>
                </div>
            </div>
        </div>
    </body>
</html>
