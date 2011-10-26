<div class="dialog">
    <g:formRemote name="snippetForm" url="[controller:'snippet',action:'save']" update="[success:'', failure:'form_dialog']" onSuccess="jQuery('input:text, textarea','.dialog').val('');jQuery('#lists').prepend(data);button_icons()">
        <g:hiddenField name="parent_id" value="${parent_id}"/>
        <g:hiddenField name="help" value="${snippetInstance.help}"/>
        <g:hiddenField name="status" value="${snippetInstance.status}"/>
        <h1 class="header"><g:message code="snippet.${snippetInstance.status}.label" default="Snippet"/></h1>
        <g:hasErrors bean="${snippetInstance}">
        <div class="errors"><g:renderErrors bean="${snippetInstance}" as="list"/></div>
        </g:hasErrors>
        <div class="prop">
            <div class="name"><label for="text"><g:message code="snippet.text.label" default="Text"/></label></div>
            <div class="value"><g:textArea name="text" value="${snippetInstance.text}" /></div>
        </div>
        <div class="prop">
            <div class="name"><label for="file"><g:message code="snippet.file.label" default="File"/></label></div>
            <div class="value"><g:textArea name="file" value="${snippetInstance.file}" placeholder="コード、入出力例、ログ等"/></div>
        </div>
        <div class="prop">
            <div class="name"><label for="tags"><g:message code="tag.label" default="Tags"/></label></div>
            <div class="value"><g:textField name="tags" value="${snippetInstance.tags?.join(' ')}" placeholder="空白文字で区切る"/></div>
        </div>
        <div class="prop" style="${snippetInstance.status=='problem'?'':'display:none'}">
            <div class="name"><label for="deadline"><g:message code="snippet.deadline.label" default="Deadline"/></label></div>
            <div class="value"><g:textField name="deadline" value="${snippetInstance?.deadline}"/></div>
        </div>
        <div class="buttons">
            <span class="button">
                <sec:ifLoggedIn>
                <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                <g:link controller="login" action="index">ログイン/ユーザー登録して投稿してください。</g:link>
                </sec:ifNotLoggedIn>
            </span>
        </div>
    </g:formRemote>
</div>
