package net.pragmalab.pltool
import com.openkm.sdk4j.OKMWebservices
import com.openkm.sdk4j.OKMWebservicesFactory
import com.openkm.sdk4j.exception.ItemExistsException
import grails.converters.JSON
import grails.plugins.springsecurity.Secured
import groovy.json.JsonSlurper
import groovy.sql.Sql
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import uk.co.desirableobjects.ajaxuploader.exception.FileUploadException

import javax.servlet.http.HttpServletRequest

class DeepFinder {
    static Object findDeep( Map map, Object key ) {
        map.get( key ) ?: map.findResult { k, v -> if( v in Map ) v.findDeep( key ) }
    }
}

@Secured(["ROLE_ADMIN","ROLE_BETREUER","ROLE_BETRIEB","ROLE_CONTROLLING","ROLE_MARKETING","ROLE_PARTNERBANK","ROLE_PMO"])
class HomeController {

    def dataSource
    def springSecurityService
    def grailsApplication

    def index() {}

    def create_report() {}


    // DMS openKM Login
    String host = "http://pragmalab.info:8084/OpenKM";
    String user = "hdiedrich";
    String password = "pltooltk2014";
    OKMWebservices ws= OKMWebservicesFactory.newInstance(host, user, password);


    private mk_where(ArrayList srch,String searchObj){
        def tmp = " (1=1) "
        if (srch)
        {
            for (def i=0;i<srch.size();i++){
                if (!check_char(srch[i].toString())){
                    tmp = tmp +" and ( "
                    String str = srch[i][0].getClass().name

                    if(srch[i].getClass().name.contains("String")){
                        tmp += srch[i];
                    }
                    else if(!str.contains("ArrayList")){

                        tmp = tmp + mk_entry(srch[i],searchObj)
                    }
                    else {
                        if (srch[i].size()<2){

                            tmp = tmp +mk_entry(srch[i][0],searchObj)
                        }
                        else{
                            tmp = tmp+ " ( 1=0 ) "
                            for (def j=0;j<srch[i].size();j++) {
                                if(check_string(srch[i][j].toString())){
                                    tmp = tmp+ " or ( " + mk_entry(srch[i][j],searchObj) +" ) "
                                }
                            }
                        }
                    }
                    tmp = tmp +" ) "
                }
            }
        }

        return tmp
    }

    private mk_addon_where(String resultObj,ArrayList where){

        def tmp=db_gui_name(resultObj,where)

        if( tmp == null ) return ""
        if(tmp.size()>0)  {

            return tmp.first().addonWhere

        }
        else
        {
            return ""


        }


    }

    private mk_addon_from(String resultObj,ArrayList where){

        def tmp = db_gui_name(resultObj,where)

        if( tmp == null ) return ""
        if( tmp.size()>0 ){
            return tmp.first().addonFrom
        } else {
            return ""
        }
    }

    private mk_from(ArrayList tables){
        def timeStart = new Date()
        def tabl

        if( tables == null ) return null;
        if( tables.size()>1 ){
            tabl = tables[0]
            for(def i = 1;i<tables.size();i++){

                tabl = tabl +", " + tables[i]
            }}
        else
        {
            tabl = tables[0]
        }

        return tabl
    }

    private mk_select(String resulttype){

        def a = DataResults.findAllByResultTypeIlike(resulttype,[sort:"id"])
        if( a.size() > 0 ){
            def b = a.first().elementTable+".id "
            return b

        } else return null

    }

    private db_gui_name(String proof,ArrayList tables){

        def tabl

        if( tables == null ) return null;

        if (tables.size()>1){
            tabl = tables[0]
            for(def i = 1;i<tables.size();i++){

                tabl = tabl +", " + tables[i]
            }}
        else
        {
            tabl = tables[0]
        }

        def tmp= DataResults.findAllByResultTypeAndTablesFrom(proof, tabl)

        return tmp
    }

    private db_gui_attr_ios(String proof){

        List a=new ArrayList()

        def tmpv = DataResults.createCriteria().list {
                ilike( 'resultType', proof )
                order( 'orderKey', 'asc' )
                order( 'id', 'asc' )
            }

        tmpv.each{it->    def b=new ArrayList()
            b.add(it.elementTable)
            b.add(it.elementAttribute)
            b.add(it.elementLookup)
            b.add(it.elementHeader)
            b.add(it.elementType)
            b.add(it.elementFormat)
            b.add(it.pointerRule)
            b.add(it.pointerTable)
            a.add(b)
        }


        return a
    }

