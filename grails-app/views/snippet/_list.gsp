<div class="list">
    <g:javascript>
    var star_update = function(e){
        var label = $(this).attr("checked")?"unstar":"star";
        var obj = $(this)
        $.ajax({
            type:'POST',
            url:'/snippet/star/'+$(obj).button("option","label")+'/'+e.data.id,
            success: function(){
                $(obj).button("option","label",label);
            }
        });
    }
    </g:javascript>
    <g:each in="${snippetInstanceList}" var="snippetInstance">
        <g:render template="/snippet/content" model="[snippetInstance: snippetInstance, userInstance: userInstance]" />
    </g:each>
</div>
<div style="display:none"><g:paginate controller="${controllerName}" action="${actionName}" total="${snippetInstanceTotal}" params="${params}"/></div>
