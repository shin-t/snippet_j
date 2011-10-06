<g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
<g:formRemote name="snippetForm" url="[controller:'snippet',action:'save']" update="[success:'lists',failure:'form_dialog']" onSuccess="${remoteFunction(action:'create',update:'form_dialog')}">
    <g:javascript>
        $("input:submit, input:button").button();
        $("input#deadline").datepicker({dateFormat:'yy/mm/dd'});
    </g:javascript>
    <g:hiddenField name="parent_id" value="${parent_id}" />
    <g:hiddenField name="status" value="${snippetInstance?.status}" />
    <div class="dialog">
        <g:hasErrors bean="${snippetInstance}">
        <div class="errors"><g:renderErrors bean="${snippetInstance}" as="list" /></div>
        </g:hasErrors>
        <div class="header">${entityName}</div>
        <div class="prop">
            <div class="name">
                <label for="text"><g:message code="snippet.text.label" default="Text" /></label>
            </div>
            <div class="value ${hasErrors(bean: snippetInstance, field: 'text', 'errors')}">
                    <g:textArea name="text" value="${snippetInstance?.text}" />
            </div>
        </div>
        <div class="prop">
            <div class="name">
                <label for="file"><g:message code="snippet.file.label" default="File" /></label>
            </div>
            <div class="value ${hasErrors(bean: snippetInstance, field: 'file', 'errors')}">
                    <g:textArea name="file" value="${snippetInstance?.file}" />
            </div>
        </div>
        <div class="prop">
            <div class="name">
                <label for="tags"><g:message code="snippet.tags.label" default="Tags" /></label>
            </div>
            <div class="value ${hasErrors(bean: snippetInstance, field: 'tags', 'errors')}">
                    <g:textField name="tags" value="${snippetInstance.tags?.join(' ')}" />
            </div>
        </div>
        <g:if test="${snippetInstance?.status == 1}">
        <g:hiddenField name="help" value="${snippetInstance?.help}" />
        </g:if>
        <g:elseif test="${snippetInstance?.status == 2}">
        <div class="prop">
            <div class="name">
                <label for="deadline"><g:message code="snippet.deadline.label" default="Deadline" /></label>
            </div>
            <div class="value ${hasErrors(bean: snippetInstance, field: 'deadline', 'errors')}">
                    <g:textField name="deadline" value="${snippetInstance?.deadline}" />
            </div>
        </div>
        </g:elseif>
        <div class="buttons">
            <span class="button">
                <sec:ifLoggedIn>
                <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                <g:link controller="login">ログイン/ユーザー登録して投稿してください。</g:link>
                </sec:ifNotLoggedIn>
            </span>
        </div>
    </div>
</g:formRemote>
