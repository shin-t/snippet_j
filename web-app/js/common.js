var button_icons = function(){
    $("input:submit, input:button").button();
    $(".buttons a").button();
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
    $(".buttons .help_button:checkbox").each(function(){
        var id = $(this).parent().children().first().val();
        var label;
        if($(this).attr("checked")){
            label = "solved";
        }
        else{
            label = "unsolved";
        }
        $(this).button({label:label,icons:{primary:"ui-icon-star"}}).click({id:id},update_solved);
    });
    prettyPrint();
}

var reset_autopager = function(){
    $.autopager('destroy');
    $.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons });
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

$("#list_filter").buttonset().children(":radio").button();

$.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons });

button_icons();

prettyPrint();

