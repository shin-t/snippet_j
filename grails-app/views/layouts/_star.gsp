<div class="star">
    <form id="form_star_${snippetInstance.id}">
        <div class="stars"></div>
        <g:hiddenField name="id" value="${snippetInstance.id}"/>
        <span class="button"><button name="star"><g:message code="star.label" default="Star" /></button></span>
    </form>
    <g:javascript>
        (function(){
            $("#form\_star\_${snippetInstance.id} .button button").button({icons:{primary:"ui-icon-star"}}).css("font-size","8pt");
            var counts = function(){
                $.ajax({
                    type:"GET",
                    url:"/snippet/snippet/stars_counts",
                    data:$("#form\_star\_${snippetInstance.id}").serialize(),
                    success:function(json){
                        $("#form\_star\_${snippetInstance.id} div.stars").text(json.total);
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
                            $("#form\_star\_${snippetInstance.id} div.stars").css({color:"#fff",backgroundColor:"#A1AEC0"});
                            counts();
                        },
                        404:function(){
                            $("#form\_star\_${snippetInstance.id} div.stars").css({color:"#777",backgroundColor:"#fff"});
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
