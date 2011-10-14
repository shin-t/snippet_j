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
                    label = "unstar";
                    $(obj).attr("checked","checked");
                }
                else{
                    label = "star";
                }
                $(obj).button({label:label,icons:{primary:"ui-icon-star"}}).click({id:id},star_update);
            }
        });
    });
}

var reset_autopager = function(){
    $.autopager('destroy');
    $.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons });
    button_icons();
}

var update_solved = function(id){
    if($(".help_"+id+" input:checkbox").attr('checked')){
        $(".help_"+id+" span").text("Help!").parent().removeClass("solved").addClass("help",250);
    }
    else{
        $(".help_"+id+" span").text("Solved!").parent().removeClass("help").addClass("solved",250);
    }
}

var clearForm = function(){
    $(".reply_form").empty()
}

$("#list_filter").buttonset().children(":radio").button();

$.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons });

button_icons();

