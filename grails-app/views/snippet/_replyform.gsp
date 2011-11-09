<g:formRemote name="reply" class="form-stacked" url="[controller:'snippet',action:'save']" update="[success:'',failure:'reply_'+parent_id]" onSuccess="jQuery('.reply_form').empty();jQuery('.message span').first().text(data).show()">
        <fieldset>
        <legend><g:message code="snippet.button.reply.label" default="reply"/></legend>
        <g:hasErrors bean="${snippetInstance}">
        <div class="errors"><g:renderErrors bean="${snippetInstance}" as="list" /></div>
        </g:hasErrors>
        <g:hiddenField name="parent_id" value="${parent_id}" />
        <div class="prop clearfix">
            <div class="name"><label for="text"><g:message code="snippet.text.label" default="Text" /></label></div>
            <div class="value input"><g:textArea name="text" class="xxlarge" value="${snippetInstance?.text}" /></div>
        </div>
        <div class="prop clearfix">
            <div class="name"><label for="file"><g:message code="snippet.file.label" default="File" /></label></div>
            <div class="value input">
                <g:textArea name="file" class="xxlarge" value="${snippetInstance?.file}" />
                <span class="help-block">コード、入出力例、ログ等</span>
            </div>
        </div>
        <div class="prop clearfix">
            <div class="name"><label for="tags"><g:message code="tag.label" default="Tags" /></label></div>
            <div class="value input">
                <g:textField name="tags" class="xxlarge" value="${tags}" />
                <span class="help-block">空白文字で区切る</span>
            </div>
        </div>
        <div class="actions">
            <span><g:submitButton name="create" class="btn success" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
            <span><input type="button" name="cancel" class="btn danger" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="$('.reply\_form').empty()" /></span>
        </div>
    </fieldset>
</g:formRemote>
