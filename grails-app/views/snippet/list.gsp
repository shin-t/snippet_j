
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
                <div class="lists tags">
                    <p><g:link controller="user" action="list"><g:message code="default.list.label" args="${[message(code:'user.label')]}" default="Users" /></g:link></p>
                    <p><g:link action="tag"><g:message code="default.list.label" args="${[message(code:'snippet.tags.label')]}" default="Tags" /></g:link></p>
                </div>
                <div class="tags">
                    <div class="header">
                        <h2><g:message code="recent.tag.label" default="Recent Tag" /></h2>
                    </div>
                    <div class="body">
                        <g:each in="${tags}" var="c">
                            <div class="tag"><g:link action="tag" params="[tag:c[0]]" class="tag">${c[0].encodeAsHTML()}</g:link>(${c[1].encodeAsHTML()})</div>
                        </g:each>
                    </div>
                </div>
                <div class="tag_ranking tags">
                    <div class="header">
                        <h2><g:message code="ranking.tag.label" default="Tag Ranking" /></h2>
                    </div>
                    <div class="body">
                        <g:each in="${tag_ranking}" var="c">
                            <div class="tag"><g:link action="tag" params="[tag:c[0]]" class="tag">${c[0].encodeAsHTML()}</g:link>(${c[1].encodeAsHTML()})</div>
                        </g:each>
                    </div>
                </div>
                <div class="snippet_ranking tags">
                    <div class="header">
                        <h2><g:message code="ranking.snippet.label" default="Snippet Ranking" /></h2>
                    </div>
                    <div class="body">
                        <g:each in="${snippet_ranking}" var="c">
                            <div class="tag"><g:link action="show" params="[id:c[0]]">${c[1].encodeAsHTML()}</g:link>(${c[2].encodeAsHTML()})</div>
                        </g:each>
                    </div>
                </div>
            </div>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:if test="${params.q}">
                <div class="message">
                    <g:message code="search.keyword.message" args="${[params.q.encodeAsHTML(),snippetInstanceTotal]}" />
                </div>
                <div class="message">
                    <g:message code="snippet.tags.label" />: <g:link controller="snippet" action="tag" params="[tag:params.q]">${params.q.encodeAsHTML()}</g:link>
                </div>
            </g:if>
            <g:elseif test="${params.user}">
                <div class="message">${params.user.encodeAsHTML()} /<g:if test="${params.tags}"> ${params.tags.encodeAsHTML()}</g:if> (${snippetInstanceTotal})</div>
            </g:elseif>
            <g:elseif test="${params.tag}">
                <div class="message">
                    <g:message code="search.tag.message" args="${[params.tag.encodeAsHTML(),snippetInstanceTotal]}" />
                </div>
            </g:elseif>
            <g:render template="/layouts/snippets" model="[snippetInstanceList:snippetInstanceList]" />
            <div class="paginateButtons">
                <g:paginate total="${snippetInstanceTotal}" params="[tag:params.tag,user:params.user,q:params.q]" />
            </div>
        </div>
    </body>
</html>
