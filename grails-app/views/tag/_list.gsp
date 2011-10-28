<%@ page import="snippet.Snippet"%>
<div id="tags" class="content">
    <div>
        <g:if test="${params.username}">
        <g:message code="following.tags.label" default="Following tags"/>
        </g:if>
        <g:else>
        <g:message code="snippet.${params.status}.label" default=""/> / <g:message code="tag.label" default="Tags"/>
        </g:else>
    </div>
    <g:if test="${tags}">
        <g:each in="${tags}" var="t">
            <p>
                <g:link controller="tag" action="show" params="[status: params.status, tag: t.name.encodeAsURL()]">${t.name.encodeAsHTML()}</g:link>
                <span>&times;${t.count.encodeAsHTML()}</span>
            </p>
        </g:each>
        <g:if test="${params.max}">
            <g:if test="${params.username}">
            <div class="more_link"><g:link controller="tag" params="[status:params.status, username:params.username]"><g:message code="more.link.label" default="tags"/></g:link></div>
            </g:if>
            <g:else>
            <div class="more_link"><g:link controller="tag" params="[status:params.status]"><g:message code="more.link.label" default="tags"/></g:link></div>
            </g:else>
        </g:if>
    </g:if>
</div>
