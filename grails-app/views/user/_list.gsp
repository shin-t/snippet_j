<g:if test="${userInstanceList}">
<div id="users" class="content">
    <h1>
        <g:if test="${params.username}">
        <g:message code="${actionName}.users.label" default="Follwing users" /></h1>
        </g:if><g:else>
        <g:message code="user.label" default="Users" />
        </g:else>
    </h1>
    <g:each in="${userInstanceList}" var="c">
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
        <div class="more_link"><g:link controller="user" action="${actionName}" params="[username:userInstance]"><g:message code="more.link.label" default="Users"/></g:link></div>
    </g:if>
    <g:else>
        <div class="paginateButtons"><g:paginate total="${userInstanceTotal}" controller="user" action="show" params="[username:userInstance.username]"/></div>
    </g:else>
</div>
</g:if>
