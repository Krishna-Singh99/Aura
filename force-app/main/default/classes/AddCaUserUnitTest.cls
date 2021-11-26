@isTest
private class AddCaUserUnitTest {

    @isTest 
   static void TestCaUser(){
        Ca_User__c causr = new Ca_User__c(name='This',  Joining_Date__c = date.today(),Email__c = 'abcd@gmail.com');
        insert causr;
        Test.startTest();
            AddCaUser.addUser();
        Test.stopTest();
    }
    
    @isTest
    static void TestNegative(){
         Ca_User__c causr = new Ca_User__c(name='This',  Joining_Date__c = date.today().addDays(1),Email__c = 'abcd@gmail.com');
        insert causr;
  Test.startTest();
            AddCaUser.addUser();
        Test.stopTest();
    }
}