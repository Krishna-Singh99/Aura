public class Summary_Business_Class {

    public List<Account> accList{get;set;}
    
    public Summary_Business_Class(){
        Integer i=1;
         accList = [SELECT ID,NAME,Serial_Number__c,Number_of_LineItems__c,Count__c FROM Account WHERE name LIKE '%A%' limit 50];
        for(Account acc: acclist){
            acc.Serial_Number__c = i++;
        }
    }
        
        
}