    private mk_headers( ArrayList list, Map serch, roles ){

        HashMap<String, Object> srch = []
        if (serch) {srch = serch}

        def headers_names=[],
            row_types=[],
            lookup=[],
            pt = [],
            slurper = new JsonSlurper(),
            froles;
        if (list.size()>0){
            for(def i=0;i<list.size();i++){
                froles = slurper.parseText( list[i][5] )["forbidden-roles"];
                if( froles!=null){
                    if( froles.tokenize(',').disjoint(roles) ){
                        headers_names.add(list[i][3])
                        row_types.add(list[i][5])
                        lookup.add(list[i][2])
                        pt.add(list[i][7])
                    }
                }
                else {
                    headers_names.add(list[i][3])
                    row_types.add(list[i][5])
                    lookup.add(list[i][2])
                    pt.add(list[i][7])
                }
            }
        }

        srch["header-names"]=headers_names
        srch["row-types"]=row_types
        srch["rows"] =[]
        srch["lookup"]=lookup
        srch["pointer-table"]=pt


        return srch
    }

    private mk_rows(String anfrage, Map srch, int offset, int len, roles){
        HashMap<String, Object> serch = []
        if (srch) {serch = srch}
        serch["rows"]=[]

        def sql = new Sql(dataSource),
            a = sql.rows(anfrage,offset,len),
            slurper = new JsonSlurper(),
            froles = "";

        for( def i in a ){
            def b=[]
            if( i.containsKey("Properties") ){
                if( i["Properties"].size() > 0 ){
                    froles = slurper.parseText( i["Properties"] )["forbidden-roles"];
                    if( froles.tokenize(',').disjoint(roles) ) for( def j in i ) b.add(j.value)
                }
                else for( def j in i ) b.add(j.value);
            }
            else for( def j in i ) b.add(j.value);

            if( b.size()>0 ) serch["rows"].add(b)
        }

        return serch

    }

    private mk_entry(ArrayList srch,String searchObj){

        def tmpdt=srch
        if (srch.size()==2){
            tmpdt = mk_four_of_two(srch,searchObj)
        }

        if (tmpdt.size()==4){


            return( DataResults.findAllByElementTypeAndElementHeader( tmpdt[0], tmpdt[1] ).first().getElementTable()+"."
                    + DataResults.findAllByElementTypeAndElementHeader( tmpdt[0], tmpdt[1] ).first().getElementAttribute()+ " "
                    + tmpdt[2] +" " +"\""+ tmpdt[3] + "\"")  }
        else {
            if (tmpdt.size()==1){
                return tmpdt[0]
            } else {
                return "Error"   }
        }
    }

    private check_string(String srch ) {
        if ((!check_char(srch)) && (check_char(srch[0]))) {return true}
        else {return false}
    }

    private check_char(String srch ) {
        if ((srch.length()==1) && (srch[0].length()==1)) {return true}
        else {return false}
    }

    private mk_four_of_two(ArrayList srch,String searchObj ) {
        if ((srch.size()==2) && (check_char(srch[0][0].toString()))){
            return [DataResults.findAllByElementHeaderAndResultTypeLike( srch[0], "%"+searchObj+"#%" ).first().getElementType(),srch[0],"like",srch[1]]
        }
        else{
            return srch
        }
    }

    def renderSplash() {
        render( template: "splash" )
    }

    def renderContent() {
        render( template: "content" )
    }

    def renderList(){
        render( template: "list")
    }

    def renderDetails() {
        render( template: "details" )
    }

    private mk_from_tables(String sql,String typ,String result){

        def v =[]
        def tmp
        def sk = sql.split(',')

        for(def i in sk){
            def sp=i.split(" ")
            for (def j in sp) {
                def point=j.split('\\.')
                if (point.size()>1) v.add(point[0])
            }
        }

        tmp = DataResults.findAllByResultTypeIlikeAndElementTypeIlike( result, typ, [sort:"id"] )
        if( tmp.size() > 0 ){
            v.add(tmp.first().getElementTable())
            return (v.unique().sort())
        } else return null

    }

    private mk_table_list(ArrayList tables){

        def tabl
        if (tables.size()>1){
            tabl = tables[0]
            for(def i = 1;i<tables.size();i++){

                tabl = tabl +", " + tables[i]
            }}
        else
        {
            tabl = tables[0]
        }

        return tabl
    }

