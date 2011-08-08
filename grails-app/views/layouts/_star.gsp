<form id="add_star" name="add_star" action="/snippet/snippet/add_star" method="POST">
    <div class="buttons">
        <span class="stars">${(stars)?stars.size():0}&nbsp;stars</span>
        <g:hiddenField name="id" value="${snippetInstance?.id}" />
        <span class="button">
            <g:submitButton name="addStar" value="${star?'unstar':'star'}" />
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
                    console.log(json.total)
                    $("#add\_star .buttons .stars").text(json.total+" stars")
                    $("#addStar").val(json.star?"unstar":"star")
                }
            });
            return false;
        });
    })();
</g:javascript>

