<div class="codelist">
    <div class="head">
        <div class="value ${hasErrors(bean: snippetInstance, field: 'name', 'errors')}">
            <g:link action="show" id="${snippetInstance.id}">${fieldValue(bean: snippetInstance, field: "name")}</g:link>
        </div>
        <div>
            ${snippetInstance.author?.username}
        </div>
    </div>
    <div class="body">
        <div class="value ${hasErrors(bean: snippetInstance, field: 'snippet', 'errors')}">
            <g:if test="${patch}"><g:render template="/layouts/patch" model="${[snippetInstance: snippetInstance]}"/><hr/></g:if>
            <div class="code"><pre><code>${snippetInstance.snippet}</code></pre></div>
        </div>
    </div>
</div>
