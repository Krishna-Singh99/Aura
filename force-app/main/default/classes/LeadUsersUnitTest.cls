@isTest
private class LeadUsersUnitTest {

    @isTest
    static void TestLeadUsers(){
        Test.startTest();
        LeadUsers.fetchLeadUser();
        Test.stopTest();
    }
}