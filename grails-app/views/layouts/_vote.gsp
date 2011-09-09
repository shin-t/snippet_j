<div class="vote">
    <form id="form_vote_${snippetInstance.id}">
        <g:hiddenField name="id" value="${snippetInstance.id}"/>
        <div><input type="checkbox" id="up_vote_${snippetInstance.id}"/><label for="up_vote_${snippetInstance.id}">up</label></div>
        <div class="vote_count"></div>
        <div><input type="checkbox" id="down_vote_${snippetInstance.id}"/><label for="down_vote_${snippetInstance.id}">down</label></div>
    </form>
    <g:javascript>
        (function(){
            $("#form\_vote\_${snippetInstance.id} div #up\_vote\_${snippetInstance.id}").button({icons:{primary:"ui-icon-triangle-1-n"},text:false});
            $("#form\_vote\_${snippetInstance.id} div #down\_vote\_${snippetInstance.id}").button({icons:{primary:"ui-icon-triangle-1-s"},text:false});
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
