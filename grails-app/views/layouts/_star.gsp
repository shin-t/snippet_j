<div class="star">
    <form id="form_star_${snippetInstance.id}" action="/snippet/snippet/star" method="POST">
        <g:hiddenField name="id" value="${snippetInstance.id}"/>
        <span class="stars"></span>
        <span class="button"><g:submitButton name="star"/></span>
    </form>
    <g:javascript>
        (function(){
            var f=function(json){
                $("#form\_star\_${snippetInstance.id} .stars").text(json.total+" stars");
                $("#form\_star\_${snippetInstance.id} #star").val(json.exists?"Unstar":"Star");
            }
            $.ajax({type:"GET",url:"/snippet/snippet/star",data:$("#form\_star\_${snippetInstance.id}").serialize(),success:f});
            $("#form\_star\_${snippetInstance.id}").submit(function(){
                $.ajax({type:"POST",url:"/snippet/snippet/star",data:$(this).serialize(),success:f});
                return false;
            });
        })();
    </g:javascript>
</div>
