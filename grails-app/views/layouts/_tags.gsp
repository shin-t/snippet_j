<div class="tags">
    <div class="header">
        <h2><g:message code="snippet.tags.label" default="Tags" /></h2>
    </div>
    <div class="body">
        <g:form url='[controller: "user", action: "tags"]' id="searchableForm" name="searchableForm" method="get">
            <g:hiddenField name="username" value="${userInstance?.username}"/>
            <button><g:message code="default.search.label" default="Search" /></button><g:textField name="tags" value="${params.tags}"/>
        </g:form>
        <div>
            <g:each in="${tags}" var="c">
                <div class="tag"><g:link controller="user" action="tags" params="[tags:c[0],username:userInstance?.username]" class="tag">${c[0].encodeAsHTML()}</g:link>(${c[1].encodeAsHTML()})</div>
            </g:each>
        </div>
    </div>
</div>
