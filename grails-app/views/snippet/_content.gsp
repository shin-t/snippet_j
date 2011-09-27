<div class="content">
    <div class="header">${fieldValue(bean: snippetInstance, field: "id")}: ${fieldValue(bean: snippetInstance, field: "user")}</div>
    <div>${fieldValue(bean: snippetInstance, field: "text")}</div>
    <div>${fieldValue(bean: snippetInstance, field: "file")}</div>
    <g:if test="${snippetInstance?.status == 1}">
    <div><g:formatBoolean boolean="${snippetInstance.help}" true="Help!" false="Solved!" /></div>
    </g:if>
    <g:elseif test="${snippetInstance?.status == 2}">
    <div><g:formatDate date="${snippetInstance.deadline}" /></div>
    </g:elseif>
    <div>${fieldValue(bean: snippetInstance, field: "root")}</div>
    <div>${fieldValue(bean: snippetInstance, field: "parent")}</div>
    <div><g:link action="show" id="${snippetInstance.id}"><prettytime:display date="${snippetInstance.lastUpdated}" /></g:link></div>
    <div class="reply_button"><g:remoteLink action="create" params="[parent_id:snippetInstance.id]" update="reply_${snippetInstance.id}" onLoaded="clearForm()">Reply</g:remoteLink></div>
</div>
