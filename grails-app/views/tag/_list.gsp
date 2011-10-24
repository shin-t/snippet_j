<%@ page import="snippet.Snippet" %>
<div class="content">
    <g:if test="${params.username}">
    <div><g:message code="following.tags.label" default="Following tags" /></div>
    </g:if><g:else>
    <div><g:message code="snippet.tags.label" default="Tags" /></div>
    </g:else>
    <g:if test="${tags}">
    <div>
        <g:each in="${tags}" var="t">
        <span><g:link controller="snippet" action="tag" params="[status: params.status, tag: t]" class="tag">${t.encodeAsHTML()}&nbsp;&times;${Snippet.countByTag(t).encodeAsHTML()}</g:link></span>
        </g:each>
    </div>
    <g:if test="${params.max}">
    <div class="more_link"><g:link controller="tag"><g:message code="tags.all.label" default="tags"/></g:link></div>
    </g:if>
    </g:if>
</div>
