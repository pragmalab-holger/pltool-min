package net.pragmalab.pltool

import grails.converters.JSON

class AdminController {

    def user
    def messageSource

    def index() {}

    //Holger: i18n
    def gui_messages(){

        def messageMap = messageSource.listMessageCodes(request.locale);
        render messageMap as JSON

    }

}
