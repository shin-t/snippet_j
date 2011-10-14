<div class="content">
    <h2><g:message code="snippet.tags.label" default="Tags" /></h2>
    <g:each in="${tags}" var="tag">
    <span><g:link controller="tag" params="[tag: tag]" class="tag">${tag.encodeAsHTML()}</g:link></span>
    </g:each>
    <div style="text-align:right"><g:link controller="tag"><g:message code="tags.all.label" default="tags"/></g:link></div>
</div>
