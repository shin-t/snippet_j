<div id="snippet_${snippetInstnce?.id}" class="content">
    <div class="header">
        <form id="form_star_${snippetInstance.id}" class="star">
            <g:hiddenField name="id" value="${snippetInstance.id}"/>
            <input type="checkbox" id="star"/><label for="star"><g:message code="star.label" default="Star" /></label>
        </form>
        <div>${fieldValue(bean: snippetInstance, field: "user")}</div>
        <g:javascript>
            (function(){
                $("#form\_star\_${snippetInstance.id} #star").button({icons:{primary:"ui-icon-star"},text:false});
                var exists = function(){
                    $.ajax({
                        type:"GET",
                        url:"/snippet/snippet/star",
                        data:$("#form\_star\_${snippetInstance.id}").serialize(),
                        statusCode:{
                            204:function(){
                                $("#form\_star\_${snippetInstance.id} #star").attr('checked',true).button('refresh');
                            }
                        }
                    });
                }
                exists();
                $("#form\_star\_${snippetInstance.id} #star").click(function(){
                    $.ajax({
                        type:"POST",
                        url:"/snippet/snippet/star",
                        data:$(this).parent().serialize(),
                        statusCode:{
                            204:function(){
                                $("#form\_star\_${snippetInstance.id} #star").attr('checked',true).button('refresh');
                            },
                            404:function(){
                                $("#form\_star\_${snippetInstance.id} #star").attr('checked',false).button('refresh');
                            }
                        }
                    });
                    return false;
                });
            })();
        </g:javascript>
        <form id="form_vote_${snippetInstance.id}">
            <g:hiddenField name="id" value="${snippetInstance.id}"/>
            <div><input type="checkbox" id="up_vote_${snippetInstance.id}"/><label for="up_vote_${snippetInstance.id}">up</label></div>
            <div class="vote_count"></div>
            <div><input type="checkbox" id="down_vote_${snippetInstance.id}"/><label for="down_vote_${snippetInstance.id}">down</label></div>
        </form>
        <g:javascript>
            (function(){
                $("#form\_vote\_${snippetInstance.id} div #up\_vote\_${snippetInstance.id}").button({icons:{primary:"ui-icon-triangle-1-n"},text:false});
                $("#form\_vote\_${snippetInstance.id} div #down\_vote\_${snippetInstance.id}").button({icons:{primary:"ui-icon-triangle-1-s"},text:false});
                var f = function(){
                    $.ajax({
                        type:"GET",
                        url:"/snippet/vote/votes_counts",
                        data:$("#form\_vote\_${snippetInstance.id}").serialize(),
                        success:function(json){
                            $("#form\_vote\_${snippetInstance.id} .vote_count").text(json.counts);
                        }
                    });
                }
                f();
                $("#form\_vote\_${snippetInstance.id}").submit(function(){
                    $.ajax({
                        type:"POST",
                        url:"/snippet/vote/vote",
                        data:$(this).serialize(),
                        success:f
                    });
                    return false;
                });
                $("#up\_vote\_${snippetInstance.id}").click(function(){
                    $.ajax({
                        type:"POST",
                        url:"/snippet/vote/up_vote",
                        data:$("#form\_vote\_${snippetInstance.id}").serialize(),
                        success:f
                    });
                    $("#down\_vote\_${snippetInstance.id}").attr('checked',false).button('refresh');
                });
                $("#down\_vote\_${snippetInstance.id}").click(function(){
                    $.ajax({
                        type:"POST",
                        url:"/snippet/vote/down_vote",
                        data:$("#form\_vote\_${snippetInstance.id}").serialize(),
                        success:f
                    });
                    $("#up\_vote\_${snippetInstance.id}").attr('checked',false).button('refresh');
                });
            })();
        </g:javascript>
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
    <div class="float_right">
        <div class="last_updated"><prettytime:display date="${snippetInstance.lastUpdated}" /></div>
        <div class="reply_button"><g:remoteLink action="create" params="[parent_id:snippetInstance.id]" update="reply_${snippetInstance.id}" onLoaded="clearForm()">Reply</g:remoteLink></div>
        <div class="chunk_button"><g:link action="show" id="${snippetInstance.id}" fragment="snippet_${snippetInstance.id}">Chunk</g:link></div>
    </div>
    <div class="clear"></div>
    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
</div>
