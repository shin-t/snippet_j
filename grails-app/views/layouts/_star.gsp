<form id="add_star" name="add_star" action="/snippet/snippet/add_star" method="POST">
    <div class="buttons">
        <span>${(stars)?stars.size():0}&nbsp;stars</span>
        <g:hiddenField name="id" value="${snippetInstance?.id}" />
        <span class="button">
            <g:submitButton name="addStar" value="star" />
        </span>
    </div>
</form>
<g:javascript>
    (function(){
         $("#add\_star").submit(function(){
             var q = $(this).serialize();
             console.log(q);
             $.ajax({
                type: "POST",
                url: "/snippet/snippet/add_star",
                data: q,
                success: function(json){
                    console.log(json);
                    console.log(json.star);
                }
            });
            return false;
        });
    })();
</g:javascript>

