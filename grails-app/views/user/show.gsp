
<%@ page import="snippet.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
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
                <div class="head">
                    <div valign="top" class="value">${fieldValue(bean: userInstance, field: "username")}</div>
                    <div class="clear"></div>
                </div>
                <div class="body">
                    <div valign="top" class="name"><g:message code="user.snippets.label" default="Snippets" /></div>
                    <div valign="top" style="text-align: left;" class="value">
                        <g:each in="${userInstance.snippets}" var="s">
                            <div><g:link controller="snippet" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></div>
                        </g:each>
                    </div>
                    <div valign="top" class="name"><g:message code="user.comments.label" default="Comments" /></div>
                    <div valign="top" style="text-align: left;" class="value">
                        <g:each in="${userInstance.comments}" var="c">
                            <div><g:link controller="comment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></div>
                        </g:each>
                    </div>
                </div>
                <div class="buttons">
                    <g:form>
                        <g:hiddenField name="id" value="${userInstance?.id}" />
                        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </g:form>
                </div>
            </div>
        </div>
    </body>
</html>
