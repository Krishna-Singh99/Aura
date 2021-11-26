public class Opportunity_create {
    public static void createOp(){
        list<Opportunity> opt= new list<Opportunity>();
        for(integer i=0;i<20;i++){
            //Closed Date, Stage and Opportyunity Name.
            Opportunity opp = new Opportunity();
           opp.CloseDate=System.today().addYears(-2);
            opp.StageName='Closed Won';
            opp.Name='Lead';
            opt.add(opp);
        }
        insert opt;
        system.debug(opt);
    }
}