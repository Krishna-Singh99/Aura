public class AccountAuraData {
    @AuraEnabled
    public static List<Account> getAccountRecord(){
        List<Account> accList=  new List<Account>([Select id,Name,Phone,Type from Account where Type != null LIMIT  100]);
        return acclist;
    }
     @AuraEnabled
    public static List<Contact> fetchContact(String accId){
        List<Contact> showCon = [SELECT AccountId,LastName FROM Contact WHERE AccountId =: accId];
        return showCon;
    }
    @AuraEnabled
    public static List<Opportunity> fetchOpportunity(String oppId){
        List<Opportunity> showCon = [SELECT AccountId ,Name FROM Opportunity WHERE AccountId  =: oppId];
        return showCon;
    }

}