<div class="user content">
    <div class="header">
        <h2>${fieldValue(bean: userInstance, field: "username")}</>
    </div>
    <div class="body">
        <p><g:link action="snippets" params="[username:params.username]"><g:message code="snippet.label" default="Snippet" /></g:link></p>
        <p><g:link action="starred" params="[username:params.username]"><g:message code="star.label" default="Star" /></g:link></p>
        <p><g:link action="tags" params="[username:params.username]"><g:message code="snippet.tags.label" default="Tags" /></g:link></p>
    </div>
    <g:if test="${userInstance==currentUser}">
    <div class="buttons">
        <g:form controller="user">
            <g:hiddenField name="id" value="${userInstance?.id}" />
            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
        </g:form>
    </div>
    </g:if>
</div>
