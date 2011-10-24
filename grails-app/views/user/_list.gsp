<div class="content">
    <g:if test="${params.username}">
    <div><g:message code="following.users.label" default="Follwing users" /></div>
    </g:if><g:else>
    <div><g:message code="user.label" default="Users" /></div>
    </g:else>
    <g:if test="${users}">
    <div>
        <g:each in="${users}" var="c">
        <span class="user">
            <gravatar:img hash="${c.gravatar_hash}" size="16"/>
            <g:link controller="snippet" action="user" params="[status: params.status, username: c.username]">${c.username.encodeAsHTML()}</g:link>
        </span>
        </g:each>
    </div>
    <g:if test="${params.max}">
    <div class="more_link"><g:link controller="user"><g:message code="users.all.label" default="users"/></g:link></div>
    </g:if>
    </g:if>
</div>
