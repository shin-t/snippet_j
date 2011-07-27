<div class="codelist">
    <div class="head">
        <div class="value ${hasErrors(bean: snippetInstance, field: 'name', 'errors')}">
            <g:link action="show" id="${snippetInstance.id}">${fieldValue(bean: snippetInstance, field: "gist_id")}</g:link>
        </div>
    </div>
    <div class="body">
        <div class="value ${hasErrors(bean: snippetInstance, field: 'snippet', 'errors')}">
            <div class="tags">${snippetInstance?.tags}</div>
        </div>
    </div>
</div>
