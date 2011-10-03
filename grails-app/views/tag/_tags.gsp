<div class="tags">
    <h2><g:message code="snippet.tags.label" default="Tags" /></h2>
    <ul>
        <g:each in="${tags}" var="tag">
        <li><g:link controller="tag" params="[tag: tag[0]]" class="tag">${tag[0].encodeAsHTML()}(${tag[1].encodeAsHTML()})</g:link></li>
        </g:each>
    </ul>
</div>
