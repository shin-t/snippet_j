
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if>
            <g:if test="${params.q}">
                <div class="message">keyword: ${params.q.encodeAsHTML()} (${snippetInstanceTotal} snippets found)</div>
                <div class="message">tags: <g:link controller="snippet" action="list" params="[tags:params.q]">${params.q.encodeAsHTML()}</g:link></div>
            </g:if>
            <g:elseif test="${params.user}">
                <div class="message">${params.user.encodeAsHTML()} /<g:if test="${params.tags}"> ${params.tags.encodeAsHTML()}</g:if> (${snippetInstanceTotal})</div>
            </g:elseif>
            <g:elseif test="${params.tags}">
                <div class="message"><g:if test="${params.tags}"> ${params.tags.encodeAsHTML()}</g:if> (${snippetInstanceTotal})</div>
            </g:elseif>
            <g:if test="${user}"><g:render template="/layouts/user" model="[userInstance: user]"/></g:if>
            <div class="list">
                <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
                    <div class="snippet">
                        <div class="header">
                            <h2>
                                <g:link action="show" id="${snippetInstance.id}">
                                    ${fieldValue(bean: snippetInstance, field: "description")}
                                </g:link>
                            </h2>
                            <div class="float_left">by&nbsp;<g:link controller="user" action="show" id="${snippetInstance?.author?.id}">${snippetInstance?.author?.username.encodeAsHTML()}</g:link></div>
                            <div class="float_right"><g:formatDate date="${snippetInstance.dateCreated}" /></div>
                            <div class="clear"></div>
                        </div>
                        <div class="body">
                            ${snippetInstance.snippet.encodeAsHTML()}
                        </div>
                    </div>
                </g:each>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${snippetInstanceTotal}" params="[tags:params.tags,user:params.user,q:params.q]" />
            </div>
        </div>
    </body>
</html>
