<div class="content">
    <div><g:message code="following.users.label" default="Follwing users" /></div>
    <g:if test="${users}">
    <div>
        <g:each in="${users}" var="c">
        <span><g:link controller="user" params="[username: c]" class="username">${c.encodeAsHTML()}</g:link></span>
        </g:each>
    </div>
    <g:if test="${!params.username}">
    <div class="more_link"><g:link controller="user" params="[username:sec.loggedInUserInfo(field:'username')]"><g:message code="more.link.label" default="users"/></g:link></div>
    </g:if>
    </g:if>
</div>
