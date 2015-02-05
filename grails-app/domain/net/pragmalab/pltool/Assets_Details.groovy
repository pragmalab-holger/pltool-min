package net.pragmalab.pltool

class Assets_Details {

    static belongsTo = [assets: Assets]

    static constraints = {
    }

    String name
    String type
}
