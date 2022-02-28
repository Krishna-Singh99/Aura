@isTest
private class AccountControllerUnitTest {

    @isTest
    static void TestAccountController(){
        Account acc = new Account(
        Name= ' Account',
        Active__c = 'Yes'
        );
        Test.startTest();
        AccountController.getAllActiveAccounts();
    }
}