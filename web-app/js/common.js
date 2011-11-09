var button_icons = function(){
    //$("input:submit, input:button").button();
    //$(".buttons a").button();
    $(".buttons .star_button:checkbox").each(function(){
        var obj = $(this);
        var id = $(this).prev().prev().val();
        $.ajax({
            type:'GET',
            url:'/snippet/star/star/'+id,
            success: function(data){
                var label;
                if(data.exists){
                    label = "Unstar";
                    $(obj).attr("checked","checked");
                }
                else{
                    label = "Star";
                }
                $(obj).button({label:label,icons:{primary:"ui-icon-star"}}).click({id:id},star_update);
                $.ajax({
                    type:'GET',
                    url:'/snippet/star/index/'+id,
                    success: function(data){
                        if(!data.message){
                            var label = $(obj).button("option","label") +' &times;'+ data.count;
                            $(obj).button("option","label",label);
                        }
                    }
                });
            }
        });
    });
    prettyPrint();
}

var reset_autopager = function(){
    button_icons();
}

var star_update = function(e){
    var label = $(this).attr("checked")?"Unstar":"Star";
    var obj = $(this)
    $.ajax({
        type:'POST',
        url:'/snippet/star/'+($(obj).attr("checked")?"star":"unstar")+'/'+e.data.id,
        success: function(){
            $(obj).button("option","label",label);
            $.ajax({
                type:'GET',
                url:'/snippet/star/index/'+e.data.id,
                success: function(data){
                    if(!data.message){
                        var label = $(obj).button("option","label") +' &times;'+ data.count;
                        $(obj).button("option","label",label);
                    }
                }
            });
        }
    });
}

var clearForm = function(){
    $(".reply_form").empty()
}

button_icons();
prettyPrint();
