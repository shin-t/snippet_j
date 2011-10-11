<div class="list">
    <g:each in="${snippetInstanceList}" var="snippetInstance">
        <g:render template="/snippet/content" model="[snippetInstance: snippetInstance, tags: snippetInstance.tags, username: username]" />
    </g:each>
</div>
<g:javascript>
    var update_solved = function(id){
        if($(".help_"+id+" input:checkbox").attr('checked')){
            $(".help_"+id+" span").text("Help!").parent().removeClass("solved").addClass("help");
        }
        else{
            $(".help_"+id+" span").text("Solved!").parent().removeClass("help").addClass("solved");
        }
    }
    var clearForm = function(){ $(".reply_form").empty() }
</g:javascript>
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
<div style="display:none"><g:paginate controller="${controllerName}" action="${actionName}" total="${snippetInstanceTotal}" params="${params}"/></div>
