public with sharing class getRecordDataController {
  @AuraEnabled(cacheable=true)
  public static List<Account> getAccounts() {
    return [SELECT Id, Name, Phone, Active__c FROM Account WHERE Phone != NULL];
  }
  @AuraEnabled(cacheable=true)
  public static List<Contact> getContacts() {
    return [SELECT Id, LastName FROM Contact LIMIT 100];
  }
    @AuraEnabled(cacheable=true)
  public static List<wrapperClass> getContactsofAccount(List<String> accId) {
     System.debug('accId >>>>> '+accId);
      List<wrapperClass> wrapperList = new List<wrapperClass>();
     List<Contact> conList = [SELECT Id,FirstName, LastName,Account.Name,AccountId FROM Contact WHERE AccountId in :accId];
     
      for(Contact con : conList)
      {
           wrapperClass wc = new wrapperClass();
           wc.accountId = con.AccountId;
          wc.FirstName = con.FirstName;
          wc.LastName = con.LastName;
          wc.accountName = con.Account.Name;
          wc.ContactData = '';
          wrapperList.add(wc);
      }
     system.debug('line 25>>>'+ wrapperList);
    return wrapperList;
  }
  @AuraEnabled(cacheable=true)
  public static List<wrapperOpportunityClass> getOpportunityofAccount(List<String> accId) {
       List<wrapperOpportunityClass> wrapperList = new List<wrapperOpportunityClass>();
     List<Opportunity> oppList = [SELECT Id,Name, Stagename,Account.Name FROM Opportunity WHERE AccountId in:accId];   
       for(Opportunity opp : oppList)
      {
           wrapperOpportunityClass wc = new wrapperOpportunityClass();
           wc.OpportunityId = opp.Id;
          wc.Name = opp.Name;
          wc.Stagename = opp.Stagename;
          wc.AccountName = opp.Account.Name;
          wrapperList.add(wc);
      }
    return wrapperList;
  }
     @AuraEnabled(cacheable=true)
  public static List<OpportunityLineItem> getProductofAccount(List<String> oppId) {
      system.debug('oppId>>>'+oppId);
     List<OpportunityLineItem> oppList = [SELECT Id, Quantity, TotalPrice, UnitPrice,Product2Id FROM OpportunityLineItem WHERE OpportunityId =:oppId];   
    system.debug('oppList>>>'+oppList);
      return oppList;
  }
     public class wrapperClass{
         @AuraEnabled public String accountName {get;set;}
        @AuraEnabled public String accountId {get;set;}
             @AuraEnabled public String FirstName {get;set;}
                  @AuraEnabled public String LastName {get;set;}
          @AuraEnabled public String ContactData {get;set;}
    }
     public class wrapperOpportunityClass{
         @AuraEnabled public String OpportunityId {get;set;}
        @AuraEnabled public String Name {get;set;}
             @AuraEnabled public String Stagename {get;set;}
                  @AuraEnabled public String AccountName {get;set;}
    }
}