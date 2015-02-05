import org.codehaus.groovy.grails.context.support.PluginAwareResourceBundleMessageSource

class ExtendedPluginAwareResourceBundleMessageSource extends PluginAwareResourceBundleMessageSource {
    Map<String, String> listMessageCodes(Locale locale) {
        Properties properties = getMergedProperties(locale).properties
        Properties pluginProperties = getMergedPluginProperties(locale).properties
        return properties.plus(pluginProperties)
    }
}