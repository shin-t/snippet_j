<sec:ifLoggedIn>
    <g:form controller="comment" action="save">
        <div class="comment content">
            <div class="header">
                <div class="name">
                    <label for="comment">
                        <g:message code="comment.comment.label" default="コメント" />
                    </label>
                </div>
            </div>
            <div class="body">
                <g:hiddenField name="snippet.id" value="${snippetInstance?.id}" />
                <g:textArea name="comment" class="value ${hasErrors(bean: commentInstance, field: 'comment', 'errors')}" value="${commentInstance?.comment}" />
            </div>
            <div class="buttons">
                <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
            </div>
        </div>
    </g:form>
</sec:ifLoggedIn>
