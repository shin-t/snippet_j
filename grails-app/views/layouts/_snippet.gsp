<div class="dialog">
    <div class="head">
        <div class="value ${hasErrors(bean: snippetInstance, field: 'gist_id', 'errors')}">
            <g:link action="show" id="${snippetInstance.id}">${fieldValue(bean: snippetInstance, field: 'gist_id')}</g:link>
        </div>
        <div class="value ${hasErrors(bean: snippetInstance, field: 'snippet', 'errors')}">
            <g:if test="${currentUser == snippetInstance.author}">
            <g:form method="post">
                <g:hiddenField name="id" value="${snippetInstance?.id}" />
                <g:hiddenField name="version" value="${snippetInstance?.version}" />
                <g:hiddenField name="gist_id" value="${snippetInstance?.gist_id}" />
                <g:textField name="tags" value="${snippetInstance?.tags.join(',')}" />
                <span class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </span>
            </g:form>
            </g:if>
        </div>
    </div>
    <div class="body"></div>
</div>
