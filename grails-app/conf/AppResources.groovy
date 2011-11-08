modules = {
    common {
        dependsOn 'jquery'
        resource url:'css/main.css'
        resource url:'google-code-prettify/prettify.css'
        resource url:'google-code-prettify/prettify.js'
        resource url:'js/common.js'
    }
    bootstrap {
        dependsOn 'jquery'
        resource url:'bootstrap/bootstrap.min.css'
        resource url:'bootstrap/bootstrap-buttons.js'
    }
}
