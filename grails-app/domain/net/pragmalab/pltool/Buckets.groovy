package net.pragmalab.pltool

class Buckets  {
    static hasMany = [buckets_exceptions: Buckets_Exceptions, buckets_results: Buckets_Results]

    static constraints = { }

    Long categoryId
    Long objectClassId
    Long type
    String definition
    String name
    String description
}
