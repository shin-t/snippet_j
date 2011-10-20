<div class="content">
    <div><g:message code="user.label" default="Users" /></div>
    <g:if test="${users}">
    <div>
        <g:each in="${users}" var="c">
        <span><g:link controller="user" params="[username: c.username]" class="username">${c.username.encodeAsHTML()}</g:link></span>
        </g:each>
    </div>
    <g:if test="${params.max}">
    <div class="more_link"><g:link controller="user"><g:message code="users.all.label" default="users"/></g:link></div>
    </g:if>
    </g:if>
</div>
