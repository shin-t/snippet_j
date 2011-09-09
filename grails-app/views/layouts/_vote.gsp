<div class="vote">
    <form id="form_vote_${snippetInstance.id}">
        <g:hiddenField name="id" value="${snippetInstance.id}"/>
        <div><button id="up_vote_${snippetInstance.id}">up</button></div>
        <div class="vote_count"></div>
        <div><button id="down_vote_${snippetInstance.id}">down</button></div>
    </form>
    <g:javascript>
        (function(){
            $("#form\_vote\_${snippetInstance.id} div #up\_vote\_${snippetInstance.id}").button({icons:{primary:"ui-icon-triangle-1-n"},text:false}).css("font-size","9pt");
            $("#form\_vote\_${snippetInstance.id} div #down\_vote\_${snippetInstance.id}").button({icons:{primary:"ui-icon-triangle-1-s"},text:false}).css("font-size","9pt");
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
