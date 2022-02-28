@isTest
private class AccountfortriggerUnitTest {

    @isTest
    static void TestAccountfortrigger(){
        Account acc = new Account(Name = 'Acc', NumberOfEmployees = 5 );
        insert acc;
        Contact con = new Contact(LastName = acc.Name,Accountid = acc.id);
        Test.startTest();
        insert con;
        Test.stopTest();
    }
    
    @isTest
    static void TestAccountfortrigger2(){
     List<Account> accts = new List<Account>();
        
        for(Integer i=0;i<5;i++) {
            Account a = new Account(Name='TestAccount' + i,NumberOfEmployees=5,count__c=7);
            accts.add(a);
        }
        insert accts;
        Test.startTest();
        Accountfortrigger.accn(accts);
        Test.stopTest();
    }
}