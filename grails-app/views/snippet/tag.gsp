
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
            <g:elseif test="${params.tag}">
                <div class="message">
                    <g:message code="search.tag.message" args="${[params.tag.encodeAsHTML(),snippetInstanceTotal]}" />
                </div>
            </g:elseif>
            <div class="tags_list content user">
                <div class="header">
                    <h2><g:message code="default.list.label" args="${[message(code:'snippet.tags.label')]}" default="Tags" /></h2>
                </div>
                <div class="body">
                    <g:each in="${tags}" var="c">
                        <div class="tag float_left"><g:link action="tag" params="[tag:c[0]]" class="tag">${c[0].encodeAsHTML()}</g:link>(${c[1].encodeAsHTML()})</div>
                    </g:each>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${total}" params="[tag:params.tag]" />
            </div>
        </div>
    </body>
</html>
