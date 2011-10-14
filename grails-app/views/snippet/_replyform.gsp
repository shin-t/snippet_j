<g:formRemote name="reply" url="[controller:'snippet',action:'save']" update="[success:'',failure:'reply_'+parent_id]" onSuccess="jQuery('.reply_form').empty();jQuery('#lists').prepend(data);button_icons()">
    <g:hiddenField name="parent_id" value="${parent_id}" />
    <div class="header"><g:message code="default.reply.label" default="reply"/></div>
    <g:hasErrors bean="${snippetInstance}">
    <div class="errors"><g:renderErrors bean="${snippetInstance}" as="list" /></div>
    </g:hasErrors>
    <div class="prop">
        <div class="name">
            <label for="text">
                <g:message code="snippet.text.label" default="Text" />
            </label>
        </div>
        <div class="value">
            <g:textArea name="text" value="${snippetInstance?.text}" />
        </div>
    </div>
    <div class="prop">
        <div class="name">
            <label for="file">
                <g:message code="snippet.file.label" default="File" />
            </label>
        </div>
        <div class="value">
            <g:textArea name="file" value="${snippetInstance?.file}" />
        </div>
    </div>
    <div class="prop">
        <div class="name">
            <label for="tags">
                <g:message code="snippet.tags.label" default="Tags" />
            </label>
        </div>
        <div class="value">
            <g:textField name="tags" value="${snippetInstance.tags?.join(',')?:tags}" />
        </div>
    </div>
    <div class="buttons">
        <span class="button">
            <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
        </span>
        <span class="button">
            <input type="button" name="cancel" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="$('.reply\_form').empty()" />
        </span>
    </div>
    <g:javascript>
        $(function(){
            $("input:submit, input:button").button().css("font-size","8pt");
            $("input#deadline").datepicker({dateFormat:'yy/mm/dd'});
        });
    </g:javascript>
</g:formRemote>
