<div class="tags">
    <h2><g:message code="snippet.tags.label" default="Tags" /></h2>
    <g:each in="${tags}" var="tag">
    <span><g:link controller="tag" params="[tag: tag[0]]" class="tag">${tag[0].encodeAsHTML()}</g:link>(${tag[1].encodeAsHTML()})</span>
    </g:each>
    <div style="text-align:right"><g:link controller="tag"><g:message code="tags.all.label" default="tags"/></g:link></div>
</div>
