<div class="vote">
    <form id="form_vote_${snippetInstance.id}">
        <g:hiddenField name="id" value="${snippetInstance.id}"/>
        <div><input type="button" id="up_vote_${snippetInstance.id}" value="b" /></div>
        <div class="votes"></div>
        <div><input type="button" id="down_vote_${snippetInstance.id}" value="q" /></div>
    </form>
    <g:javascript>
        (function(){
            var f = function(){
                $.ajax({
                    type:"GET",
                    url:"/snippet/vote/votes_counts",
                    data:$("#form\_vote\_${snippetInstance.id}").serialize(),
                    success:function(json){
                        $("#form\_vote\_${snippetInstance.id} .votes").text(json.counts);
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
                return false;
            });
            $("#down\_vote\_${snippetInstance.id}").click(function(){
                $.ajax({
                    type:"POST",
                    url:"/snippet/vote/down_vote",
                    data:$("#form\_vote\_${snippetInstance.id}").serialize(),
                    success:f
                });
                return false;
            });
        })();
    </g:javascript>
</div>
