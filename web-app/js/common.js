var button_icons = function(){
    $(".footer div a").button({icons:{primary:"ui-icon-tag"}});
    $(".footer ul li.reply a").button({icons:{primary:"ui-icon-comment"}});
    $(".footer ul li.delete a").button({icons:{primary:"ui-icon-trash"}});
    $(".footer ul li input:checkbox").button({icons:{primary:"ui-icon-star"}});
}

var reset_autopager = function(){
    $.autopager('destroy');
    $.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons });
}

var update_solved = function(id){
    if($(".help_"+id+" input:checkbox").attr('checked')){
        $(".help_"+id+" span").text("Help!").parent().removeClass("solved").addClass("help");
    }
    else{
        $(".help_"+id+" span").text("Solved!").parent().removeClass("help").addClass("solved");
    }
}

var clearForm = function(){
    $(".reply_form").empty()
}

$("input:submit, input:button").button();

$("#list_filter").buttonset().children(":radio")
                 .first()
                 .next().button({icons:{primary:"ui-icon-person"}})
                 .next().button({icons:{primary:"ui-icon-tag"}});

$.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons });

button_icons();

