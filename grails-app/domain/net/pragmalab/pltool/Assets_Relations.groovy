package net.pragmalab.pltool

class Assets_Relations {
    Contacts contact
    Long role_id

    static belongsTo = [assets: Assets]

    static constraints = {
    }
}
