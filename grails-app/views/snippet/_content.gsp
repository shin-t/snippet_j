<div id="snippet_${snippetInstance?.id}" class="content">
    <div class="header">
        <div>
            <g:link controller="user" params="[username:snippetInstance.user.username]">${fieldValue(bean: snippetInstance.user, field: "username")}</g:link>
            <g:if test="${snippetInstance.root}">
            &raquo;
            <g:link controller="snippet" action="show" id="${snippetInstance.parent.id}" fragment="snippet_${snippetInstance.id}">
                ${fieldValue(bean: snippetInstance.parent.user, field: "username")}:
                <g:if test="${snippetInstance.parent.text.length() < 80}">
                ${fieldValue(bean: snippetInstance.parent, field: "text")}
                </g:if>
                <g:else>
                ${fieldValue(bean: snippetInstance.parent, field: "text")[0..79]}...
                </g:else>
            </g:link>
            <g:if test="${snippetInstance.root!=snippetInstance.parent}">
            <div>
                <g:link controller="snippet" action="show" id="${snippetInstance.root.id}">
                    ${fieldValue(bean: snippetInstance.root.user, field: "username")}:
                    <g:if test="${snippetInstance.root.text.size() < 80}">
                    ${fieldValue(bean: snippetInstance.root, field: "text")}
                    </g:if>
                    <g:else>
                    ${fieldValue(bean: snippetInstance.root, field: "text")[0..79]}...
                    </g:else>
                </g:link>
            </div>
            </g:if>
            </g:if>
        </div>
        <g:if test="${username == snippetInstance.user.username && snippetInstance.status == 1}">
        <div class="help_${snippetInstance.id}"><g:checkBox name="help" value="${snippetInstance.help}" onClick="${remoteFunction(controller:'snippet', action:'solved', params:[id: snippetInstance.id])}update_solved(${snippetInstance.id})"/>Help!</div>
        </g:if>
    </div>
    <div class="text"><pre>${fieldValue(bean: snippetInstance, field: "text")}</pre></div>
    <g:if test="${snippetInstance?.file}">
    <div class="file"><pre><code>${fieldValue(bean: snippetInstance, field: "file")}</code></pre></div>
    </g:if>
    <g:if test="${snippetInstance?.status == 1}">
    <div class="help_${snippetInstance.id} ${snippetInstance.help?'help':'solved'}"><span><g:formatBoolean boolean="${snippetInstance.help}" true="Help!" false="Solved!" /></span></div>
    </g:if>
    <g:elseif test="${snippetInstance?.status == 2}">
    <g:if test="${snippetInstance.deadline}">
    <g:if test="${snippetInstance.deadline > new Date()}">
    <div class="active">
        <span>active</span>
        <g:message code="snippet.deadline.label" default="deadline"/>: <g:formatDate date="${snippetInstance.deadline}"/>
    </div>
    </g:if>
    <g:else>
    <div class="deadline"><g:message code="snippet.deadline.label" default="deadline"/>: <g:formatDate date="${snippetInstance.deadline}"/></div>
    </g:else>
    </g:if>
    <g:else>
    <div class="endless"><span>endless</span></div>
    </g:else>
    </g:elseif>
    <div class="footer">
        <div style="float:left">
            <g:each in="${tags}" var="tag">
            <g:link controller="tag" params="[tag: tag]">${tag.encodeAsHTML()}</g:link>
            </g:each>
        </div>
        <ul>
            <li><g:link action="show" id="${snippetInstance.id}"><prettytime:display date="${snippetInstance.lastUpdated}"/> (${snippetInstance.children.size().encodeAsHTML()})</g:link></li>
            <li class="star_${snippetInstance.id}">
                <g:remoteLink controller="snippet" action="star" params="[id: snippetInstance.id]" method="POST" onSuccess="update(data,${snippetInstance.id})"></g:remoteLink>
                <g:javascript>
                    ${remoteFunction(controller:'snippet', action:'star', params:[id: snippetInstance.id], method:'GET', onSuccess:'update(data,'+snippetInstance.id+')')}
                </g:javascript>
            </li>
            <sec:ifLoggedIn>
            <li class="reply">
                <g:remoteLink controller="snippet" action="create" params="[parent_id:snippetInstance.id,tags:snippetInstance.tags.join(',')]" update="reply_${snippetInstance.id}" onLoaded="clearForm()">
                    <g:message code="snippet.button.reply.label"/>
                </g:remoteLink>
            </li>
            </sec:ifLoggedIn>
            <g:if test="${username == snippetInstance.user.username}">
            <li class="delete">
                <g:remoteLink controller="snippet" action="delete" id="${snippetInstance.id}" onSuccess="jQuery('#snippet_${snippetInstance.id}').remove()" before="if(!confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}')) return false"><g:message code="default.button.delete.label" default="delete"/></g:remoteLink>
            </li>
            </g:if>
        </ul>
    </div>
    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
</div>
