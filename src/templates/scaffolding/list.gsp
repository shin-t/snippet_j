<% import grails.persistence.Event %>
<% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require modules="jquery-ui, common" />
        <r:script>
            \$(function(){
                \$("input:submit, input:button").button().css("font-size","8pt");
                \$("#searchableForm button").button({icons:{primary:"ui-icon-search"},text:false}).css("font-size","8pt");
            });
        </r:script>
    </head>
    <body>
        <div class="body">
            <div class="sidebar"></div>
            <div class="contents">
                <g:if test="\${flash.message}">
                <div class="message">\${flash.message}</div>
                </g:if>
                <g:formRemote name="dialog" url="[ action:'save']" update="update" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
                    <div class="dialog">
                        <div class="header">\${entityName}</div>
                        <%  excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
                            persistentPropNames = domainClass.persistentProperties*.name
                            props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            display = true
                            boolean hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate')
                            props.eachWithIndex { p, i ->
                                if (!Collection.class.isAssignableFrom(p.type)) {
                                    if (hasHibernate) {
                                        cp = domainClass.constrainedProperties[p.name]
                                        display = (cp ? cp.display : true)
                                    }
                                    if (display) { %>
                            <div class="prop">
                                <div class="name">
                                    <label for="${p.name}"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></label>
                                </div>
                                <div class="value \${hasErrors(bean: ${propertyName}, field: '${p.name}', 'errors')}">
                                        ${renderEditor(p)}
                                </div>
                            </div>
                        <%  }   }   } %>
                        <div class="buttons">
                            <span class="button"><g:submitButton name="create" class="save" value="\${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                        </div>
                    </div>
                </g:formRemote>
                <div class="list">
                    <div id="update"></div>
                    <%  excludedProps = Event.allEvents.toList() << 'version' << 'dateCreated' << 'lastUpdated'
                        allowedNames = domainClass.persistentProperties*.name
                        props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && !Collection.isAssignableFrom(it.type) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[])) %>
                    <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                    <div id="reply_\${${propertyName}.id}" class="reply_form"></div>
                    <div class="content">
                    <%  props.eachWithIndex { p, i ->
                            if (i == 0) { %>
                        <div class="header">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</div>
                    <%      } else if (i < 7) {
                                if (p.type == Boolean.class || p.type == boolean.class) { %>
                        <div><g:formatBoolean boolean="\${${propertyName}.${p.name}}" /></div>
                    <%          } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
                        <div><g:formatDate date="\${${propertyName}.${p.name}}" /></div>
                    <%          } else { %>
                        <div>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</div>
                    <%  }   }   } %>
                        <div><g:link action="show" id="\${${propertyName}.id}"><g:formatDate date="\${${propertyName}.lastUpdated}" /></g:link></div>
                        <div class="reply_button"><g:remoteLink action="create" id="\${${propertyName}.id}" update="reply_\${${propertyName}.id}" onLoaded="clearForm()">Reply</g:remoteLink></div>
                    </div>
                    </g:each>
                    <div class="paginateButtons">
                        <g:paginate total="\${${propertyName}Total}" />
                    </div>
                </div>
                <r:script>
                    function clearForm() { \$(".reply_form").empty() }
                </r:script>
            </div>
        </div>
    </body>
</html>
