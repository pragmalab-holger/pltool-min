import grails.converters.JSON;

class BootStrap {


    def init = { servletContext ->
        JSON.registerObjectMarshaller(Date) {
            return it?.format("yyyy-MM-dd HH:mm:ss")
        }
        TimeZone.setDefault(TimeZone.getTimeZone("CET"))
    }
    def destroy = {                                                                                                                            x
    }
}