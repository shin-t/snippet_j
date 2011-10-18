<div class="list">
    <g:each in="${snippetInstanceList}" var="snippetInstance">
    <g:render template="/snippet/content" model="[snippetInstance: snippetInstance, userInstance: userInstance]"/>
    </g:each>
</div>
<div class="paginateButtons"><g:paginate controller="${controllerName}" action="${actionName}" total="${snippetInstanceTotal}" params="${params}"/></div>
