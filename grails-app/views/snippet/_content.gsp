<div class="content">
    <div class="header">${fieldValue(bean: snippetInstance, field: "user")}</div>
    <div>${fieldValue(bean: snippetInstance, field: "text")}</div>
    <div>${fieldValue(bean: snippetInstance, field: "file")}</div>
    <g:if test="${snippetInstance?.status == 1}">
    <div><g:formatBoolean boolean="${snippetInstance.help}" true="Help!" false="Solved!" /></div>
    </g:if>
    <g:elseif test="${snippetInstance?.status == 2}">
    <div><g:formatDate date="${snippetInstance.deadline}" /></div>
    </g:elseif>
    <div class="float_right">
        <div class="last_updated"><prettytime:display date="${snippetInstance.lastUpdated}" /></div>
        <div class="reply_button"><g:remoteLink action="create" params="[parent_id:snippetInstance.id]" update="reply_${snippetInstance.id}" onLoaded="clearForm()">Reply</g:remoteLink></div>
        <div class="chunk_button"><g:link action="show" id="${snippetInstance.id}">Chunk</g:link></div>
    </div>
    <div class="clear"></div>
</div>
