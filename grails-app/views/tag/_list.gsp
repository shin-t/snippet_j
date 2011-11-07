<g:if test="${tags}">
<div class="box">
    <p>
        <g:if test="${actionName == 'following'}">
        <g:message code="following.tags.label" default="Following tags"/>
        </g:if>
        <g:else>
        <g:message code="tag.label" default="Tags"/>
        </g:else>
    </p>
    <g:each in="${tags}" var="t">
    <p>
        <g:link controller="tag" action="show" params="[status: params.status, tag: t.name.encodeAsURL()]">${t.name.encodeAsHTML()}</g:link>
        <span class="small">&times;${t.count.encodeAsHTML()}</span>
    </p>
    </g:each>
    <g:if test="${actionName == 'recent'}">
    <div class="more_link small"><g:link controller="tag" action="list" params="[status:params.status]"><g:message code="more.link.label" default="tags"/></g:link></div>
    </g:if>
</div>
</g:if>
