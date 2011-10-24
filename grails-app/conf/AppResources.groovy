modules = {
    common {
        dependsOn 'jquery-ui, jquery'
        resource url:'css/main.css'
        resource url:'js/jquery.autopager-1.0.0.min.js'
        resource url:'google-code-prettify/prettify.css'
        resource url:'google-code-prettify/prettify.js'
        resource url:'js/common.js'
    }
    snippet {
        resource url:'css/snippet.css'
    }
}
