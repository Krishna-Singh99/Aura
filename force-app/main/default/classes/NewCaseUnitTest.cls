@isTest
private class NewCaseUnitTest {
    
    @isTest
    static void TestNewCase(){
        Account acc = new Account(Name='acc');
        insert acc;
        Contact con = new Contact(LastName='con',Accountid = acc.id);
        insert con;
     //  Case cs = new Case(Description ='Abc',Accountid = acc.Id,Contactid = con.id,SuppliedEmail='abcgmail.com');
        //nsert cs;
        Test.startTest();
        NewCase.addNewCase();
        Test.stopTest();
    }
}