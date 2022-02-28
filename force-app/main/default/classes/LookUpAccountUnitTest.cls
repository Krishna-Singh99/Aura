@isTest
private class LookUpAccountUnitTest {

    @isTest
    static void TestLookUpAccount(){   
       List<Account> acclist = new List<Account>();
        Account acc = new Account(Name='Employee',NumberOfEmployees=12,count__c=3);
        accList.add(acc);
        insert accList;
        Test.startTest();
        LookUpAccount.createContactLookup();
        Test.stopTest();
        
    }
}