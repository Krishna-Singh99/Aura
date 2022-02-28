public with sharing class ContactControllerForAura {
  @AuraEnabled
  public static Contact getContact() {
    try {
      return [SELECT Id, FirstName, LastName FROM Contact LIMIT 1];
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
  @AuraEnabled
  public static void setContact(String conName, String email, String accId) {
    system.debug(conName);
    System.debug('Hello');
    system.debug(accId);
    try {
      Contact con = new Contact(
        LastName = conName,
        Email = email,
        AccountId = accId
      );
      insert con;
      System.debug('conList>>>>>' + con);
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}