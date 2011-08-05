
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
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
                    <div valign="top" class="value">${fieldValue(bean: snippetInstance, field: "description")}</div>
                    <div class="clear"></div>
                    <div valign="top" class="value">by&nbsp;<g:link controller="user" action="show" id="${snippetInstance?.author?.id}">${snippetInstance?.author?.username.encodeAsHTML()}</g:link></div>
                    <g:render template="/layouts/tags" model="[snippetInstance:snippetInstance,snippetTags:snippetTags,star:star]"/>
                    <g:render template="/layouts/star" model="[snippetInstance:snippetInstance,stars:stars]"/>
                    <div valign="top" class="date"><g:formatDate date="${snippetInstance?.lastUpdated}" /></div>
                    <div class="clear"></div>
                </div>
                <div class="body">
                    <div valign="top" class="value snippet"><pre><code>${fieldValue(bean: snippetInstance, field: "snippet")}</code></pre></div>
                </div>
                <div class="buttons">
                    <g:form>
                        <g:hiddenField name="id" value="${snippetInstance?.id}" />
                        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </g:form>
                </div>
            </div>
            <g:render template="/layouts/comment" model="[snippetInstance:snippetInstance]"/>
            <g:render template="/layouts/comments" model="[snippetInstance:snippetInstance]"/>
        </div>
    </body>
</html>
