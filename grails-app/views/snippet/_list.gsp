<div class="list">
    <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
        <g:render template="/snippet/content" model="[snippetInstance:snippetInstance]" />
    </g:each>
    <g:javascript>
        $("input:checkbox.up\_vote\_button").button({icons:{primary:"ui-icon-triangle-1-n"},text:false});
        $("input:checkbox.down\_vote\_button").button({icons:{primary:"ui-icon-triangle-1-s"},text:false});
        $("input:checkbox.star\_button").button({icons:{primary:"ui-icon-star"},text:false});
    </g:javascript>
</div>
<g:javascript>
    function clearForm() { $(".reply_form").empty() }
    $("input:checkbox.up\_vote\_button").button({icons:{primary:"ui-icon-triangle-1-n"},text:false});
    $("input:checkbox.down\_vote\_button").button({icons:{primary:"ui-icon-triangle-1-s"},text:false});
    $("input:checkbox.star\_button").button({icons:{primary:"ui-icon-star"},text:false});
</g:javascript>
<div style="display:none"><g:paginate controller="snippet" action="list" total="${snippetInstanceTotal}" /></div>
