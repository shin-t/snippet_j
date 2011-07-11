                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="snippet.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: snippetInstance, field: 'description', 'errors')}">
                                        <g:textField name="description" value="${snippetInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="snippet.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: snippetInstance, field: 'name', 'errors')}">
                                        <g:textField name="name" value="${snippetInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="snippet"><g:message code="snippet.snippet.label" default="Snippet" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: snippetInstance, field: 'snippet', 'errors')}">
                                        <g:textArea name="snippet" value="${snippetInstance?.snippet}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
