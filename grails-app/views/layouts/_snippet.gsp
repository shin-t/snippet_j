<div class="codelist">
    <div class="head">
        <div class="value ${hasErrors(bean: snippetInstance, field: 'name', 'errors')}">
            <g:link action="show" id="${snippetInstance.id}">${fieldValue(bean: snippetInstance, field: "name")}</g:link>
        </div>
        <div>
            ${snippetInstance.author?.username}
        </div>
        <div class="value ${hasErrors(bean: snippetInstance, field: 'lastUpdated', 'errors')}">
            <g:message code="snippet.lastUpdated.label" default="last updated" />:<g:formatDate date="${snippetInstance.lastUpdated}" />
        </div>
    </div>
    <div class="body">
        <div class="value ${hasErrors(bean: snippetInstance, field: 'snippet', 'errors')}">
            <g:if test="${patch}"><g:render template="/layouts/patch" model="${[snippetInstance: snippetInstance]}"/><hr/></g:if>
            <div class="code"><pre><code>${snippetInstance.snippet}</code></pre></div>
        </div>
    </div>
</div>
