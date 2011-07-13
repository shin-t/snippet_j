<div class="history">
    <ul>
        <g:each in="${snippetInstance.subsnippets}" status="i" var="subsnippet">
            <li>
                <p><g:link action="show" id="${snippetInstance.id}">${subsnippet.lastUpdated}</g:link></p>
                <p>
                <g:each in="${subsnippet.patch.readLines()}" status="j" var="line">
                    <g:if test="${line[0]=='+'}">
                        <div class="plus_line">${line.encodeAsHTML()}</div>
                    </g:if>
                    <g:else>
                        <g:if test="${line[0]=='-'}">
                            <div class="minus_line">${line.encodeAsHTML()}</div>
                        </g:if>
                            <g:else>
                                <div class="line">${line.encodeAsHTML()}</div>
                            </g:else>
                    </g:else>
                </g:each>
                </p>
                <p>
                <pre><code>${subsnippet.patch}</code></pre>
                </p>
            </li>
        </g:each>
    </ul>
</div>
