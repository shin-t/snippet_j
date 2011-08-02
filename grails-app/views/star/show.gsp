
<%@ page import="snippet.Star" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'star.label', default: 'Star')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <g:if test="${session.user}"><span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></g:if>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                    
                            <div valign="top" class="name"><g:message code="star.author.label" default="Author" /></div>
                            
                            <div valign="top" class="value"><g:link controller="user" action="show" id="${starInstance?.author?.id}">${starInstance?.author?.encodeAsHTML()}</g:link></div>
                            
                    
                            <div valign="top" class="name"><g:message code="star.snippet.label" default="Snippet" /></div>
                            
                            <div valign="top" class="value"><g:link controller="snippet" action="show" id="${starInstance?.snippet?.id}">${starInstance?.snippet?.encodeAsHTML()}</g:link></div>
                            
                    
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${starInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