    private get_data(HashMap tz, roles) {

        def search, searchObj, searchlist, resulttype, pagination, role, tabType, result, ca;
        def sql=new Sql(dataSource),
            where=' where ',
            select=' select ',
            from=' from ',
            query, where_new,
            select1=' select ';

        use( DeepFinder ) {
            role = tz.findDeep( 'role')
            pagination= tz.findDeep( 'pagination' )
            search=tz.findDeep( 'search-request' )
            searchObj=tz.findDeep( 'searched-object')
            tabType=tz.findDeep( 'tab-type')
            if(tabType == null){
                tabType=searchObj
            }
            searchlist=tz.findDeep('list-template-generic')
            resulttype= tabType+ "#" + tz.findDeep('controller-action')
            ca = tz.findDeep('controller-action')

        }
        where=  where + mk_where(search,searchObj)
        where_new = where + mk_addon_where(resulttype,mk_from_tables(where,searchObj,resulttype))
        select =select + mk_select(resulttype)

        if( select != " select null"){

            from = from + mk_from(mk_from_tables(where,searchObj,resulttype)) + mk_addon_from(resulttype,mk_from_tables(where,searchObj,resulttype))
            def element_count=(sql.rows(select + from + where_new).size())

            def res = db_gui_attr_ios(resulttype),
                orderTabs = false,
                slurper = new JsonSlurper(),
                froles;

            for(def i in res){

                //Holger: Rollenspez Deaktivierung
                froles = slurper.parseText( i[5] )["forbidden-roles"]
                if( froles!=null){
                    if( froles.tokenize(',').disjoint(roles) ){
                        if (i!=res[0]){
                            select1=select1 + ", "
                        }

                        if( i[0]!="" ){
                            select1=select1 +i[0]+"." +i[1] + " \"" + i[3] + "\" "
                        }
                        else select1 = select1 + " \"" + i[3] + "\" "

                        //Holger: Sortierung Tabs
                        if(i[3]=="Tabs") orderTabs = true;
                    }
                }
                else {
                    if (i!=res[0]){
                        select1=select1 + ", "
                    }

                    if( i[0]!="" && i[1]!="" ) select1 = select1 +i[0]+"." +i[1] + " \"" + i[3] + "\" ";
                    else select1 = select1 + " \"" + i[3] + "\" ";

                    //Holger: Sortierung Tabs
                    if(i[3]=="Tabs") orderTabs = true;
                }
            }

            def from1=" from "
            def v=[]
            for(def i in res){
                if( i[0]!="" ) v.add(i[0])
            }
            from1=from1 + mk_table_list(  v.unique().sort() ) + mk_addon_from(resulttype,v.unique().sort() )

            //Holger: Hier kommt das Addon zur selektiven Anzeige von Datensaetzen rein, zB. Reminder=Aktiv, Agenda=Offen, Adressat=username

            //Agenda
            if( searchObj=="agenda" && where_new==" where  (1=1) " ){
                where_new = " where  (1=1) and (agenda.status = 1 AND " +
                        "agenda.zeitpunkt < date_add( curdate(), interval 14 day) AND " +
                        "adressat_id = (select distinct id from contacts where username = '" + springSecurityService.currentUser.username + "') ) "
            }

            //Reminder
            if( searchObj=="reminders" && where_new==" where  (1=1) " ) where_new = " where  (1=1) and (reminders.aktiv = 1 ) "



            def where1= " where "  +   mk_select(resulttype) + ' in ( ' + select + from + where_new + ') ' + mk_addon_where(resulttype,v.unique().sort() )

            def anfrage=(select1 + from1 + where1)

            //Holger: Zusätzliche  Sortierung
            if( orderTabs ) anfrage = anfrage + " order by Tabs";
            if( from == " from agenda" ) anfrage = anfrage + " order by zeitpunkt";

            //Variable zusammenstellen
            result = mk_headers( res, searchlist, roles )
            result['rows'] = mk_rows( anfrage, searchlist, ((pagination[0]-1)*pagination[1]), pagination[1], roles )["rows"]
            result["pagination"]=[pagination[0],pagination[1],element_count]

            return result;
        }

    }

    def details_tabs(String objtype){
        Map tabellen=new HashMap()
        tabellen.put("Assets",[["TabId","Label"]["text","text"][["tab0","Overview"]["tab1","Current Situation"]["tab2","Original Situation"]]])
        return tabellen.get(objtype)
    }

    def details_divs(String objtype){
        Map tabellen=new HashMap()
        tabellen.put("Assetstab0",[["DivId","Label","class","type"]["text","text","text"][["div1","a1","span3","table"]["div2","a2","span3","table"]]])
        tabellen.put("Assetstab1",[["DivId","Label","class","type"]["text","text","text"][["div1","b1","span3","table"]["div2","b2","span3","table"]]])
        tabellen.put("Assetstab2",[["DivId","Label","class","type"]["text","text","text"][["div1","c1","span3","table"]["div2","c2","span3","table"]]])

        return tabellen.get(objtype)
    }

    def details_data(String objtype){
        redirect( action: "list",  params: [json: objtype])

    }

