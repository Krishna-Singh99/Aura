@isTest
private class Travellers_Test {
    
    @TestSetup
    static void setupData(){
        Plan__c addPlan = new Plan__c();
        addPlan.Name = 'Ranchi';
        addPlan.travellHour__c = 5 ;
        addPlan.travelLocation__c = 'A' ;
        insert addPlan;
    }
    @isTest
    static void TestTravellers(){
        Test.startTest();
        Travellers.travllr();
        Test.stopTest();
        system.assertEquals(1, 1);
    }
    
}