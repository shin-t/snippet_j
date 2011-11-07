<sec:ifLoggedIn>
<g:formRemote name="snippetForm" url="[controller:'snippet', action:'save']" update="[success:'', failure:'snippetForm']" onSuccess="jQuery('input:text, textarea','.dialog').val('');jQuery('.message span').first().text(data).show()">
    <div class="dialog box">
        <g:hiddenField name="parent_id" value="${parent_id}"/>
        <g:hiddenField name="status" value="${snippetInstance.status}"/>
        <p><g:message code="snippet.${snippetInstance.status}.label" default="Snippet"/></p>
        <g:hasErrors bean="${snippetInstance}">
        <div class="errors"><g:renderErrors bean="${snippetInstance}" as="list"/></div>
        </g:hasErrors>
        <div class="prop">
            <div class="name"><label for="text"><g:message code="snippet.text.label" default="Text"/></label></div>
            <div class="value"><g:textArea name="text" value="${snippetInstance.text}"/></div>
        </div>
        <div class="prop">
            <div class="name"><label for="file"><g:message code="snippet.file.label" default="File"/></label></div>
            <div class="value"><g:textArea name="file" value="${snippetInstance.file}" placeholder="コード、入出力例、ログ等"/></div>
        </div>
        <div class="prop">
            <div class="name"><label for="tags"><g:message code="tag.label" default="Tags"/></label></div>
            <div class="value"><g:textField name="tags" value="${snippetInstance.tags?.join(' ')}" placeholder="空白文字で区切る"/></div>
        </div>
        <div class="buttons">
            <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}"/></span>
        </div>
    </div>
</g:formRemote>
</sec:ifLoggedIn>