    def request() {

        def search, obj, ca, id,
            slurper = new JsonSlurper(),
            tz = slurper.parseText(params.json),
            roles = springSecurityService.getPrincipal().getAuthorities();

        if (!val_json()) render "Error"
        else {

            use( DeepFinder ) {
                search = tz.findDeep( 'controller-action' );
                id = tz.findDeep( 'id' );
            }
            if( id ) id = (id.tokenize(':')[1]).toInteger() ;
            if (!search) tz['controller-action']=params.myAction


            switch(get_controller_name(params.myAction)){


                case "updateReportsArchive":
                    tz = giveReportsArchive(tz);
                    break;
                case "lookupRequest":
                    tz = requestlookup(tz);
                    break;
                case "giveReportsArchive":
                    tz = giveReportsArchive(tz);
                    break
                case "giveInputReports":
                    tz = get_input_fields(tz);
                //Holger: GUI Daten für EditTab holen
                case "getEditData":
                    tz = getEditData(tz);
                    //Holger: Filterung bei Änderung eines Datensatzes
                    if( id > 0 ) tz = filterData(tz, roles, 3);
                    break;
                //Holger: Daten aus EditTab in Datenbank schreiben
                case "setEditData":
                    tz.remove( 'controller-action' );
                    tz = setEditData(tz);
                    break;
                //Holger: Datensatz löschen
                case "deleteData":
                    tz = deleteData(tz);
                    break;
                //Holger: Werte einer Pointer-Variable (z.B. Adressat @ Agenda) abrufen
                case "getPointerElements":
                    tz = getPointerElements(tz);
                    break;
                //Holger: Werte der Subtab-Tabelle Links abrufen
                case "getLinks":
                    tz = getLinks(tz);
                    break;
                //Holger: Werte der Subtab-Tabelle Dokumente abrufen
                case "getDocs":
                    tz = getDocs(tz);
                    break;
                //Holger: Werte der Subtab-Tabelle Konto abrufen
                case "getKonto":
                    tz = getKonto(tz);
                    break;
                //Holger: eMail versenden
                case "sendMail":
                    sendMyMailComplex();
                    render(text: [success:false] as JSON)
                    break;
                default:
                    use( DeepFinder ){
                        search=tz.findDeep( 'controller-action' );
                        obj = tz.findDeep( 'searched-object' );
                    }
                    if (!search) tz['controller-action'] = params.myAction;

                    tz = get_data(tz, roles);

                    if( search == "list" ) switch( obj ){
                            case "agenda":
                                tz = filterData( tz, roles, 1 );
                                break;
                            case "contacts":
                                tz = filterData( tz, roles, 2 );
                                break;
                    }

            }

            render tz as JSON;
        }
    }

    def val_json(){
        def valdater=true

    }

    def get_controller_name(String action){

        return action
    }

    private get_input_fields(HashMap tz)  {


        def rep_ids
        use( DeepFinder ) {
            rep_ids=tz.findDeep( 'search-request')



        }
        def slurper = new JsonSlurper()
        def sql=new Sql(dataSource)


        def headers_names=[]
        def row_types=[]
        def rows=[]
        HashMap srch = new HashMap()
        if (rep_ids==null){
            srch["header-names"]=["Report Id","Report Date","Bucket Id"]
            srch["row-types"]=["number","date","number"]
            srch["rows"] =[]


            render srch as JSON

        }

        if (rep_ids!=null && rep_ids.size>1){
            HashMap samekey = new HashMap()
            samekey["test"]=0
            for(def k =0;k<rep_ids.size;k++)
            {
                def a= sql.rows("select *  from reports_inputs where 1=1" +" and " +"report_id like" + "'"+rep_ids[k].toString()+"'" )
                for (def i=0 ;i<a.size();i++ ) {
                    def s=a[i]["input_label"].toString()
                    if(samekey[s]==null) {
                        samekey[s]=0  }




                }

                for (def i=0 ;i<a.size();i++ ) {

                    samekey[a[i]["input_label"]]=  samekey[a[i]["input_label"]]+1

                }
            }


            for(def i in samekey){
                if (i.value==rep_ids.size){
                    println(i.value)
                    headers_names.add(ReportsInputs.findByInputLabel(i.key).InputLabel)

                    row_types.add(ReportsInputs.findByInputLabel(i.key).InputType)
                    rows.add("")
                }
            }


            srch["header-names"]=headers_names
            srch["row-types"]=row_types
            srch["rows"] =rows

            render srch as JSON

        }



        if (rep_ids!=null && rep_ids.size==1){

            def a= sql.rows("select *  from reports_inputs where 1=1" +" and " +"report_id like" + "'"+rep_ids[0].toString()+ "'" )
            for (def i=0; i<a.size();i++){



                headers_names.add(a[i]["input_label"])
                row_types.add(a[i]["input_type"])
                rows.add("")

            }

            srch["header-names"]=headers_names
            srch["row-types"]=row_types
            srch["rows"] =[]
            render srch as JSON
        }




    }

