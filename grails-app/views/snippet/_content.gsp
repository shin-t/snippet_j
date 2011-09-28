<div id="snippet_${snippetInstnce?.id}" class="content">
    <div class="header">
        <div style="float:left;">${fieldValue(bean: snippetInstance, field: "user")}</div>
        <sec:ifLoggedIn>
        <div style="float:right;">
        <form id="form_star_${snippetInstance.id}" style="float:left;">
            <g:hiddenField name="id" value="${snippetInstance.id}"/>
            <div><input type="checkbox" id="star_${snippetInstance.id}" class="star_button" /><label for="star_${snippetInstance.id}">star</label></div>
        </form>
        <form id="form_vote_${snippetInstance.id}" style="float:left;">
            <g:hiddenField name="id" value="${snippetInstance.id}" />
            <div style="float:left;"><input type="checkbox" id="up_vote_${snippetInstance.id}" class="up_vote_button" /><label for="up_vote_${snippetInstance.id}">up</label></div>
            <div style="float:left;"><input type="checkbox" id="down_vote_${snippetInstance.id}" class="down_vote_button" /><label for="down_vote_${snippetInstance.id}">down</label></div>
            <div class="vote_count"></div>
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
        </sec:ifLoggedIn>
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
