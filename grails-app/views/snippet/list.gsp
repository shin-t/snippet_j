
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
                <div class="tags">
                    <div class="header">
                        <h2>最近のタグ</h2>
                    </div>
                    <div class="body">
                        <div>
                            <g:each in="${tags}" var="c">
                                <g:link action="tags" params="[tags:c[0]]" class="tag">${c[0].encodeAsHTML()}</g:link>(${c[1].encodeAsHTML()})
                            </g:each>
                        </div>
                    </div>
                </div>
                <div class="tag_ranking tags">
                    <div class="header">
                        <h2>タグランキング</h2>
                    </div>
                    <div class="body">
                        <div>
                            <g:each in="${tag_ranking}" var="c">
                                <g:link action="tags" params="[tags:c[0]]" class="tag">${c[0].encodeAsHTML()}</g:link>(${c[1].encodeAsHTML()})<br>
                            </g:each>
                        </div>
                    </div>
                </div>
                <div class="snippet_ranking tags">
                    <div class="header">
                        <h2>スニペットランキング</h2>
                    </div>
                    <div class="body">
                        <div>
                            <g:each in="${snippet_ranking}" var="c">
                                <g:link action="show" params="[id:c[0]]">${c[1].encodeAsHTML()}</g:link>(${c[2].encodeAsHTML()})<br>
                            </g:each>
                        </div>
                    </div>
                </div>
            </div>
            <g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if>
            <g:if test="${params.q}">
                <div class="message">キーワード「${params.q.encodeAsHTML()}」の検索結果 ${snippetInstanceTotal} 件</div>
                <div class="message">タグ: <g:link controller="snippet" action="tags" params="[tags:params.q]">${params.q.encodeAsHTML()}</g:link></div>
            </g:if>
            <g:elseif test="${params.user}">
                <div class="message">${params.user.encodeAsHTML()} /<g:if test="${params.tags}"> ${params.tags.encodeAsHTML()}</g:if> (${snippetInstanceTotal})</div>
            </g:elseif>
            <g:elseif test="${params.tags}">
                <div class="message">タグ「${params.tags.encodeAsHTML()}」の検索結果 ${snippetInstanceTotal} 件</div>
            </g:elseif>
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
