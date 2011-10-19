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
    var label = $(this).attr("checked")?"unstar":"star";
    var obj = $(this)
    $.ajax({
        type:'POST',
        url:'/snippet/star/'+$(obj).button("option","label")+'/'+e.data.id,
        success: function(){
            $(obj).button("option","label",label);
        }
    });
}

var update_solved = function(e){
    var label = $(this).attr("checked")?"solved":"unsolved";
    var obj = $(this)
    $.ajax({
        type:'POST',
        url:'/snippet/snippet/solved/'+e.data.id,
        success: function(){
            $(obj).button("option","label",label);
            $(".help_"+e.data.id+" span").text("Help!").parent().removeClass("help").addClass("solved");
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

