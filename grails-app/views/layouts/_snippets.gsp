<div class="list">
    <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
        <div class="snippet content">
            <div class="header">
                <h2>
                    <g:link controller="snippet" action="show" id="${snippetInstance.id}">
                        ${fieldValue(bean: snippetInstance, field: "name")}
                    </g:link>
                </h2>
                <div class="float_left"><g:link controller="user" action="show" params="[username:snippetInstance?.author?.username]">${snippetInstance?.author?.username.encodeAsHTML()}</g:link></div>
                <div class="float_right"><g:formatDate date="${snippetInstance.dateCreated}" /></div>
                <div class="clear"></div>
            </div>
            <div class="body"></div>
            <div><g:render template="/layouts/vote" model="[snippetInstance:snippetInstance]"/></div>
            <div><g:render template="/layouts/edit_tag" model="[snippetInstance:snippetInstance]"/></div>
            <div><g:render template="/layouts/star" model="[snippetInstance:snippetInstance]"/></div>
        </div>
    </g:each>
</div>
