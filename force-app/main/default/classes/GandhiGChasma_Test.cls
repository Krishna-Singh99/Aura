@isTest
private class GandhiGChasma_Test {

    @isTest
    static void TestGandhiGChasma(){
        OpportunityUtilityClass.TestChangeInOpportunity();
        Test.startTest();
        GandhiGChasma.gandhiGChasma();
        Test.stopTest();
    }
       @isTest
    static void Test_OpportunityEntry(){
        OpportunityUtilityClass.TestChangeInOpportunity();
        Test.startTest();
       OpportunityEntry.CloneOpp();
        Test.stopTest();
    }
}