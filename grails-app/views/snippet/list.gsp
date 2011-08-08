
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <sec:ifLoggedIn><span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></sec:ifLoggedIn>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
                    <div class="dialog">
                        <div class="head">
                            <div class="value">
                                <g:link action="show" id="${snippetInstance.id}">
                                    ${fieldValue(bean: snippetInstance, field: "description")}
                                </g:link>
                            </div>
                            <div class="clear"></div>
                            <div valign="top" class="value">by&nbsp;<g:link controller="user" action="show" id="${snippetInstance?.author?.id}">${snippetInstance?.author?.username.encodeAsHTML()}</g:link></div>
                            <sec:ifLoggedIn>
                            <div class="clear"></div>
                            <div class="value">
                                <span>Tags:&nbsp;${snippetInstance.tags()?.join(',')}</span>
                            </div>
                            </sec:ifLoggedIn>
                            <div class="date"><g:formatDate date="${snippetInstance.lastUpdated}" /></div>
                            <div class="clear"></div>
                        </div>
                        <div class="snippet"><pre><code>${fieldValue(bean: snippetInstance, field: "snippet")}</code></pre></div>
                    </div>
                </g:each>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${snippetInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
