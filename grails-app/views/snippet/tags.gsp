
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
            <div class="sidebar">
            </div>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:if test="${params.q}">
                <div class="message">
                    <g:message code="search.keyword.message" args="${[params.q.encodeAsHTML(),snippetInstanceTotal]}" />
                </div>
                <div class="message">
                    <g:message code="snippet.tags.label" />: <g:link controller="snippet" action="tags" params="[tags:params.q]">${params.q.encodeAsHTML()}</g:link>
                </div>
            </g:if>
            <g:elseif test="${params.user}">
                <div class="message">${params.user.encodeAsHTML()} /<g:if test="${params.tags}"> ${params.tags.encodeAsHTML()}</g:if> (${snippetInstanceTotal})</div>
            </g:elseif>
            <g:elseif test="${params.tags}">
                <div class="message">
                    <g:message code="search.tag.message" args="${[params.tags.encodeAsHTML(),snippetInstanceTotal]}" />
                </div>
            </g:elseif>
            <div class="tags_list content user">
                <div class="header">
                    <h2><g:message code="default.list.label" args="${[message(code:'snippet.tags.label')]}" default="Tags" /></h2>
                </div>
                <div class="body">
                    <g:each in="${tags}" var="c">
                        <div class="tag float_left"><g:link action="tags" params="[tags:c[0]]" class="tag">${c[0].encodeAsHTML()}</g:link>(${c[1].encodeAsHTML()})</div>
                    </g:each>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${total}" params="[tags:params.tags,user:params.user,q:params.q]" />
            </div>
        </div>
    </body>
</html>
