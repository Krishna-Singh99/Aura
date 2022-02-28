@isTest
private class CurrentSalesUnitTest {
  @isTest
  static void TestCurrentSales() {
    Test.startTest();
    CurrentSales.displayCurrSF();
    Test.stopTest();
  }
     @isTest
  static void TestCurrentSalesNeg() {
            user usr = new user(Email='abc@gmail.com',LastName = 'Krishna',
     Username = 'puser000@amamama.com' + System.currentTimeMillis(),
     CompanyName = 'TEST',
     Title = 'title',
     Alias = 'alias',
     TimeZoneSidKey = 'America/Los_Angeles',
     EmailEncodingKey = 'UTF-8',
     LanguageLocaleKey = 'en_US',
     LocaleSidKey = 'en_US',UserPermissionsOfflineUser = False,
     UserPermissionsMarketingUser = true,UserPermissionsCallCenterAutoLogin = False,ProfileId=UserInfo.getProfileId());
      insert usr;
    Test.startTest();
    CurrentSales.displayCurrSF();
    Test.stopTest();
  }
}