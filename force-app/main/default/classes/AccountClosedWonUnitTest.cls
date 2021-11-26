@isTest
private class AccountClosedWonUnitTest {

    @isTest
    static void TestAccountClosedWon(){
        Account acc = new Account(
        Name = 'Acc'
        );
        insert acc;
        Opportunity opp = new Opportunity(
        Name = 'Opp', 
        stagename = 'Closed Won', 
         CloseDate = date.today(),
        Accountid = acc.id
        );
        insert opp;
        Test.startTest();
        AccountClosedWon.accWon();
        Test.stopTest();
    }
     @isTest
    static void TestAccountClosedWonNegative(){
        Test.startTest();
        AccountClosedWon.accWon();
        Test.stopTest();
    }
}