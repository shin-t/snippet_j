<div class="content">
    <div><g:message code="snippet.tags.label" default="Tags" /></div>
    <div>
        <g:each in="${tags}" var="t">
        <span><g:link controller="tag" params="[tag: t]" class="tag">${t.encodeAsHTML()}</g:link></span>
        </g:each>
    </div>
    <g:if test="${actionName=='ranking'}">
    <div style="text-align:right"><g:link controller="tag"><g:message code="tags.all.label" default="tags"/></g:link></div>
    </g:if>
</div>
