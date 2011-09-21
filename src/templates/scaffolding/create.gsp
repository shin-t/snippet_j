<% import grails.persistence.Event %>
<% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <r:require modules="jquery-ui, common" />
        <r:script>
            \$(function(){
                \$("input:submit, input:button").button().css("font-size","8pt");
                \$("#searchableForm button").button({icons:{primary:"ui-icon-search"},text:false}).css("font-size","8pt");
            });
        </r:script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <div class="sidebar"></div>
            <g:if test="\${flash.message}">
            <div class="message">\${flash.message}</div>
            </g:if>
            <g:hasErrors bean="\${${propertyName}}">
            <div class="errors">
                <g:renderErrors bean="\${${propertyName}}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
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
            </g:form>
        </div>
    </body>
</html>
