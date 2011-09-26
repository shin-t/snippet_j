<div class="list" id="list">
    <div id="update"></div>
    <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
    <div class="content">
        <div class="header">${fieldValue(bean: snippetInstance, field: "id")}: ${fieldValue(bean: snippetInstance, field: "user")}</div>
        <div>${fieldValue(bean: snippetInstance, field: "text")}</div>
        <div>${fieldValue(bean: snippetInstance, field: "file")}</div>
        <div><g:formatBoolean boolean="${snippetInstance.help}" true="Help!" false="Solved!" /></div>
        <div><g:formatDate date="${snippetInstance.deadline}" /></div>
        <div>${fieldValue(bean: snippetInstance, field: "root")}</div>
        <div>${fieldValue(bean: snippetInstance, field: "parent")}</div>
        <div><g:link action="show" id="${snippetInstance.id}"><prettytime:display date="${snippetInstance.lastUpdated}" /></g:link></div>
        <div class="reply_button"><g:remoteLink action="create" params="[parent_id:snippetInstance.id]" update="reply_${snippetInstance.id}" onLoaded="clearForm()">Reply</g:remoteLink></div>
    </div>
    </g:each>
</div>
<g:javascript>
    function clearForm() { $(".reply_form").empty() }
</g:javascript>
<div style="display:none">
<g:paginate controller="snippet" action="list" total="${snippetInstanceTotal}" />
</div>
