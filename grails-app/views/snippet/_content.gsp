<div id="snippet_${snippetInstance?.id}" class="content">
    <div class="header">
        <div>${fieldValue(bean: snippetInstance.user, field: "username")}</div>
        <g:if test="${username != snippetInstance.user.username}">
        <div class="follow_${snippetInstance.user.id}">
            <a href="#"></a>
        </div>
        <g:javascript>
        (function(){
            var follow_update = function(data){
                if(data){
                    $('.follow_${snippetInstance.user.id}').html($("<a href='#'>unfollow</a>").click(function(){
                        ${remoteFunction(controller:'user', action:'unfollow', params:[username: snippetInstance.user.username], onSuccess:'follow_update(false)')}
                        return false;
                    }));
                }
                else{
                    $('.follow_${snippetInstance.user.id}').html($("<a href='#'>follow</a>").click(function(){
                        ${remoteFunction(controller:'user', action:'follow', params:[username: snippetInstance.user.username], onSuccess:'follow_update(true)')}
                        return false;
                    }));
                }
            }
            var follow_check = function(){
                ${remoteFunction(controller:'user', action:'follow_check', params:[username: snippetInstance.user.username], onSuccess:'follow_update(data[0])')}
            }
            follow_check();
        })();
        </g:javascript>
        </g:if>
        <g:if test="${snippetInstance.root}">
        <div style="clear:both;">${fieldValue(bean: snippetInstance.root.user, field: "username")}: ${fieldValue(bean: snippetInstance.root, field: "text")}</div>
        </g:if>
    </div>
    <div class="text"><pre>${fieldValue(bean: snippetInstance, field: "text")}</pre></div>
    <g:if test="${snippetInstance?.file}">
    <div class="file"><pre><code>${fieldValue(bean: snippetInstance, field: "file")}</code></pre></div>
    </g:if>
    <g:if test="${snippetInstance?.status == 1}">
    <div><g:formatBoolean boolean="${snippetInstance.help}" true="Help!" false="Solved!" /></div>
    </g:if>
    <g:elseif test="${snippetInstance?.status == 2}">
    <div><g:formatDate date="${snippetInstance.deadline}" /></div>
    </g:elseif>
    <div style="float:left">
        <g:each in="${tags}" var="tag">
        <g:link controller="tag" params="[tag: tag]">${tag.encodeAsHTML()}</g:link>
        </g:each>
    </div>
    <ul class="footer">
        <li><prettytime:display date="${snippetInstance.lastUpdated}" /></li>
        <li class="star_${snippetInstance.id}"></li>
        <li><g:remoteLink action="create" params="[parent_id:snippetInstance.id]" update="reply_${snippetInstance.id}" onLoaded="clearForm()">Reply to This</g:remoteLink></li>
        <li><g:link action="show" id="${snippetInstance.id}">Chunk(${snippetInstance.children.size().encodeAsHTML()})</g:link></li>
        <g:if test="${snippetInstance.root}">
        <li><g:link action="show" id="${snippetInstance.parent.id}" fragment="snippet_${snippetInstance.id}">Parent</g:link></li>
        <g:if test="${snippetInstance.root!=snippetInstance.parent}">
        <li><g:link action="show" id="${snippetInstance.root.id}">Root</g:link></li>
        </g:if>
        </g:if>
        <sec:ifLoggedIn>
        <g:javascript>
        (function(){
            var update = function(data){
                $('.star_${snippetInstance.id}').html($("<a href='#'></a>").text((data.exists?"unstar":"star")+" ("+data.count+")").click(function(){
                    ${remoteFunction(controller:'snippet', action:'star', params:[id: snippetInstance.id], method:'POST', onSuccess:'update(data)')}
                    return false;
                }));
            }
            ${remoteFunction(controller:'snippet', action:'star', params:[id: snippetInstance.id], method:'GET', onSuccess:'update(data)')}
        })();
        </g:javascript>
        </sec:ifLoggedIn>
        <sec:ifNotLoggedIn>
        <g:javascript>
        (function(){
            var update = function(data){
                $('.star_${snippetInstance.id}').text("Star ("+data.count+")");
            }
            ${remoteFunction(controller:'snippet', action:'star', params:[id: snippetInstance.id], method:'GET', onSuccess:'update(data)')}
        })();
        </g:javascript>
        </sec:ifNotLoggedIn>
    </ul>
    <div id="reply_${snippetInstance.id}" class="reply_form"></div>
</div>
