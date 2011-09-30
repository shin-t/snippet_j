<div class="tags">
    <h2><g:message code="snippet.tags.label" default="Tags" /></h2>
    <ul>
        <g:each in="${tags}" var="tag">
        <li><g:link controller="user" action="tags" params="[tag: tag[0], username: username?:'']" class="tag">${tag[0].encodeAsHTML()}(${tag[1].encodeAsHTML()})</g:link></li>
        </g:each>
    </ul>
</div>
