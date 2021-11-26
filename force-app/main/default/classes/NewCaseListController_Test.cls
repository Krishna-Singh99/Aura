@isTest
 class NewCaseListController_Test {

     @isTest
     static void TestNewCaseListController(){
         List<Case> cs = new List<Case>();
         cs.add(new Case(SuppliedEmail='abc@gmail.com'));
         insert cs;
         Test.startTest();
         NewCaseListController.getNewCases(cs);
         Test.stopTest();     
     }
}