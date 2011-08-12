<div class="user content">
    <div class="header">
        <h2>${fieldValue(bean: userInstance, field: "username")}</>
    </div>
    <div class="body">
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
