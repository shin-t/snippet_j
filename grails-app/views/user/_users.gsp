<div class="content">
    <h2><g:message code="user.label" default="Users" /></h2>
    <g:each in="${users}" var="c">
    <span><g:link controller="user" params="[username: c[0]]" class="username">${c[0].encodeAsHTML()}(${c[1].encodeAsHTML()})</g:link></span>
    </g:each>
    <div style="text-align:right"><g:link controller="user"><g:message code="users.all.label" default="users"/></g:link></div>
</div>
