<div class="star">
    <form id="form_star_${snippetInstance.id}">
        <div class="stars"></div>
        <g:hiddenField name="id" value="${snippetInstance.id}"/>
        <span class="button"><g:submitButton name="star"/></span>
    </form>
    <g:javascript>
        (function(){
            var counts = function(){
                $.ajax({
                    type:"GET",
                    url:"/snippet/snippet/stars_counts",
                    data:$("#form\_star\_${snippetInstance.id}").serialize(),
                    success:function(json){
                        $("#form\_star\_${snippetInstance.id} .stars").text("スター "+json.total);
                    }
                });
            }
            var exists = function(){
                $.ajax({
                    type:"GET",
                    url:"/snippet/snippet/star",
                    data:$("#form\_star\_${snippetInstance.id}").serialize(),
                    statusCode:{
                        204:function(){
                            $("#form\_star\_${snippetInstance.id} #star").val("スターを外す");
                            counts();
                        },
                        404:function(){
                            $("#form\_star\_${snippetInstance.id} #star").val("スターを付ける");
                            counts();
                        },
                        401:counts()
                    }
                });
            }
            exists();
            $("#form\_star\_${snippetInstance.id}").submit(function(){
                $.ajax({
                    type:"POST",
                    url:"/snippet/snippet/star",
                    data:$(this).serialize(),
                    success:function(){
                        exists();
                    }
                });
                return false;
            });
        })();
    </g:javascript>
</div>
