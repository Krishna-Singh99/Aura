public class FetchIdvsIdvsvsAccount {

    public static void detchAccountRelatedCOntactAndOpportunity(){
        
Map<Id,Account> oppidvsAccountmap = new Map<Id,Account>();
Map<Id,Map<Id,Account>> idVsIdVsAccountmap = new Map<Id,Map<Id,Account>>();
List<Account> accList = [Select id,name from account limit 10];
List<Contact> conList = [Select name from Contact where accountid in : accList limit 10];
Map<Id,Id> contactIdvsOppotunity = new Map<Id,Id>();

List<OpportunityContactRole> oppList = [SELECT Id, OpportunityId, ContactId,Contact.Accountid, Role FROM OpportunityContactRole where Contact.Accountid in : accList limit 10];
Map<Id,Account> IdvsAccountmap = new Map<Id,Account>(accList);
for(OpportunityContactRole opp : oppList){
    contactIdvsOppotunity.put(opp.OpportunityId,opp.ContactId);
}
for(OpportunityContactRole key : oppList){
    if(IdvsAccountmap.containsKey(key.Contact.Accountid)){
        oppidvsAccountmap.put(key.OpportunityId,IdvsAccountmap.get(key.Contact.Accountid));
    }
}
for(OpportunityContactRole key : oppList){
    if(oppidvsAccountmap.containsKey(key.OpportunityId)){
        idVsIdVsAccountmap.put(key.ContactId,oppidvsAccountmap);
    }
}


system.debug('idVsIdVsAccountmap'+idVsIdVsAccountmap);
    }
}