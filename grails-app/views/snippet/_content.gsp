<div id="snippet_${snippetInstnce?.id}" class="content">
    <div class="header">
        <div>${fieldValue(bean: snippetInstance, field: "user")}</div>
        <div>
        <div>${snippetInstance.tags.join(', ').encodeAsHTML()}</div>
        <form id="form_star_${snippetInstance.id}">
            <g:hiddenField name="id" value="${snippetInstance.id}"/>
            <div><input type="checkbox" id="star_${snippetInstance.id}" class="star_button" /><label for="star_${snippetInstance.id}">star</label></div>
        </form>
        <g:javascript>
            (function(){
                var exists = function(){
                    $.ajax({
                        type:"GET",
                        url:"/snippet/snippet/star",
                        data:$("#form\_star\_${snippetInstance.id}").serialize(),
                        statusCode:{
                            204:function(){
                                $("#star\_${snippetInstance.id}").attr('checked',true).button('refresh');
                            }
                        }
                    });
                }
                exists();
                $("#star\_${snippetInstance.id}").click(function(){
                    $.ajax({
                        type:"POST",
                        url:"/snippet/snippet/star",
                        data:$(this).parent().parent().serialize(),
                        statusCode:{
                            204:function(){
                                $("#star\_${snippetInstance.id}").attr('checked',true).button('refresh');
                            },
                            404:function(){
                                $("#star\_${snippetInstance.id}").attr('checked',false).button('refresh');
                            }
                        }
                    });
                    return false;
                });
            })();
        </g:javascript>
        </div>
        <g:if test="${snippetInstance.root}">
        <div style="clear:both;">${fieldValue(bean: snippetInstance.root.user, field: "username")}: ${fieldValue(bean: snippetInstance.root, field: "text")}</div>
        </g:if>
    </div>
    <div class="text"><pre>${fieldValue(bean: snippetInstance, field: "text")}</pre></div>
    <g:if test="${snippetInstance?.file}">
    <div class="file"><pre><code>${fieldValue(bean: snippetInstance, field: "file")}</code></pre></div>
    </g:if>
    <g:if test="${snippetInstance?.status == 1}">
    <div><g:formatBoolean boolean="${snippetInstance.help}" true="Help!" false="Solved!" /></div>
    </g:if>
    <g:elseif test="${snippetInstance?.status == 2}">
    <div><g:formatDate date="${snippetInstance.deadline}" /></div>
    </g:elseif>
    <ul class="footer">
        <li><prettytime:display date="${snippetInstance.lastUpdated}" /></li>
        <sec:ifLoggedIn>
        <li><g:remoteLink action="create" params="[parent_id:snippetInstance.id]" update="reply_${snippetInstance.id}" onLoaded="clearForm()">Reply to This</g:remoteLink></li>
        </sec:ifLoggedIn>
        <sec:ifNotLoggedIn>
        <li><g:link controller="login">Reply to This</g:link></li>
        </sec:ifNotLoggedIn>
        <li><g:link action="show" id="${snippetInstance.id}">Chunk(${snippetInstance.children.size().encodeAsHTML()})</g:link></li>
        <g:if test="${snippetInstance.root}">
        <li><g:link action="show" id="${snippetInstance.parent.id}" fragment="${snippetInstance.id}">Parent</g:link></li>
        <g:if test="${snippetInstance.root!=snippetInstance.parent}">
        <li><g:link action="show" id="${snippetInstance.root.id}">Root</g:link></li>
        </g:if>
        </g:if>
    </ul>
    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
</div>
