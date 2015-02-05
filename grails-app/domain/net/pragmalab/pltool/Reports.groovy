package net.pragmalab.pltool

class Reports {

    static constraints = {
        jrxml (size:0..2147483646)

        // ExternalId(nullable: true)
         // Name(nullable: true)
         // Category (nullable: true)
         // Description (nullable: true)
         // Owner  (nullable: true)
    }

    String ExternalId
    String Name
    String Category
    String Description
    SecUser Owner

    String jrxml
//    static mapping = {
//        jrxml type: 'longtext'
//    }
}
