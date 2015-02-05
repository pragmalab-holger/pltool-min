hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}

dataSource {
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:h2:file:h2db/db-dev;ignorecase=true"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:file:h2db/db-test"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:file:/h2db/db-prod"
        }
    }
}