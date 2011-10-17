<g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
<g:formRemote name="snippetForm" url="[controller:'snippet',action:'save']" update="[success:'', failure:'form_dialog']" onSuccess="jQuery('input:text, textarea','.dialog').val('');jQuery('#lists').prepend(data);button_icons()">
    <g:hiddenField name="parent_id" value="${parent_id}" />
    <div class="dialog">
        <div class="header">${entityName}</div>
        <g:hasErrors bean="${snippetInstance}">
        <div class="errors"><g:renderErrors bean="${snippetInstance}" as="list" /></div>
        </g:hasErrors>
        <div class="prop">
            <div class="name">
                <label for="text"><g:message code="snippet.text.label" default="Text" /></label>
            </div>
            <div class="value">
                <g:textArea name="text" value="${snippetInstance?.text}" />
            </div>
        </div>
        <div class="prop">
            <div class="name">
                <label for="file"><g:message code="snippet.file.label" default="File" /></label>
            </div>
            <div class="value">
                <g:textArea name="file" value="${snippetInstance?.file}" placeholder="コード、入出力例、ログ等"/>
            </div>
        </div>
        <div class="prop">
            <div class="name">
                <label for="tags"><g:message code="snippet.tags.label" default="Tags" /></label>
            </div>
            <div class="value">
                <g:textField name="tags" value="${snippetInstance.tags?.join(',')}" placeholder="空白文字で区切る" />
            </div>
        </div>
        <div class="prop" style="${snippetInstance?.status==2?'':'display:none'}">
            <div class="name">
                <label for="deadline"><g:message code="snippet.deadline.label" default="Deadline" /></label>
            </div>
            <div class="value">
                <g:textField name="deadline" value="${snippetInstance?.deadline}" />
            </div>
        </div>
        <div class="buttons">
        <div id="snippet_status" style="float:left">
            <g:radio name="status" value="0" id="status_0"/><g:radio name="status" value="1" id="status_1"/><g:radio name="status" value="2" id="status_2"/>
            <label for="status_0"><g:message code="snippet.status.snippet.label" default="Snippet"/></label><label for="status_1"><g:message code="snippet.status.question.label" default="Question"/></label><label for="status_2"><g:message code="snippet.status.problem.label" default="Problem"/></label>
        </div>
        <g:javascript>
        (function(){
            var update = function(){
                switch($("#snippet_status input:checked").val()){
                    case '0':
                        $("input[name='deadline']").parent().parent().hide();
                        $(".dialog .header").text("${message(code: 'snippet.status.snippet.label', default: 'Snippet')}");
                        break;
                    case '1':
                        $("input[name='deadline']").parent().parent().hide();
                        $(".dialog .header").text("${message(code: 'snippet.status.question.label', default: 'Question')}");
                        break;
                    case '2':
                        $("input[name='deadline']").parent().parent().show();
                        $(".dialog .header").text("${message(code: 'snippet.status.problem.label', default: 'Problem')}");
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
