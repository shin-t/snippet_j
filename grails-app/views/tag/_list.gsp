<%@ page import="snippet.Snippet"%>
<div class="content">
    <g:if test="${params.username}">
        <div><g:message code="following.tags.label" default="Following tags"/></div>
    </g:if>
    <g:else>
        <div><g:message code="tag.label" default="Tags"/></div>
    </g:else>
    <g:if test="${tags}">
        <div>
            <g:each in="${tags}" var="t">
                <g:if test="${params.status}">
                    <p>
                        <g:link controller="snippet" action="tag" params="[status: params.status, tag: t.name.encodeAsURL()]" class="tag">${t.name.encodeAsHTML()}</g:link>
                        <br/>
                        <span>
                        <g:if test="${params.username}">
                            <g:message code="following.label" default="Follow"/>
                        </g:if>
                        <g:else>
                            <g:message code="snippet.${params.status}.label" default="${params.status}"/>
                        </g:else>
                        &times;${t.count.encodeAsHTML()}
                        </span>
                    </p>
                </g:if>
                <g:else>
                    <span><g:link controller="tag" action="index" params="[tag: t.name.encodeAsURL()]" class="tag">${t.name.encodeAsHTML()}&nbsp;&times;${t.count.encodeAsHTML()}</g:link></span>
                </g:else>
            </g:each>
        </div>
        <g:if test="${params.max}">
            <g:if test="${params.status}">
                <div class="more_link"><g:link controller="tag" params="[status: params.status]"><g:message code="tags.all.label" default="tags"/></g:link></div>
            </g:if>
            <g:else>
                <div class="more_link"><g:link controller="tag"><g:message code="tags.all.label" default="tags"/></g:link></div>
            </g:else>
        </g:if>
    </g:if>
</div>
