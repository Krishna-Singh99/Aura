public class WorkingAccountsInAsia {
    public static void asiaAccount(){
        list<Opportunity> opp = new  list<Opportunity>();
        opp = [Select id from Opportunity where Account.multiPickList__c includes ('ASIA')];
        list<OpportunityLineItem> oli = new  list<OpportunityLineItem>();
        oli = [Select Quantity from OpportunityLineItem where OpportunityId In : opp ];
        for(OpportunityLineItem waia : oli){
            system.debug('<<'+waia.Quantity);
        }
    }
}