    private giveReportsArchive(HashMap tz) {
        def sql=new Sql(dataSource)
        def inputs,reports
        use( DeepFinder ) {
            inputs=tz.findDeep('search-request')
            reports= tz.findDeep("report-type-id")

        }

        def reportsrows
        def resultsfields
        reportsrows=[]
        resultsfields=[]
        if(reports==null){
            reports=[]
            def b= sql.rows( "select external_id  from reports where 1=1" )
            for (def i in b)
            {
                reports.add(i["external_id"] )

            }
        }
        for (def i=0;i<reports.size;i++ ) {
            def a= sql.rows("select *  from reports_inputs where 1=1" +" and " +"report_id like" + "'"+reports[i].toString()+"'" )




            for (def j=0;j<a.size(); j++ )
            {

                reportsrows.add(a[j]["input_label"])
                resultsfields.add(a[j]["results_fields"])


            }
        }
        def select,from,where
        HashMap srch = new HashMap()
        where =" where 1=1 "
        from = " from reports_results "
        select = "select reports_results.id,"
        reportsrows= reportsrows.unique()
        resultsfields=resultsfields.unique()


        def  headers_names,row_types
        row_types=[]
        headers_names=[]
        headers_names.add("id")
        for (def k in reportsrows){

            headers_names.add(k)
            println(k)
            row_types.add(ReportsInputs.findAllByInputLabel(k).first().InputType)
        }
        def row_values

        for (def i =0;i<resultsfields.size(); i++ ) {


            if (i>0){select = select+ " , "}
            select = select + resultsfields[i].toString()


        }
        if(reports!=null)
        {
            where = where + " and ("
            for (def j=0;j<reports.size();j++){
                if (j >0){where = where + " or "}
                where =where   +"( report_id like " +"'"+reports[j]+"' )"

            }

            where = where + ")"
        }

        if(inputs!=null){
            for (def j=0;j<inputs.size();j++){
                where =where + " and " + ReportsInputs.findByInputLabel(inputs[j][0]).ResultsFields+" like " +"'"+inputs[j][1]+"'"

            }   }
        row_values=[]
        def sqlq =(select + from + where)
        srch["header-names"]=headers_names
        srch["row-types"] =row_types
        def a= sql.rows(sqlq)
        def tmprow
        for(def  i in a){
            tmprow=[]
            for(def j in i){
                tmprow.add(j.value)

            }
            row_values.add(tmprow)
        }

        srch["rows"] =row_values
        println(srch.toString())

        render srch as JSON

    }

    private requestlookup(HashMap tz) {

        //def build = new HashMap();
        def sql = new Sql(dataSource)
        def b = sql.rows("SELECT * FROM lookups order by lookup_code, lookup_value_id")
        def df = []
        for(def i=0;i<b.size();i++){
            df.add(b[i])
        }
        //build(Bookli)
        return df;
    }


    // Holger: edit & delete

    private getEditData(HashMap tz) {

        def sql = new Sql(dataSource),
            search, query, id;

        use( DeepFinder ) {
            search=tz.findDeep( 'searched-object' )
            id = tz.findDeep( 'id' )
        }
        id = id.tokenize(':')[1] ;
        if( id == null ) id = "0";


        //Felder holen
        query = "select element_header, element_format, element_attribute, element_table, pointer_rule, pointer_table, element_lookup from data_results where result_type like '" + search + "%' and element_table != 'gui_definitions' and result_type not like '%list' and element_attribute != 'id' order by order_key"
        def res = sql.rows(query)

        def myMap = []
        for( def i=0;i < res.size(); i++ ){
            myMap.add( res[i] )
        }

        //Daten holen
        def tabs = []
        def attr = []
        if( id != "0" ){
            for( def x in res ){
                tabs.add( x["element_table"] )
                attr.add( x["element_attribute"] )
            }
            tabs = tabs.unique();

            query = "select " + attr.join(", ") + " from " + tabs.join(", ") + " where id = " + id;
            res = sql.rows( query );

            for( def i=0;i < res[0].size(); i++ ){
                myMap[i]["dataset"] = res[0][i];
            }

        }

        return myMap;

    }

    private getPointerElements(HashMap tz){

        def sql = new Sql(dataSource)
        def table, attr, query

        use( DeepFinder ) {
            table = tz.findDeep( 'table' )
            attr = tz.findDeep( 'attr' )
        }

        query = "select id," + attr + " as attr from " + table;
        def a = sql.rows(query);

        return a;

    }

