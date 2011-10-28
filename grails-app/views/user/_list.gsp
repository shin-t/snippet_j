<div id="users" class="content">
    <g:if test="${params.username}">
    <div><g:message code="following.users.label" default="Follwing users" /></div>
    </g:if><g:else>
    <div><g:message code="user.label" default="Users" /></div>
    </g:else>
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
    <g:paginate total="${total}"/>
</div>
