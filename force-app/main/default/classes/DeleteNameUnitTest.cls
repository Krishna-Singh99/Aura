@isTest
private class DeleteNameUnitTest {

    @isTest
    static void TestDeleteName(){
        Account acc = new Account(Name='Akash');
        insert acc;
        Contact con = new Contact(LastName='Abhishek', Accountid = acc.id);
        insert con;
        Test.startTest();
        DeleteName.delname();
        Test.stopTest();
    }
}