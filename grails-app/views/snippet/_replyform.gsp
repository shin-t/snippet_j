<g:formRemote name="reply" url="[controller:'snippet',action:'save']" update="[success:'reply',failure:'reply']" onSuccess="jQuery('.reply_form').empty()">
    <g:hiddenField name="parent_id" value="${parent_id}" />
    <div class="header">reply</div>
    <div class="prop">
        <div class="name">
            <label for="text">
                <g:message code="snippet.text.label" default="Text" />
            </label>
        </div>
        <div class="value ${hasErrors(bean: snippetInstance, field: 'text', 'errors')}">
            <g:textArea name="text" value="${snippetInstance?.text}" />
        </div>
    </div>
    <div class="prop">
        <div class="name">
            <label for="file">
                <g:message code="snippet.file.label" default="File" />
            </label>
        </div>
        <div class="value ${hasErrors(bean: snippetInstance, field: 'file', 'errors')}">
            <g:textArea name="file" value="${snippetInstance?.file}" />
        </div>
    </div>
    <div class="prop">
        <div class="name">
            <label for="tags">
                <g:message code="snippet.tags.label" default="Tags" />
            </label>
        </div>
        <div class="value ${hasErrors(bean: snippetInstance, field: 'tags', 'errors')}">
            <g:textField name="tags" value="${snippetInstance.tags?.join(',')?:tags}" />
        </div>
    </div>
    <div class="buttons">
        <span class="button">
            <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
            <input type="button" name="cancel" value="cancel" onClick="$('.reply\_form').empty()" />
        </span>
    </div>
    <g:javascript>
        $(function(){
            $("input:submit, input:button").button().css("font-size","8pt");
            $("input#deadline").datepicker({dateFormat:'yy/mm/dd'});
        });
    </g:javascript>
</g:formRemote>
