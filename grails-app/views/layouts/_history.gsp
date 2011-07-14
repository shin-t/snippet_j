<div class="history">
    <div class="head">history</div>
    <div class="body">
    <g:each in="${snippetInstance.getHistory()}" status="i" var="snippet">
        <p><g:link action="show" id="${snippet.id}" params="${[patch:true]}">${snippet.lastUpdated}</g:link></p>
    </g:each>
    </div>
</div>
