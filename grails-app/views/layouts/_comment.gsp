<sec:ifLoggedIn>
    <g:form controller="comment" action="save" >
        <div class="comment">
            <div class="head">
                <div class="prop">
                    <div valign="top" class="name">
                        <label for="comment">
                            <g:message code="comment.comment.label" default="Comment" />
                        </label>
                    </div>
                </div>
            </div>
            <div class="body">
                <div valign="top" class="value ${hasErrors(bean: commentInstance, field: 'comment', 'errors')}">
                    <g:textArea name="comment" value="${commentInstance?.comment}" />
                </div>
                <g:hiddenField name="snippet.id" value="${snippetInstance?.id}" />
            </div>
            <div class="buttons">
                <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
            </div>
        </div>
    </g:form>
</sec:ifLoggedIn>
