<g:if test="${message}">
<p class="message"><span>${message}</span></p>
</g:if>
<div class="list">
    <g:each in="${snippetInstanceList}" var="snippetInstance">
    <g:render template="/snippet/content" model="[snippetInstance: snippetInstance, userInstance: userInstance]"/>
    </g:each>
</div>
<div><g:paginate controller="${controllerName}" action="${actionName}" total="${snippetInstanceTotal}" params="${params}"/></div>
