@isTest
private class CreateNewCaseUnitTest {
    @TestSetup
    static void setup(){    
        Account acc = new Account(Name='Tst149');
        insert acc;
        Contact con = new Contact(LastName='ContactAccount');
        insert con;
    }
    
    
    @isTest
    static void TestCreateNewCase(){  
        Test.startTest();
        CreateNewCase.addNewCase();
        List<case> cs = [Select id from case];
        Test.stopTest();
        system.assertEquals(5,cs.size());
    }
}