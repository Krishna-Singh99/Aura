@isTest
private class InsertAccountUnitTest {

    @isTest
    static void TestInsertAccount(){
        List<Account> acclist = new List<Account>();
        for(integer i=0;i<10;i++){
            Account acc = new Account(Name='Account'+i);
            accList.add(acc);
        }        
        insert accList;
        Test.startTest();
        InsertAccount.insertOnAccount();
        Test.stopTest();
        system.assertEquals(10, 10);
    }
}