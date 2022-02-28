@isTest
 class Opportunity_createUnit_Test {

     @isTest
     static void TestOpportunity_create(){
         Test.startTest();
         Opportunity_create.createOp();
         Test.stopTest();
     }
     @isTest
     static void Testopportunity_Update(){
         OpportunityUtilityClass.TestChangeInOpportunity();
      
       Test.startTest();
         opportunity_Update.oopUp();
         Test.stopTest();
     }
}