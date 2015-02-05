grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6


//Holger: lokale Plugins
grails.plugin.location.fileuploader = "src/plugins/ajax-uploader-1.1"
grails.plugin.location.mail = "src/plugins/mail-1.0.7"

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        grailsCentral()

        mavenLocal()
        mavenCentral()

        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.

        // runtime 'mysql:mysql-connector-java:5.1.22'
    }

    plugins {
        runtime ":hibernate:$grailsVersion"
        runtime ":resources:1.1.6"

        build ":tomcat:$grailsVersion"

        runtime ":database-migration:1.3.2"

        runtime ":mysql-connectorj:5.1.22.1"

        runtime ":spring-security-core:1.2.7.3"
        runtime ":spring-security-acl:1.1.1"
        runtime ":spring-security-ui:0.2"

        runtime ":famfamfam:1.0.1"
        runtime ":lesscss-resources:1.3.3"
        runtime ":twitter-bootstrap:2.3.0"

        compile ':cache:1.0.1'

        compile ":quartz:1.0.1"

        compile ":jasper:1.7.0"



    }

}
