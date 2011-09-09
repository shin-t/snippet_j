<div class="star">
    <form id="form_star_${snippetInstance.id}" class="star">
        <g:hiddenField name="id" value="${snippetInstance.id}"/>
        <input type="checkbox" id="star"/><label for="star"><g:message code="star.label" default="Star" /></label>
    </form>
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
</div>
