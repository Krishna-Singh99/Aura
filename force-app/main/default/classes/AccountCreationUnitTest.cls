@isTest
Private class AccountCreationUnitTest {

     @isTest
    static void AccountxtreationTest(){
    Account acc = new Account(Name = 'Name',AccountNumber='101',Rating='Hot',Fax='8689',Description='aqmavsxch');
      insert acc;
        Test.startTest();
        AccountCreation.createAccount();
        Test.stopTest();
    }
    
    @isTest
    static void TestTriggerHandlerContact(){
        Account acc = new Account(Name='Krishn',NumberOfEmployees = 5);
        List<Contact> con = new List<Contact>();
        con.add(new Contact(LastName = 'Contact',Accountid=acc.Id));
        Test.startTest();
        TriggerHandlerContact.removeContactName(con);
        Test.stopTest();
    }
}