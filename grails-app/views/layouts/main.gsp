<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <g:javascript library="application" />
        <g:javascript library="jquery" plugin="jquery"/>
        <jqui:resources />
        <g:layoutHead />
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
        <g:render template="/layouts/nav" />
        <div id="header"><g:link controller="snippet"><h1>Snippet</h1></g:link></div>
        <g:layoutBody />
    </body>
</html>
