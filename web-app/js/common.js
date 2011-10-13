var button_icons = function(){
    $("input:submit, input:button").button();
    $(".buttons a").button();
    $(".buttons input:checkbox").button({icons:{primary:"ui-icon-star"}});
}

var reset_autopager = function(){
    $.autopager('destroy');
    $.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons });
    button_icons();
}

var update_solved = function(id){
    if($(".help_"+id+" input:checkbox").attr('checked')){
        $(".help_"+id+" span").text("Help!").parent().removeClass("solved",250).addClass("help",250);
    }
    else{
        $(".help_"+id+" span").text("Solved!").parent().removeClass("help",250).addClass("solved",250);
    }
}

var clearForm = function(){
    $(".reply_form").empty()
}

$("#list_filter").buttonset().children(":radio").button();

$.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons });

button_icons();

