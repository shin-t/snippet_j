
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <sec:ifLoggedIn><span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></sec:ifLoggedIn>
        </div>
        <div class="body">
            <!-- test API -->
            <script type="text/javascript">
                (function(){
                    var vars = [], hash;
                    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                    for(var i = 0; i < hashes.length; i++){
                        hash = hashes[i].split('=');
                        vars.push(hash[0]);
                        vars[hash[0]] = hash[1];
                    }
                    console.log(vars);
                    if(vars.id){
                            console.log(vars.id);
                            var url ='https://api.github.com/gists/'+vars.id+'?callback=?'
                            console.log(url);
                            $.getJSON(url,function(json){
                                console.log(json);
                                $("#gists").append(
                                    '<div class="dialog">'+
                                        '<a href="'+json.data.html_url+'">'+
                                            '<div class="head">'+
                                                '<p>description:&nbsp;'+json.data.description+'</p>'+
                                                '<p>user login:&nbsp;'+json.data.user.login+
                                                '&nbsp;<img width="16" height="16" alt="Gravatar" class="gravatar" src="'+json.data.user.avatar_url+'"/></p>'+
                                                '<p>created at:&nbsp;'+json.data.created_at+'</p>'+
                                            '</div>'+
                                        '</a>'+
                                        '<div class="body"></div>'+
                                    '</div>'
                                );
                                for(var i in json.data.files){
                                    var content = $("<div/>",{"class":"file"});
                                    content.append($("<p/>",{text:"filename: "+json.data.files[i].filename}));
                                    content.append($("<p/>").append($("<pre/>").append($("<code/>",{text:json.data.files[i].content}))));
                                    $("#gists .dialog .body").append(content);
                                }
                                $("#gists").append('<div class="history"><div class="head">history</div><div class="body"></div>');
                                for(var i=0;i<json.data.history.length;i++){
                                    $("#gists .history .body").append($("<p/>",{text:"committed at: "+json.data.history[i].committed_at+", version: "+json.data.history[i].version}));
                                }
                                $("#gists").append('<div class="forks"><div class="head">forks</div><div class="body"></div>');
                                for(var i=0;i<json.data.forks.length;i++){
                                    console.log(json.data.forks[i]);
                                    $("#gists .forks .body").append(
                                        '<p><a href="/snippet/snippet/?id='+json.data.forks[i].id+'">'+json.data.forks[i].id+'</a></p>'+
                                        '<ul><li>user login:&nbsp;'+json.data.user.login+'&nbsp;<img width="16" height="16" alt="Gravatar" class="gravatar" src="'+json.data.user.avatar_url+'"/></li>'+
                                        '<li>created at:&nbsp;'+json.data.created_at+'</li></ul>'
                                    );
                                }
                            });
                    }else{
                        //$.getJSON('/snippet/snippet/gistsAPI',function(json){
                        $.getJSON('https://api.github.com/gists?callback=?',function(json){
                            console.log(json);
                            console.log(json.data.length);
                            for(var i=0;i<json.data.length;i++){
                                $("#gists").append(
                                    '<div class="dialog">'+
                                        '<a href="/snippet/?id='+json.data[i].id+'">'+
                                            '<div class="head">'+
                                                '<p>description:&nbsp;'+json.data[i].description+'</p>'+
                                                '<p>user login:&nbsp;'+json.data[i].user.login+
                                                '&nbsp;<img width="16" height="16" alt="Gravatar" class="gravatar" src="'+json.data[i].user.avatar_url+'"/></p>'+
                                                '<p>created at:&nbsp;'+json.data[i].created_at+'</p>'+
                                            '</div>'+
                                        '</a>'+
                                    '</div>'
                                );
                            }
                        });
                    }
                })();
            </script>
            <div id="gists"></div>
            <!-- -->
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
                    <g:render template="/layouts/snippet" model="${[snippetInstance: snippetInstance]}"/>
                </g:each>
            </div>
        </div>
        <div class="paginateButtons">
                <g:paginate total="${snippetInstanceTotal}" />
        </div>
    </body>
</html>
