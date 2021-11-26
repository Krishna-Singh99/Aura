public class OpportunityEntry {
    public static void CloneOpp(){
        opportunity opp = new opportunity();
        opp = [select id, Name, CloseDate, StageName from opportunity limit 1];
        
        opportunity cloneOpp = new opportunity();
        
        cloneOpp = opp.clone(false,false,false,false);
        
        cloneOpp.Name = opp.Name+'Clone';
        cloneOpp.CloseDate = opp.CloseDate.addDays(30);
        
        insert cloneOpp;
        
        system.debug('Done '+ cloneOpp);
    }
}