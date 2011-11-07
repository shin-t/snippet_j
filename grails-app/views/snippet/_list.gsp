<p>${actionName}</p>
<g:if test="${message}">
<p class="message"><span>${message}</span></p>
</g:if>
<div class="list">
    <g:each in="${snippetInstanceList}" var="snippetInstance">
    <g:render template="/snippet/content" model="[snippetInstance:snippetInstance]"/>
    </g:each>
</div>
<div class="paginateButtons"><g:paginate controller="${controllerName}" action="${actionName}" total="${snippetInstanceTotal}" params="${params}"/></div>
