public with sharing class AccountController {
  public static List<Account> getAllActiveAccounts() {
    return [SELECT Id,Name,Active__c FROM Account WHERE Active__c = 'Yes'];
  }
    @AuraEnabled(cacheable=true)
        public static List<account>  getAccountList(){
        return [SELECT Id, Name,Phone,Industry FROM Account WITH SECURITY_ENFORCED LIMIT 10];
    }
}