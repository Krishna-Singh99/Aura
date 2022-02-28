public class LeadUsers {
    public static void fetchLeadUser(){
        try{
        date dd = date.newInstance(2019, 02, 01);
 AggregateResult[] groupedResults  = [SELECT count(Id)agr,  CreatedById FROM Lead Where createddate>: dd group by createdbyid];
        System.debug(groupedResults[0].get('agr'));
        System.debug(groupedResults[3].get('expr2'));
        }catch(Exception e){
            system.debug(e.getCause());
            system.debug(e.getLineNumber());
        }
    }
}