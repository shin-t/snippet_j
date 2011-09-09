
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title>
            <g:message code="default.show.label" args="[entityName]" />
        </title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="main">
                <div class="snippet content">
                    <div class="header">
                        <h2>${fieldValue(bean: snippetInstance, field: "name")}</h2>
                        <h3>${fieldValue(bean: snippetInstance, field: "description")}</h3>
                        <div class="float_left">
                            <g:render template="/layouts/edit_tag" model="[snippetInstance:snippetInstance,snippetTags:snippetTags,star:star]"/>
                        </div>
                        <div class="float_right">
                            <g:link controller="user" action="show" params="[username:snippetInstance?.author?.username]">${snippetInstance?.author?.username.encodeAsHTML()}</g:link>
                        </div>
                        <div class="float_right">
                            <g:formatDate date="${snippetInstance?.dateCreated}" />
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                    <div class="float_left">
                        <g:render template="/layouts/vote" model="[snippetInstance:snippetInstance]"/>
                        <g:render template="/layouts/star" model="[snippetInstance:snippetInstance,stars:stars]"/>
                    </div>
                    <div class="body">
                        <pre><code>${fieldValue(bean: snippetInstance, field: "snippet")}</code></pre>
                    </div>
                    <g:if test="${snippetInstance.author==currentUser}">
                    <div class="buttons">
                        <g:form>
                            <g:hiddenField name="id" value="${snippetInstance?.id}" />
                            <span class="button">
                                <g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
                            </span>
                            <span class="button">
                                <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                            </span>
                        </g:form>
                    </div>
                    </g:if>
                    <div class="clear"></div>
                </div>
                <g:render template="/layouts/comments" model="[snippetInstance:snippetInstance,currentUser:currentUser]"/>
                <g:render template="/layouts/comment" model="[snippetInstance:snippetInstance]"/>
            </div>
        </div>
    </body>
</html>
