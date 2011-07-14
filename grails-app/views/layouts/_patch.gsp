<g:if test="${snippetInstance.patch}">
    <g:each in="${snippetInstance.patch.patch.readLines()}" status="j" var="line">
        <g:if test="${line[0]=='+'}"><div class="plus_line">${line.encodeAsHTML()}</div></g:if>
        <g:else>
            <g:if test="${line[0]=='-'}"><div class="minus_line">${line.encodeAsHTML()}</div></g:if>
            <g:else><div class="line">${"&nbsp;"+line.encodeAsHTML()}</div></g:else>
        </g:else>
    </g:each>
</g:if>