    private setEditData(HashMap tz) {

        def sql = new Sql(dataSource)

        def id = params.id,
            domain = params.domain,
            query, ret,
            slurper = new JsonSlurper();

        //update
        if( id != "0"  ){
            query = "update " + domain + " set "
            for( e in tz ){
                query = query + e.value["element_attribute"] + " = ";
                switch( slurper.parseText(e.value["element_format"])["row-type"] ){

                    case ["number","float","date","datetime","pointer"]:
                        if( e.value["dataset"] == '' ) query = query + "NULL," ;
                        else query = query + "'" +  e.value["dataset"] + "'," ;
                        break;
                    case ["lookup","lookupdomain"]:
                        if( e.value["dataset"].getClass().getName()!="java.lang.Integer" ) query = query + "NULL," ;
                        else query = query + "'" +  e.value["dataset"] + "'," ;
                        break;
                    default: //text, lookupmulti
                        query = query + "'" +  e.value["dataset"] + "'," ;
                }
            }
            query = query.reverse().drop(1).reverse()
            query = query + " where id = " + id

            Console.println( query );

            sql.executeUpdate(query);

            return [success:true];

        }
        //insert
        else {

            query = "insert into " + domain + "(version" ;
            for( e in tz ){
                query = query + "," +  e.value["element_attribute"] ;
            }
            query = query + ") values (0," ;
            for( e in tz ){
                switch( e.value["element_format"] ){

                    case ["number","float","date","datetime","pointer"]:
                        if( e.value["dataset"] == '' ) query = query + "NULL," ;
                        else query = query + "'" +  e.value["dataset"] + "'," ;
                        break;
                    case ["lookup","lookupdomain"]:
                        if( e.value["dataset"].getClass().getName()!="java.lang.Integer" ) query = query + "NULL," ;
                        else query = query + "'" +  e.value["dataset"] + "'," ;
                        break;
                    default: //text, lookupmulti
                        query = query + "'" +  e.value["dataset"] + "'," ;
                }

            }
            query = query.reverse().drop(1).reverse()
            query = query + ")"

            Console.println( query );

            ret = sql.executeInsert(query);

            return ret;
        }


    }

    private deleteData(HashMap tz){
        def sql = new Sql(dataSource)
        def query, id, domain, ret, domain_id

        use( DeepFinder ){
            id = tz.findDeep('id');
            domain = tz.findDeep('domain');
            domain_id = tz.findDeep('domain_id');
        }

        query = "delete from " + domain + " where id = " + id

        //Holger: Zuerst versuchen das Dokument zu löschen
        if( domain == "documents" ){
            try {
                def uuid = Documents.get( id ).UUID;
                def path = ws.getDocumentPath( uuid );
                ws.deleteDocument( path )
            } catch (Exception e){
                Console.println("Datei konnte nicht aus DMS geloescht werden!" + e.toString() );
            }
        }

        //Holger: Eintrag in DB löschen
        try {
            sql.execute( query );

            //Holger: Dem Objekt zugewiesene Links löschen
            if( domain_id != null){
                query = "delete from links where (klasse1="+domain_id+" and id1="+id+") or (klasse2="+domain_id+" and id2="+id+")";
                sql.execute( query );
            }

            return [success:true];
        } catch(Exception e){
            Console.println(e);
            return [event: e];
        }

    }

    //Holger: Funktion, die in jobs -> CheckRemindersJob aufgerufen wird
    public checkReminders(){

        def remList = Reminders.findAllByZeitpunktLessThanEqualsAndAktiv(new Date(), 1)
        if( remList.size > 0 ) triggerReminders( remList )

    }

    //Holger: Verwaltung der Reminder-Cases
    public triggerReminders( ArrayList remList ){

        for( rem in remList ) {

            if( rem.Typ == 1 ){ //eMail
                triggerRemindersEmail(rem)
            }
            deactReminder(rem)
        }
    }

