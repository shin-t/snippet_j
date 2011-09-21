<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails"/></title>
        <g:javascript library="application" />
        <g:layoutHead />
        <r:layoutResources />
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
        <g:render template="/layouts/nav" />
        <g:layoutBody />
        <r:layoutResources />
    </body>
</html>
