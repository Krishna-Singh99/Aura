public with sharing class AccountControllerforAura {
  @AuraEnabled
  public static List<Account> fetchAccount() {
    try {
      List<Account> accList = [
        SELECT Name, Phone
        FROM Account
        WHERE Phone != NULL
        LIMIT 200
      ];
      return accList;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
  @AuraEnabled
  public static List<Account> sortByApex(List<Account> acc) {
    try {
      acc.sort();
      return acc;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}