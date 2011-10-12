<div class="list">
    <g:javascript>
    var update = function(data,id){
        $('.star_'+id+' input').button("option","label",(data.exists?"unstar":"star")+" ("+data.count+")");
    }
    </g:javascript>
    <g:each in="${snippetInstanceList}" var="snippetInstance">
        <g:render template="/snippet/content" model="[snippetInstance: snippetInstance, tags: snippetInstance.tags, username: username, userid: userid]" />
    </g:each>
</div>
<div style="display:none"><g:paginate controller="${controllerName}" action="${actionName}" total="${snippetInstanceTotal}" params="${params}"/></div>
