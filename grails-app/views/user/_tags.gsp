<div class="content">
    <div><g:message code="following.tags.label" default="Following tags" /></div>
    <g:if test="${tags}">
    <div>
        <g:each in="${tags}" var="t">
        <span><g:link controller="tag" params="[tag: t.name]" class="tag">${t.name.encodeAsHTML()}</g:link></span>
        </g:each>
    </div>
    <g:if test="${!params.username}">
    <div class="more_link"><g:link controller="user" params="[username:sec.loggedInUserInfo(field:'username')]"><g:message code="more.link.label" default="tags"/></g:link></div>
    </g:if>
    </g:if>
</div>
