@isTest
 class OpportunityBatch_Test {

     @TestSetup
     static void setupdata(){
         OpportunityUtilityClass.TestChangeInOpportunity();
     } 
     
     @isTest
     static void TestOpportunityBatch(){
         Test.startTest();
         OpportunityBatch dbc = new OpportunityBatch();
         Database.executeBatch(dbc);
         Test.stopTest();
     }
}