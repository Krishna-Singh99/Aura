@isTest
Private class ReverseAccountUnitTest {
    
    @isTest
    static void TestReverseAccount(){
        Account acc = new Account(Name='Acc');
        insert acc;
        Test.startTest();
        ReverseAccount.reverse_Account();
        ReverseAccount.Reverse('String');
        Test.stopTest();
    }

}