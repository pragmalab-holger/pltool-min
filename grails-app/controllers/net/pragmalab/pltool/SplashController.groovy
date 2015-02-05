package net.pragmalab.pltool
import grails.converters.JSON

class SplashController {

    def index() {

        def sessionFactory
        def grailsApplication

        def sp=Splash.last()

        render sp as JSON
    }
} 