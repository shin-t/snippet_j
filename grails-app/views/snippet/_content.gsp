<div id="snippet_${snippetInstnce?.id}" class="content">
    <div class="header">${fieldValue(bean: snippetInstance, field: "user")}</div>
    <div class="text"><pre>${fieldValue(bean: snippetInstance, field: "text")}</pre></div>
    <g:if test="${snippetInstance?.file}">
    <div class="file"><pre><code>${fieldValue(bean: snippetInstance, field: "file")}</code></pre></div>
    </g:if>
    <g:if test="${snippetInstance?.status == 1}">
    <div><g:formatBoolean boolean="${snippetInstance.help}" true="Help!" false="Solved!" /></div>
    </g:if>
    <g:elseif test="${snippetInstance?.status == 2}">
    <div><g:formatDate date="${snippetInstance.deadline}" /></div>
    </g:elseif>
    <div class="float_right">
        <div class="last_updated"><prettytime:display date="${snippetInstance.lastUpdated}" /></div>
        <div class="reply_button"><g:remoteLink action="create" params="[parent_id:snippetInstance.id]" update="reply_${snippetInstance.id}" onLoaded="clearForm()">Reply</g:remoteLink></div>
        <div class="chunk_button"><g:link action="show" id="${snippetInstance.id}" fragment="snippet_${snippetInstance.id}">Chunk</g:link></div>
    </div>
    <div class="clear"></div>
    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
</div>
