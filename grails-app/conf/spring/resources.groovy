// Place your Spring DSL code here
beans = {

    //Holger: Standardsparache auf Deutsch setzen
    localeResolver(org.springframework.web.servlet.i18n.SessionLocaleResolver) {
        defaultLocale = new Locale("de","DE")
        java.util.Locale.setDefault(defaultLocale)
    }

    messageSource(ExtendedPluginAwareResourceBundleMessageSource)  {
        basenames = "WEB-INF/grails-app/i18n/messages"
    }
}
