package net.pragmalab.pltool

class Contacts {

    static mapping = {
        anmerkungen_1 type: 'text'
        anmerkungen_2 type: 'text'
        anmerkungen_3 type: 'text'
        anmerkungen_4 type: 'text'
        erklaerung_zahlungsrueckstaende type: 'text'
        pfaendung_vollstreckung_kommentar type: 'text'

    }

    static constraints = {

        username nullable: true
        email nullable : true
        geburtsname nullable : true
        titel nullable : true
        familienstand nullable : true
        anzahl_kinder nullable : true
        ansaessig_seit nullable : true
        aufenthalt_bis nullable : true
        arbeitserlaubnis nullable : true
        telefax nullable : true
        telefon2 nullable : true
        homepage nullable : true
        fremdsprache_1 nullable : true
        fremdsprache_2 nullable : true
        fremdsprache_3 nullable : true
        anmerkungen_1 nullable : true
        beschaeft_1 nullable : true
        beschaeft_2 nullable : true
        anmerkungen_2 nullable : true
        gehalt nullable : true
        gehalt_2 nullable : true
        kindergeld nullable : true
        gruendungszuschuss nullable : true
        gruendungszuschuss_2 nullable: true
        miete nullable : true
        lebenshaltung nullable : true
        krankenversicherung nullable : true
        private_versicherungen nullable : true
        kfz_versicherung nullable : true
        kfz_kosten nullable : true
        sonstige_ausgaben nullable : true
        wareneinsatz_projekt nullable : true
        miete_warm_projekt nullable : true
        versicherungen_projekt nullable : true
        telekommunikation_projekt nullable : true
        reise_projekt nullable : true
        werbung_projekt nullable : true
        sonstige_ausgabe_projekt nullable : true
        wareneinsatz_projekt_neu nullable : true
        miete_warm_projekt_neu nullable : true
        versicherungen_projekt_neu nullable : true
        telekommunikation_projekt_neu nullable : true
        reise_projekt_neu nullable : true
        werbung_projekt_neu nullable : true
        sonstige_ausgabe_projekt_neu nullable : true
        projekt_deckt_lebenshaltungskosten nullable : true
        monatliche_entnahmen nullable : true
        anmerkungen_3 nullable : true
        tilgungsmodus nullable : true
        sondertilgung nullable : true
        teilauszahlungen nullable : true
        darlehenszweck nullable : true
        sicherheiten nullable : true
        investoren nullable : true
        kaufm_begleitung nullable : true
        mithelfende_personen nullable : true
        anmerkungen_4 nullable : true

    }

    String username

    String nachname
    String vorname
    String rolle
    Integer status
    String wohnort
    String email
    String telefon

    Integer geschlecht
    String geburtsname
    Integer titel
    Date geburtsdatum
    String geburtsort
    Integer staatsangehoerigkeit
    Integer familienstand
    String anzahl_kinder

    String strasse_hausnummer
    Integer plz
    String ansaessig_seit
    String aufenthalt_bis
    Integer arbeitserlaubnis

    String telefax
    String telefon2
    String homepage

    String muttersprache

    String fremdsprache_1
    String fremdsprache_2
    String fremdsprache_3

    String anmerkungen_1

    String tätigkeit
    String beschaeft_1
    String beschaeft_2

    Integer alg_1
    Integer alg_2
    Integer schufa_negativ
    Integer steuerschulden
    Integer mahnverfahren
    Integer pfaendung_vollstreckung
    String pfaendung_vollstreckung_kommentar
    String erklaerung_zahlungsrueckstaende
    Integer insolvenzverfahren

    String anmerkungen_2

    Integer gehalt
    Integer gehalt_2
    Integer kindergeld
    Integer gruendungszuschuss
    Integer gruendungszuschuss_2
    Integer miete
    Integer lebenshaltung
    Integer krankenversicherung
    Integer private_versicherungen
    Integer kfz_versicherung
    Integer kfz_kosten
    Integer sonstige_ausgaben
    Integer wareneinsatz_projekt
    Integer miete_warm_projekt
    Integer versicherungen_projekt
    Integer telekommunikation_projekt
    Integer reise_projekt
    Integer werbung_projekt
    Integer sonstige_ausgabe_projekt
    Integer wareneinsatz_projekt_neu
    Integer miete_warm_projekt_neu
    Integer versicherungen_projekt_neu
    Integer telekommunikation_projekt_neu
    Integer reise_projekt_neu
    Integer werbung_projekt_neu
    Integer sonstige_ausgabe_projekt_neu
    String projekt_deckt_lebenshaltungskosten
    String monatliche_entnahmen

    Integer kapital_bereits_projekt
    String projektlaufzeit_breakeven_operativ
    String projektlaufzeit_breakeven_invest
    Integer geplanter_monatsumsatz
    Integer kapbedarf_kurz
    Integer kapbedarf_mittel
    Integer kapbedarf_lang

    String anmerkungen_3

    Integer darlehenshoehe
    Integer laufzeit_monate
    Integer tilgungsmodus
    Integer sondertilgung
    Integer teilauszahlungen
    Integer darlehenszweck

    Integer sicherheiten
    Integer investoren
    Integer kaufm_begleitung
    String mithelfende_personen

    String anmerkungen_4

    String beratungsart
    String beratungsthema
    Contacts Betreuer

}
