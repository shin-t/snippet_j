<%@ page import="snippet.Star" %>
<div id="snippet_${snippetInstance.id}" class="content">
    <div class="header">
        <div>
            <span class="username"><g:link controller="user" params="[username:snippetInstance.user.username]">${fieldValue(bean: snippetInstance.user, field: "username")}</g:link></span>
            <g:if test="${snippetInstance.parent}">
            <span>&raquo;</span>
            <span class="parent"><g:link controller="snippet" action="show" id="${snippetInstance.parent.id}" fragment="snippet_${snippetInstance.id}">${fieldValue(bean: snippetInstance.parent.user, field: "username")}</g:link></span>
            </g:if>
        </div>
        <g:if test="${snippetInstance.tags}">
        <div class="tags">
            <g:message code="snippet.tags.label" default="Tags"/>
            <g:each in="${snippetInstance.tags}" var="tag">
            <g:link controller="tag" params="[tag: tag]">${tag.encodeAsHTML()}</g:link>
            </g:each>
        </div>
        </g:if>
        <div class="date-created"><g:link controller="snippet" action="show" id="${snippetInstance.id}"><prettytime:display date="${snippetInstance.lastUpdated}"/></g:link></div>
    </div>
    <div class="main">
        <div class="text"><pre>${fieldValue(bean: snippetInstance, field: "text")}</pre></div>
        <g:if test="${snippetInstance.file}">
        <div class="file"><pre><code>${fieldValue(bean: snippetInstance, field: "file")}</code></pre></div>
        </g:if>
        <g:if test="${snippetInstance.status == 1}">
        <div class="help_${snippetInstance.id} ${snippetInstance.help?'help':'solved'}"><span><g:formatBoolean boolean="${snippetInstance.help}" true="Help!" false="Solved!" /></span></div>
        <g:if test="${userInstance.id == snippetInstance.user.id && snippetInstance.status == 1}">
        <div class="help_${snippetInstance.id}">
            <g:checkBox name="help" value="${snippetInstance.help}" onClick="${remoteFunction(controller:'snippet', action:'solved', params:[id: snippetInstance.id])}update_solved(${snippetInstance.id})"/>Help!
        </div>
        </g:if>
        </g:if>
        <g:elseif test="${snippetInstance.status == 2}">
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
    </div>
    <div class="buttons" style="text-align:right">
        <sec:ifLoggedIn>
        <g:checkBox class="star_${snippetInstance.id}" checked="${Star.get(userInstance.id, snippetInstance.id)}" name="star_${snippetInstance.id}" onclick="${remoteFunction(controller:'snippet',action:'star',params:[id: snippetInstance.id],onSuccess:'update(data,'+snippetInstance.id+')')}"/>
        <label for="star_${snippetInstance.id}">star</label>
        <g:remoteLink class="reply" controller="snippet" action="create" params="[parent_id:snippetInstance.id,tags:snippetInstance.tags.join(',')]" update="reply_${snippetInstance.id}" onLoaded="clearForm()">
            <g:message code="snippet.button.reply.label"/>
        </g:remoteLink>
        <g:if test="${userInstance.id == snippetInstance.user.id}">
        <g:remoteLink class="delete" controller="snippet" action="delete" id="${snippetInstance.id}" onSuccess="jQuery('#snippet_${snippetInstance.id}').remove()" before="if(!confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}')) return false"><g:message code="default.button.delete.label" default="delete"/></g:remoteLink>
        </g:if>
        </sec:ifLoggedIn>
    </div>
    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
</div>
