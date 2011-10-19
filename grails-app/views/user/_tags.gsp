<div class="content">
    <div><g:message code="following.tags.label" default="Following tags" /></div>
    <div>
        <g:each in="${tags}" var="t">
        <span><g:link controller="tag" params="[tag: t.name]" class="tag">${t.name.encodeAsHTML()}</g:link></span>
        </g:each>
    </div>
    <div style="text-align:right"><g:link controller="user"><g:message code="more.link.label" default="tags"/></g:link></div>
</div>
