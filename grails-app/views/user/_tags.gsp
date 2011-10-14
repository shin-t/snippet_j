<div class="content">
    <div><g:message code="following.tags.label" default="Following tags" /></div>
    <div>
        <g:each in="${tags}" var="t">
        <span><g:link controller="t" params="[tag: t]" class="tag">${t.encodeAsHTML()}</g:link></span>
        </g:each>
    </div>
    <div style="text-align:right"><g:link controller="tag"><g:message code="tags.all.label" default="tags"/></g:link></div>
</div>
