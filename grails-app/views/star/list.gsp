
<%@ page import="snippet.Star" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'star.label', default: 'Star')}" />
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
                    <g:each in="${starInstanceList}" status="i" var="starInstance">
                        <div class="dialog">
                        
                            
                                <div class="head"><g:link action="show" id="${starInstance.id}">${fieldValue(bean: starInstance, field: "id")}</g:link></div>
                            
                                <div>${fieldValue(bean: starInstance, field: "author")}</div>
                            
                                <div>${fieldValue(bean: starInstance, field: "snippet")}</div>
                            
                        </div>
                    </g:each>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${starInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
