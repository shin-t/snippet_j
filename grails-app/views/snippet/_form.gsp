<g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
<g:formRemote name="snippetForm" url="[controller:'snippet',action:'save']" update="[success:'lists',failure:'form_dialog']" onSuccess="jQuery('input:text, textarea','.dialog').val('')">
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
                <g:textField name="tags" value="${snippetInstance.tags?.join(',')}" />
            </div>
        </div>
        <g:hiddenField name="help" value="${snippetInstance?.help}" />
        <div class="prop" style="${snippetInstance?.status==2?'':'display:none'}">
            <div class="name">
                <label for="deadline"><g:message code="snippet.deadline.label" default="Deadline" /></label>
            </div>
            <div class="value ${hasErrors(bean: snippetInstance, field: 'deadline', 'errors')}">
                <g:textField name="deadline" value="${snippetInstance?.deadline}" />
            </div>
        </div>
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
        <div id="snippet_status">
            <g:radio name="status" value="0" id="status_0"/><g:radio name="status" value="1" id="status_1"/><g:radio name="status" value="2" id="status_2"/>
            <label for="status_0">Snippet</label><label for="status_1">Question</label><label for="status_2">Problem</label>
        </div>
        <g:javascript>
        (function(){
            var update = function(){
                switch($("#snippet_status input:checked").val()){
                    case '0':
                        $("input[name='deadline']").parent().parent().hide();
                        $(".dialog .header").text("Snippet");
                        break;
                    case '1':
                        $("input[name='deadline']").parent().parent().hide();
                        $(".dialog .header").text("Question");
                        break;
                    case '2':
                        $("input[name='deadline']").parent().parent().show();
                        $(".dialog .header").text("Problem");
                        break;
                    default:
                        break;
                }
            }
            $("#status_${snippetInstance.status}").attr('checked','checked');
            $("#snippet_status").buttonset().children("input").click(update);
            $("input:submit, input:button").button();
            $("input#deadline").datepicker({dateFormat:'yy/mm/dd'});
        })();
        </g:javascript>
    </div>
</g:formRemote>
