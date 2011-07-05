		$(document).ready(function(){
			$('#keyword')
			.blur(function(){
      			var $$=$(this);
      			if($$.val()=='' || $$.val()==$$.attr('name')){
        			$$.css('color', '#999').val($$.attr('name'));
      			}
    		})
			.focus(function(){
      			var $$=$(this);
      			if($$.val()==$$.attr('name')){
        			$(this).css('color', '#000').val('');
      			}
    		})
    		.end()
    		.blur();
		});