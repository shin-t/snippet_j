grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
//grails.project.war.file = "target/${appName}-${appVersion}.war"
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    repositories {
        grailsPlugins()
        grailsHome()
        grailsCentral()

        // uncomment the below to enable remote dependency resolution
        // from public Maven repositories
        //mavenLocal()
        //mavenCentral()
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.

        // runtime 'mysql:mysql-connector-java:5.1.13'

        test("org.seleniumhq.selenium:selenium-htmlunit-driver:2.0b3") {
            exclude 'xml-apis'
        }
        test 'org.seleniumhq.selenium:selenium-chrome-driver:2.0b3'
        test "org.codehaus.geb:geb-spock:0.6.0"
    }
    plugins {
        test ":spock:0.5-groovy-1.7"
        test ":geb:0.6.0"
    }
}

codenarc.reports = {
    // Each report definition is of the form:
    //    REPORT-NAME(REPORT-TYPE) {
    //        PROPERTY-NAME = PROPERTY-VALUE
    //        PROPERTY-NAME = PROPERTY-VALUE
    //    }

    MyXmlReport('xml') {                    // The report name "MyXmlReport" is user-defined; Report type is 'xml'
        outputFile = 'target/test-reports/CodeNarc-Report.xml'  // Set the 'outputFile' property of the (XML) Report
            title = 'CodeNarc Report'             // Set the 'title' property of the (XML) Report
    }
    MyHtmlReport('html') {                  // Report type is 'html'
        outputFile = 'target/test-reports/CodeNarc-Report.html'
            title = 'CodeNarc Report'
    }
}

