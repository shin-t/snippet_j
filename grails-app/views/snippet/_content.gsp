<div id="snippet_${snippetInstnce?.id}" class="content">
    <div class="header">
        <div>${fieldValue(bean: snippetInstance, field: "user")}</div>
        <g:if test="${snippetInstance.root}">
        <div style="clear:both;">${fieldValue(bean: snippetInstance.root.user, field: "username")}: ${fieldValue(bean: snippetInstance.root, field: "text")}</div>
        </g:if>
    </div>
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
    <div style="float:left">
        <g:each in="${snippetInstance.tags}">
        <a>${it.encodeAsHTML()}</a>
        </g:each>
    </div>
    <ul class="footer">
        <li><prettytime:display date="${snippetInstance.lastUpdated}" /></li>
        <li><g:remoteLink action="star" id="${snippetInstance.id}">Add Star</g:remoteLink></li>
        <li><g:remoteLink action="create" params="[parent_id:snippetInstance.id]" update="reply_${snippetInstance.id}" onLoaded="clearForm()">Reply to This</g:remoteLink></li>
        <li><g:link action="show" id="${snippetInstance.id}">Chunk(${snippetInstance.children.size().encodeAsHTML()})</g:link></li>
        <g:if test="${snippetInstance.root}">
        <li><g:link action="show" id="${snippetInstance.parent.id}" fragment="${snippetInstance.id}">Parent</g:link></li>
        <g:if test="${snippetInstance.root!=snippetInstance.parent}">
        <li><g:link action="show" id="${snippetInstance.root.id}">Root</g:link></li>
        </g:if>
        </g:if>
    </ul>
    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
</div>
