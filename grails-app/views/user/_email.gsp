<g:form method="post" class="form-stacked">
    <fieldset>
        <legend><sec:loggedInUserInfo field="username"/></legend>
        <g:hiddenField name="id" value="${userInstance?.id}" />
        <g:hiddenField name="version" value="${userInstance?.version}" />
        <g:hasErrors bean="${userInstance}" field="email">
            <div class="errors">
               <g:renderErrors bean="${userInstance}" field="email" as="list" />
           </div>
       </g:hasErrors>
        <div class="prop clearfix">
            <div class="name"><label for="email"><g:message code="user.email.label" default="Email"/></label></div>
            <div class="value input"><g:textField name="email" value="${userInstance?.email}" /></div>
        </div>
        <div class="prop clearfix">
            <div class="name"><label for="email2"><g:message code="user.email2.label" default="Email"/></label></div>
            <div class="value input"><g:textField name="email2"/></div>
        </div>
    </fieldset>
    <div class="actions">
        <g:actionSubmit class="btn success" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
    </div>
</g:form>