    //Holger: Auslösung von eMail-Reminders
    public triggerRemindersEmail(Reminders rem){

        if( rem.Bezug == 3 ){ //Agenda

        def _id = rem.BezugId,
            _agenda = Agenda.findById( _id ),
            _report;
        ReportController _reportC = new ReportController();

        if( _agenda.Typ == 2 ){ //Rückzahlung

            def _mailto = _agenda.Adressat.email,
                _vertrag = _agenda.Beschreibung.tokenize(',')[0],
                _rate = _agenda.Beschreibung.tokenize(',')[1].tokenize('Rate ')[0];

            def _input =
                [
                    allgemein: [
                            vertrag : _vertrag
                    ],
                    tabelle_1: [
                            Datum: _agenda.Zeitpunkt,
                            Ereignis: "Rückzahlung",
                            Kontrollwert: _agenda.Kontrollwert,
                            Referenz: _agenda.Beschreibung,
                            Rate: _rate
                    ],
                    dazwischen: [
                            Rate: _rate,
                            Höhe: _agenda.Kontrollwert,
                            Datum: _agenda.Zeitpunkt
                    ],
                    tabelle_2:
                    [
                            [
                                Datum: (_agenda.Zeitpunkt - 3).toString(),
                                Ereignis:  "Kontaktaufnahme mit dem Darlehensnehmer, Erinnerung über die Zahlungsfälligkeit: Überweisung spätestens am 23.10.2014 12:00" + (_agenda.Zeitpunkt - 2).toString(),
                                Nachweis: "Bestätigung an TK, dass der Termin eingehalten wird.",
                                Hinweis: "Reden Sie mit dem Kunden. Sobald die Überweisung seinerseits bestätigt ist, vermerken Sie es im System.",
                            ],
                            [
                                Datum: (_agenda.Zeitpunkt - 2).toString(),
                                Ereignis: "Bestätigung an TK über erfolgte Zahlung",
                                Nachweis: "Bestätigung über Erhalt des Überweisungsbelegs",
                                Hinweis: "Sobald der Termin bestätigt ist, bekommen Sie eine gesonderte Nachricht mit dem entsprechenden Link.",
                            ]
                    ]
                ]

                _report = _reportC.getXhtmlReport(3, (_input as JSON).toString() );

                sendMyMail( _mailto, _report );

            }
        }

    }

    //Holger: eMail verschicken
    public sendMyMail( _mailto, _content ){

        def _from = 'no-reply@tandem-kredit.de';

        sendMail{
            to _mailto
            from _from
            subject "Tandem-Kredit Hinweis"
            body "Falls diese eMail nicht korrekt dargestellt wird, stellen Sie bitte sich, dass das Programm, mit dem Sie eMails lesen berechtigt ist, HTML Dokumente anzuzeigen."
            inline "reportHTML", "text/html", _content.getBytes()

        }

        Console.println( Calendar.getInstance().getTime().toString() + ": Mail verschickt: " + _mailto + ", Prototyp" );

        return true;

    }

    //Holger: Reminder nach dem Auslösen deaktiveren
    public deactReminder(Reminders x){

        def myRem = Reminders.get(x.id)
        myRem.Aktiv = 2
    }

    //Holger: Datei aus DMS herunterladen
    public download( ){

        def slurper = new JsonSlurper();
        def uuid;
        try {
            def tz = slurper.parseText(params.json);
            use( DeepFinder ){
                uuid = tz.findDeep( 'searched-link' );
            }
        } catch(Exception e) {
            uuid = params.json;
        }


        def fname = ws.getDocumentPath( uuid ).tokenize("/");
        fname = fname[ fname.size()-1 ];

        def input = ws.getContent( uuid );
        def output = response.getOutputStream();

        response.setContentType( "application/octet-stream" );
        response.setHeader( "Content-disposition", "attachment; filename=\"" + fname + "\"" );

        byte[] buffer = new byte[4096];
        int len;
        while ((len = input.read(buffer)) > 0) {
            output.write(buffer, 0, len);
        }

        output.flush();
        output.close();
        input.close();

    }

    //Holger: Datei ins DMS hochladen
    public upload() {

        try {

            InputStream inputStream = selectInputStream(request);
            def para = inputStream.ib.coyoteRequest.parameters.paramHashValues;
            String filename = getFilename( para["qqfile"] );
            String ending = getEnding( para["qqfile"] );
            def t = (new Date() ).format("_yyyyMMdd_HHmmss");
            String path = "/okm:root/" + grailsApplication.config.dms.location;
            String fname = filename + t + "." + ending;

            def ret = ws.createDocumentSimple( path + fname, inputStream );

            inputStream.close();

            //Falls Upload erfolgreich, Datensatz anlegen
            def doc = new Documents( fname, ret.getCreated().getTime(), ret.getUuid(), ret.getPath(), springSecurityService.principal.username, Math.round( ret.actualVersion.size / 1024 ) );

            //Falls Datensatz nicht angelegt werden kann, Dokument wieder löschen
            if( !doc.save() ){
                ws.deleteDocument( ret.getPath() );
                return render(text: [success:false] as JSON, contentType:'text/json')
            }

            //Falls Upload in Contacts Tab
            if( para["source"] != null ){
                if( para["source"][0] == "details" ){
                    def link = new Links( 1, doc.id.toInteger(), para["domain"][0].toInteger(), para["id"][0].toInteger() );
                    link.save();
                }
            }

            Console.println( "Upload erfolgreich: " + ret.getPath());


            return render(text: [success:true] as JSON, contentType:'text/json')

        } catch (FileUploadException e) {

            Console.println("Failed to upload file." + e.toString());
            return render(text: [success:false] as JSON, contentType:'text/json')

        } catch (ItemExistsException e) {
            Console.println("Failed to upload file." + e.toString());
            return render(text: [success:false] as JSON, contentType:'text/json')

        } catch (Exception e) {
            Console.println("Failed to upload file." + e.toString());
            return render(text: [success:false] as JSON, contentType:'text/json')
        }

    }
    private InputStream selectInputStream(HttpServletRequest request) {

        if (request instanceof MultipartHttpServletRequest) {

            //Holger: qqfile scheint im Quelltext des Plugins hart codiert zu sein
            MultipartFile uploadedFile = ((MultipartHttpServletRequest) request).getFile('qqfile')
            return uploadedFile.inputStream
        }
        return request.inputStream
    }
    private String getFilename( String s ){
        def t = s.tokenize('.');
        t.remove( t.size() - 1 );
        return t.join()
    }
    private String getEnding( String s){
        def t = s.tokenize('.');
        return t[ t.size()-1 ]
    }


