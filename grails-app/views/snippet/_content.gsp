<div class="content">
    <div class="header">
        <p>
            <span class="username"><g:link controller="user" params="[username:snippetInstance.user.username]">${fieldValue(bean: snippetInstance.user, field: "username")}</g:link></span>
            <g:if test="${snippetInstance.parent}">
            &raquo;
            <span class="parent"><g:link controller="snippet" action="show" id="${snippetInstance.parent.id}" fragment="snippet_${snippetInstance.id}">${fieldValue(bean: snippetInstance.parent.user, field: "username")}</g:link></span>
            </g:if>
        </p>
        <g:if test="${snippetInstance.tags}">
        <p class="tags">
            <g:message code="snippet.tags.label" default="Tags"/>
            <g:each in="${snippetInstance.tags}" var="tag">
            <g:link controller="tag" params="[tag: tag]">${tag.encodeAsHTML()}</g:link>
            </g:each>
        </p>
        </g:if>
        <g:if test="${snippetInstance.status == 1}">
        <p class="help_${snippetInstance.id} ${snippetInstance.help?'help':'solved'}"><span><g:formatBoolean boolean="${snippetInstance.help}" true="Help!" false="Solved!" /></span></p>
        </g:if>
        <g:elseif test="${snippetInstance.status == 2}">
        <g:if test="${snippetInstance.deadline}">
        <g:if test="${snippetInstance.deadline > new Date()}">
        <p class="active">
            <span>active</span>
            <g:message code="snippet.deadline.label" default="deadline"/>: <g:formatDate date="${snippetInstance.deadline}"/>
        </p>
        </g:if>
        <g:else>
        <p class="deadline"><g:message code="snippet.deadline.label" default="deadline"/>: <g:formatDate date="${snippetInstance.deadline}"/></p>
        </g:else>
        </g:if>
        <g:else>
        <p class="endless"><span>endless</span></p>
        </g:else>
        </g:elseif>
        <p class="date-created"><g:link controller="snippet" action="show" id="${snippetInstance.id}"><prettytime:display date="${snippetInstance.lastUpdated}"/></g:link></p>
    </div>
    <pre class="text">${fieldValue(bean: snippetInstance, field: "text")}</pre>
    <g:if test="${snippetInstance.file}">
    <pre class="file"><code class="prettyprint">${fieldValue(bean: snippetInstance, field: "file")}</code></pre>
    </g:if>
    <sec:ifLoggedIn>
    <div class="buttons">
        <g:hiddenField name="snippet_${snippetInstance.id}" value="${snippetInstance.id}"/>
        <g:checkBox name="star_${snippetInstance.id}" class="star_button"/><label for="star_${snippetInstance.id}"></label>
        <g:remoteLink class="reply" controller="snippet" action="create" params="[parent_id:snippetInstance.id,tags:snippetInstance.tags.join(',')]" update="reply_${snippetInstance.id}" onLoaded="clearForm()"><g:message code="snippet.button.reply.label"/></g:remoteLink>
        <g:if test="${userInstance.id == snippetInstance.user.id}">
        <g:if test="${snippetInstance.status == 1}">
        <g:checkBox name="help_${snippetInstance.id}" value="${snippetInstance.help}" class="help_button"/><label for="help_${snippetInstance.id}"></label>
        </g:if>
        <g:remoteLink class="delete" controller="snippet" action="delete" id="${snippetInstance.id}" onSuccess="jQuery('#snippet_${snippetInstance.id}').parent().parent().remove()" before="if(!confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}')) return false"><g:message code="default.button.delete.label" default="delete"/></g:remoteLink>
        </g:if>
    </div>
    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
    </sec:ifLoggedIn>
</div>
