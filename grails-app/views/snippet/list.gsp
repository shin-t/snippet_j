
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
                <div class="message">キーワード「${params.q.encodeAsHTML()}」の検索結果 ${snippetInstanceTotal} 件</div>
                <div class="message">タグ: <g:link controller="snippet" action="list" params="[tags:params.q]">${params.q.encodeAsHTML()}</g:link></div>
            </g:if>
            <g:elseif test="${params.user}">
                <div class="message">${params.user.encodeAsHTML()} /<g:if test="${params.tags}"> ${params.tags.encodeAsHTML()}</g:if> (${snippetInstanceTotal})</div>
            </g:elseif>
            <g:elseif test="${params.tags}">
                <div class="message">タグ「${params.tags.encodeAsHTML()}」の検索結果 ${snippetInstanceTotal} 件</div>
            </g:elseif>
            <div class="sidebar"></div>
            <div class="list">
                <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
                    <div class="snippet content">
                        <div class="header">
                            <h2>
                                <g:link action="show" id="${snippetInstance.id}">
                                    ${fieldValue(bean: snippetInstance, field: "name")}
                                </g:link>
                            </h2>
                            <div class="float_left"><g:link controller="user" action="show" params="[username:snippetInstance?.author?.username]">${snippetInstance?.author?.username.encodeAsHTML()}</g:link></div>
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
