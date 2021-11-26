public class PolicyTrigger {
    public static void policyTrig(list<Policy__c> polList){
        if(polList!=null && !polList.isEmpty()){
        try{
           
            set<Id> setId = new set<Id>();
            for(Policy__c poc : polList){
                setId.add(poc.opportunity_name__c);
            }
            integer i=0;
            list<Opportunity> fetchOpp = [Select id,policy_number__c,stagename from Opportunity where id in : setId];
             set<Id> setOppId = new set<Id>();
            for(Opportunity pcc: fetchOpp){
                setOppId.add(pcc.id);
            }
            list<Opportunity> updateOpp = new  list<Opportunity>();
            for(Policy__c pol : polList){
                for(Opportunity oldOpp : fetchOpp){
                     Opportunity OppDetails = new Opportunity();
              
                if(pol.policy_number__c == oldOpp.policy_number__c){
                    oldOpp.StageName = 'Closed Won';
                   
                    if(pol.parent_policy__c!=NuLL){
                    pol.Renew_Policy__c = True;
                    pol.opportunity_name__c = oldOpp.Id;
                   
                }
                     updateOpp.add(oldOpp);
               }
                
                } 
            }
            update updateOpp;
        }catch(Exception es){
            system.debug(es.getLineNumber());
           system.debug(es.getMessage());
           system.debug(es.getCause());
        }
        }
    }
}