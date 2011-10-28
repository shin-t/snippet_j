<div id="users" class="content">
    <g:if test="${params.username}">
    <div><g:message code="following.users.label" default="Follwing users" /></div>
    </g:if><g:else>
    <div><g:message code="user.label" default="Users" /></div>
    </g:else>
    <g:if test="${users}">
        <g:each in="${users}" var="c">
        <p>
            <gravatar:img hash="${c.gravatar_hash}" size="16"/>
            <g:if test="${params.status}">
            <g:link controller="user" action="show" params="[status: params.status, username: c.username]">${c.username.encodeAsHTML()}</g:link>
            </g:if>
            <g:else>
            <g:link controller="user" action="show" params="[username: c.username]">${c.username.encodeAsHTML()}</g:link>
            </g:else>
        </p>
        </g:each>
        <g:if test="${params.max}">
        <g:if test="${params.username}">
            <div class="more_link"><g:link controller="user" params="[username:params.username]"><g:message code="more.link.label" default="users"/></g:link></div>
        </g:if>
        <g:else>
            <div class="more_link"><g:link controller="user"><g:message code="more.link.label" default="users"/></g:link></div>
        </g:else>
        </g:if>
    </g:if>
</div>
