<sec:ifLoggedIn>
<div class="box">
    <g:formRemote name="dialog" class="form-stacked" url="[controller:'snippet', action:'save']" update="[success:'', failure:'dialog']" onSuccess="jQuery('input:text, textarea','.dialog').val('');jQuery('.message span').first().text(data).show()">
        <fieldset>
            <g:hiddenField name="status" value="${snippetInstance.status}"/>
            <legend><g:message code="snippet.${snippetInstance.status}.label" default="Snippet"/></legend>
            <g:hasErrors bean="${snippetInstance}">
            <div class="errors"><g:renderErrors bean="${snippetInstance}" as="list"/></div>
            </g:hasErrors>
            <div class="prop clearfix">
                <div class="name"><label for="text"><g:message code="snippet.text.label" default="Text"/></label></div>
                <div class="value input"><g:textArea name="text" class="xxlarge" value="${snippetInstance.text}"/></div>
            </div>
            <div class="prop clearfix">
                <div class="name"><label for="file"><g:message code="snippet.file.label" default="File"/></label></div>
                <div class="value input">
                    <g:textArea name="file" class="xxlarge" value="${snippetInstance.file}"/>
                    <span class="help-block">コード、入出力例、ログ等</span>
                </div>
            </div>
            <div class="prop clearfix">
                <div class="name"><label for="tags"><g:message code="tag.label" default="Tags"/></label></div>
                <div class="value input">
                    <g:textField name="tags" class="xxlarge" value="${snippetInstance.tags?.join(' ')}"/>
                    <span class="help-block">空白文字で区切る</span>
                </div>
            </div>
        </fieldset>
        <div class="actions">
            <span><g:submitButton name="create" class="btn success" value="${message(code: 'default.button.create.label', default: 'Create')}"/></span>
        </div>
    </g:formRemote>
</div>
</sec:ifLoggedIn>
