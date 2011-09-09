<div class="star">
    <form id="form_star_${snippetInstance.id}" class="star">
        <g:hiddenField name="id" value="${snippetInstance.id}"/>
        <span class="button"><button name="star"><g:message code="star.label" default="Star" /></button></span>
    </form>
    <g:javascript>
        (function(){
            $("#form\_star\_${snippetInstance.id} .button button").button({icons:{primary:"ui-icon-star"},text:false}).css("font-size","9pt");
            var count = function(){
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
                        },
                        404:function(){
                            $("#form\_star\_${snippetInstance.id} div.stars").css({color:"#777",backgroundColor:"#fff"});
                        }
                    }
                });
                count();
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
