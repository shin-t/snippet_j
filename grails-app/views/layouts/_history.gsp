<script>
<!--
$(document).ready(function(){
    $('.history > .head').click(function(){
        $(this).next().children().slideToggle('fast');
    });
});
-->
</script>
<div class="history">
    <div class="head">history</div>
    <div class="body">
    <ul>
    <g:each in="${snippetInstance.getHistory()}" status="i" var="snippet">
        <li><g:link action="show" id="${snippet.id}" params="${[patch:true]}">${snippet.id}</g:link></li>
    </g:each>
    </ul>
    </div>
</div>
