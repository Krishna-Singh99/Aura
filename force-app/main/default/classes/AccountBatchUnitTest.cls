@isTest
private class AccountBatchUnitTest {
    @isTest
    static void TestAccountBatch(){
        Account acc = new Account(Name='Acc' , count__c = 0);
        insert acc;
        Contact con = new Contact(LastName='Munna',Accountid=acc.Id);
        Test.startTest();
        AccountBatch dbc  = new AccountBatch();
        Database.executeBatch(dbc);
        Test.stopTest();
    }

}