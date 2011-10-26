<%@ page import="snippet.Snippet" %>
<div class="content">
    <g:if test="${params.username}">
    <div><g:message code="following.tags.label" default="Following tags" /></div>
    </g:if><g:else>
    <div><g:message code="tag.label" default="Tags" /></div>
    </g:else>
    <g:if test="${tags}">
    <div>
        <g:each in="${tags}" var="t">
        <g:if test="${params.status}">
        <span><g:link controller="snippet" action="tag" params="[status: params.status, tag: t.name.encodeAsURL()]" class="tag">${t.name.encodeAsHTML()}</g:link></span>
        <span>
            <g:if test="${params.username}">
            <g:message code="following.label" default="Follow"/>
            </g:if>
            <g:else>
            <g:message code="snippet.${params.status}.label" default="${params.status}"/>
            </g:else>
            &times;${t.count.encodeAsHTML()}
        </span>
        </g:if>
        <g:else>
        <span><g:link controller="tag" action="index" params="[tag: t]" class="tag">${t.encodeAsHTML()}&nbsp;&times;${Snippet.countByTag(t).encodeAsHTML()}</g:link></span>
        </g:else>
        </g:each>
    </div>
    <g:if test="${params.max}">
    <div class="more_link"><g:link controller="tag"><g:message code="tags.all.label" default="tags"/></g:link></div>
    </g:if>
    </g:if>
</div>
