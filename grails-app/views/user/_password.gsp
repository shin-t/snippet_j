<g:form method="post">
    <g:hiddenField name="id" value="${userInstance?.id}" />
    <g:hiddenField name="version" value="${userInstance?.version}" />
    <g:hasErrors bean="${userInstance}" field="password">
        <div class="errors">
           <g:renderErrors bean="${userInstance}" field="password" as="list" />
       </div>
   </g:hasErrors>
    <div class="prop">
        <div class="name"><label for="password"><g:message code="user.password.label" default="Password"/></label></div>
        <div class="value"><g:passwordField name="password"/></div>
    </div>
    <div class="prop">
        <div class="name"><label for="password2"><g:message code="user.password2.label" default="Password"/></label></div>
        <div class="value"><g:passwordField name="password2"/></div>
    </div>
    <div class="buttons">
        <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
    </div>
</g:form>
