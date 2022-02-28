@isTest
private class BatchAccountsUnitTest {

    @isTest
    static void TestBatchAccounts(){
        Account acc = new Account(Name='Account');
        insert acc;
        Test.startTest();
        BatchAccounts dbc = new BatchAccounts();
        Database.executeBatch(dbc);
        List<Account> acclist = [Select id from account ];
                Test.stopTest();
        system.assertEquals(1, acclist.size());
    }
}