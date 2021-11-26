@isTest
private class MapQueryUnittest {

    @isTest
    static void TestMapQuery(){
        Account acc= new Account(Name='Tst149');
        insert acc;
        contact con = new contact(LastName='jj',Accountid=acc.id);
        insert con;
        Test.startTest();
        MapQuery.mapq();
        Test.stopTest();
    }
}