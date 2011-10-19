<div class="content">
    <div><g:message code="user.label" default="Users" /></div>
    <div>
        <g:each in="${users}" var="c">
        <span><g:link controller="user" params="[username: c.username]" class="username">${c.username.encodeAsHTML()}</g:link></span>
        </g:each>
    </div>
    <g:if test="${params.max}">
    <div style="text-align:right"><g:link controller="user"><g:message code="users.all.label" default="users"/></g:link></div>
    </g:if>
</div>
