<div class="content">
    <h3>
        <gravatar:img hash="${snippetInstance.user.gravatar_hash}" size="18"/>
        <g:link controller="user" action="show" params="[username:snippetInstance.user.username]">${fieldValue(bean: snippetInstance.user, field: "username")}</g:link>
    </h3>
    <g:if test="${snippetInstance.parent}">
    <h4>
        &raquo;
        <gravatar:img hash="${snippetInstance.parent.user.gravatar_hash}" size="16"/>
        <g:link controller="snippet" action="show" id="${snippetInstance.parent.id}" params="[status:params.status]" fragment="snippet_${snippetInstance.id}">${fieldValue(bean: snippetInstance.parent.user, field: "username")}</g:link>
    </h4>
    </g:if>
    <g:if test="${snippetInstance.tags}">
    <p class="tags">
        <g:message code="tag.label" default="Tags"/>
        <g:each in="${snippetInstance.tags}" var="tag">
        <g:link controller="tag" action="show" params="[tag:tag, status:params.status]">${tag.encodeAsHTML()}</g:link>
        </g:each>
    </p>
    </g:if>
    <p class="date-created"><g:link controller="snippet" action="show" id="${snippetInstance.id}" params="[status:params.status]"><prettytime:display date="${snippetInstance.lastUpdated}"/></g:link></p>
    <p>${fieldValue(bean: snippetInstance, field: "text")}</p>
    <g:if test="${snippetInstance.file}">
    <pre class="file prettyprint">${fieldValue(bean: snippetInstance, field: "file")}</pre>
    </g:if>
    <sec:ifLoggedIn>
    <g:hiddenField name="snippet_${snippetInstance.id}" value="${snippetInstance.id}"/>
    <button name="star_${snippetInstance.id}" class="star_button btn" data-toggle="toggle"></button>
    <g:remoteLink class="reply btn primary" controller="snippet" action="create" params="[parent_id:snippetInstance.id,tags:snippetInstance.tags.join(' ')]" update="reply_${snippetInstance.id}" onLoaded="clearForm()"><g:message code="snippet.button.reply.label"/></g:remoteLink>
    <g:if test="${currentUser.id == snippetInstance.user.id}">
    <g:remoteLink class="delete btn danger" controller="snippet" action="delete" id="${snippetInstance.id}" onSuccess="jQuery('#snippet_${snippetInstance.id}').parent().parent().remove();jQuery('.message span').first().text(data).show()" before="if(!confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}')) return false"><g:message code="default.button.delete.label" default="delete"/></g:remoteLink>
    </g:if>
    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
    </sec:ifLoggedIn>
</div>
