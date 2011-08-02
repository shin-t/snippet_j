<div class="list">
<g:each in="${snippetInstance.comments}" status="i" var="commentInstance">
<div class="comment">


<div class="head">
<div><g:link action="show" id="${commentInstance.id}"><g:formatDate date="${commentInstance.lastUpdated}" /></g:link></div>
<div>${commentInstance.author.username}</div>
</div>
<div>${fieldValue(bean: commentInstance, field: "comment")}</div>
</div>
</g:each>
</div>
