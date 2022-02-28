@isTest
private class UsingMapUnitTest {

    @isTest
    static void TestUsingMap(){
        Account acc = new Account(Name='Acc',BillingStreet='avvdhd');
        insert acc;
        Contact con = new Contact(FirstName='The',LastName='Lost',Accountid=acc.id);
        insert con;
        Test.startTest();
        UsingMap.mapForAccount();
        Test.stopTest();
    }
}