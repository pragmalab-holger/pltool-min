package net.pragmalab.pltool

class Documents {

    static constraints = {
    }

    String Dateiname
    Date Uploadzeit
    String UUID
    String Pfad
    String HochgeladenVon
    Integer Groesse

    //Holger: Konstruktor
    Documents( String _dateiname, Date _wann, String _uuid, String _pfad, String _von, Number _groesse ){

        Dateiname = _dateiname;
        Uploadzeit = _wann;
        UUID = _uuid;
        Pfad = _pfad;
        HochgeladenVon = _von;
        Groesse = _groesse;

    }
}
