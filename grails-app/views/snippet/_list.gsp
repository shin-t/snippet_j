<div class="list">
    <div id="update"></div>
    <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
        <g:render template="content" model="[snippetInstance:snippetInstance]" />
    </g:each>
</div>
<g:javascript>function clearForm() { $(".reply_form").empty() }</g:javascript>
<div style="display:none"><g:paginate controller="snippet" action="list" total="${snippetInstanceTotal}" /></div>