    //Holger: Subtab Template Funktionen
    private getLinks( HashMap tz ){

        def sql = new Sql(dataSource)
        def query, id, klasse, ret

        use( DeepFinder ){
            id = tz.findDeep('id')
            klasse = tz.findDeep('klasse')
        }

        query = "select * from links where ( klasse1 = '" + klasse + "' and id1 = " + id + " ) or ( klasse2 = '" + klasse + "' and id2 = " + id + " )";

        ret = sql.rows( query );

        return ret;
    }

    private getDocs( HashMap tz ){

        def sql = new Sql(dataSource)
        def query, id, klasse, ret

        use( DeepFinder ){
            id = tz.findDeep('id')
            klasse = tz.findDeep('klasse')
        }

        query = "select * from documents where id in (select id2 from links where klasse1 = " + klasse + " and id1 = " + id + " union all select id1 from links where klasse2 = " + klasse + " and id2 = " + id + ")";

        ret = sql.rows( query );

        return ret;
    }

    private getKonto( HashMap tz ){

        def sql = new Sql(dataSource);
        def query, id, ret;

        use( DeepFinder ){
            id = tz.findDeep('id');
        }

        query = "SELECT concat( contacts.nachname, ', ', contacts.vorname) as name, agenda.zeitpunkt, agenda.typ, agenda.kontrollwert, agenda.beschreibung, cashflows.datum as zahlungsdatum, cashflows.betrag " +
                "FROM agenda left join cashflows on agenda.beschreibung = cashflows.referenz " +
                "left join contacts on agenda.kreditnehmer_id = contacts.id where agenda.kreditnehmer_id = " + id

        ret = sql.rows( query );

        return ret;
    }


    //Holger: Datenfilter
    private filterData( df, roles, mycase ){

        def user = springSecurityService.getPrincipal().username,
            userid = Contacts.findByUsername( user ).id;

        switch( mycase ){
            case 1: //Filterung Agenda
                if( !["ROLE_BETREUER","ROLE_MARKETING","ROLE_PARTNERBANK","ROLE_BETRIEB","ROLE_PMO"].disjoint(roles) ){
                    def add = df["header-names"].findIndexOf{ it=="Adressat"};
                    (df["rows"]).removeAll{
                        it[add] != userid;
                    }
                }
                break;
            case 2: //Filterung Kontakte

                if( !["ROLE_BETREUER"].disjoint(roles) ){
                    (df["rows"]).removeAll{
                        def id = df["header-names"].findIndexOf{ it=="ID"};
                        def con = Contacts.findById( it[id] );
                        def betreuer = con.betreuerId;
                        def secuser = SecUser.findByUsername( con.username );
                        def croles = [];
                        if( secuser != null ){
                            croles = secuser.getAuthorities();
                            croles = croles.toArray()[0].authority.tokenize(',');
                        };
                        con.username != user && betreuer != userid && croles.disjoint(["ROLE_CONTROLLING"])
                    }
                }
                break;

            case 3: //Filterung Lookup-Werte edit

                if( !["ROLE_BETREUER"].disjoint(roles) ){
                    df.removeAll{
                        ["Adressat","Kreditnehmer","Typ"].indexOf( it["element_header"] ) > -1;
                    }
                }
                break;

            default:
                Console.println("filter case default")
        }

        return df;

    }



    def renderReportsArchive() {
        render( template: "reportsArchive" )
    }

    def renderReportsInput(){
        render( template: "reportsInput")
    }

    def gmsg(){
        HashMap srch = new HashMap()

        if(params.loc != null) {
            srch["loc"]=params.loc
            srch["msg"]=g.message(code: params.msg, locale:Locale.forLanguageTag(params.loc), default: params.msg)
        }
        else
        {
            def currentLocale = RequestContextUtils.getLocale(request)
            srch["loc"]=currentLocale.language
            srch["msg"]=g.message(code: params.msg, default: params.msg)
        }

        render srch as JSON
    }
}