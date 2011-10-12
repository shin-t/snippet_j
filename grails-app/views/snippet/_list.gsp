<div class="list">
    <sec:ifLoggedIn>
    <g:javascript>
    var update = function(data,id){
        $('.star_'+id+' a').text((data.exists?"unstar":"star")+" ("+data.count+")");
    }
    </g:javascript>
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
    <g:javascript>
    var update = function(data,id){
        $('.star_'+id).text("Star ("+data.count+")");
    }
    </g:javascript>
    </sec:ifNotLoggedIn>
    <g:each in="${snippetInstanceList}" var="snippetInstance">
        <g:render template="/snippet/content" model="[snippetInstance: snippetInstance, tags: snippetInstance.tags, username: username, userid: userid]" />
    </g:each>
</div>
<div style="display:none"><g:paginate controller="${controllerName}" action="${actionName}" total="${snippetInstanceTotal}" params="${params}"/></div>
