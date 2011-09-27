<div class="list">
    <div id="update"></div>
    <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
    <g:render template="content" model="[snippetInstance:snippetInstance]" />
    </g:each>
</div>
<g:javascript>function clearForm() { $(".reply_form").empty() }</g:javascript>
<div style="display:none"><g:paginate controller="snippet" action="list" total="${snippetInstanceTotal}" /></div>
