<div class="user">
    <div class="header">
        <h2>${fieldValue(bean: userInstance, field: "username")}</>
    </div>
    <div class="body">
        <h3>Tags</h3>
        <g:form url='[controller: "snippet", action: "list"]' id="searchableForm" name="searchableForm" method="get">
            <g:hiddenField name="user" value="${userInstance.username}"/>
            <g:textField name="tags" value="${params.tags}"/><input type="submit" value="Search" />
        </g:form>
        <div class="tags">
            <g:each in="${tags}" var="c">
                <g:link controller="snippet" actin="list" params="[tags:c[0],user:userInstance.username]" class="tag">${c[0].encodeAsHTML()}</g:link>(${c[1].encodeAsHTML()})
            </g:each>
        </div>
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
