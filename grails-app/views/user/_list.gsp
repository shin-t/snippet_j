<g:if test="${users}">
<div id="users" class="content">
    <g:if test="${params.username}">
    <div><g:message code="${actionName}.users.label" default="Follwing users" /></div>
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
    <g:if test="${params.max == 5}">
        <div class="more_link"><g:link controller="user" action="show" params="[username:sec.loggedInUserInfo(field:'username')]"><g:message code="more.link.label" default="Following users"/></g:link></div>
    </g:if>
    <g:else>
        <div class="paginateButtons"><g:paginate total="${total}" controller="user" action="show" params="[username:userInstance.username]"/></div>
    </g:else>
</div>
</g:if>
