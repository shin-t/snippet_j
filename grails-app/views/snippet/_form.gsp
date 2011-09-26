<g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
<g:formRemote name="dialog" url="[controller:'snippet',action:'save']" update="[success:'list',failure:'form_dialog']" >
    <g:javascript>
        $(function(){
            $("input:submit, input:button").button().css("font-size","8pt");
            $("input#deadline").datepicker({dateFormat:'yy/mm/dd'});
        });
    </g:javascript>
    <g:hiddenField name="parent_id" value="${parent_id}" />
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
                    <g:textArea name="text" rows="3" value="${snippetInstance?.text}" />
            </div>
        </div>
        <div class="prop">
            <div class="name">
                <label for="file"><g:message code="snippet.file.label" default="File" /></label>
            </div>
            <div class="value ${hasErrors(bean: snippetInstance, field: 'file', 'errors')}">
                    <g:textArea name="file" rows="3" value="${snippetInstance?.file}" />
            </div>
        </div>
        <div class="prop">
            <div class="name">
                <label for="help"><g:message code="snippet.help.label" default="Help" /></label>
            </div>
            <div class="value ${hasErrors(bean: snippetInstance, field: 'help', 'errors')}">
                    <g:checkBox name="help" value="${snippetInstance?.help}" />
            </div>
        </div>
        <div class="prop">
            <div class="name">
                <label for="deadline"><g:message code="snippet.deadline.label" default="Deadline" /></label>
            </div>
            <div class="value ${hasErrors(bean: snippetInstance, field: 'deadline', 'errors')}">
                    <g:textField name="deadline" value="${snippetInstance?.deadline}" />
            </div>
        </div>
        <div class="buttons">
            <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
        </div>
    </div>
</g:formRemote>
