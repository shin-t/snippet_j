<div class="list">
    <g:each in="${snippetInstance.comments}" status="i" var="commentInstance">
        <div class="comment">
            <div class="head">
                <span>
                    <g:link controller="comment" action="show" id="${commentInstance.id}">
                        <g:formatDate date="${commentInstance.lastUpdated}" />
                    </g:link>
                </span>
                <span>by&nbsp;${commentInstance.author.username}</span>
            </div>
            <div>${fieldValue(bean: commentInstance, field: "comment")}</div>
        </div>
    </g:each>
</div>
