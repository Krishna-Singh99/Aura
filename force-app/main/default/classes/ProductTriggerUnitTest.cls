@isTest
private class ProductTriggerUnitTest {
    
    @isTest
    static void TestProductTrigger(){
      List<Product2> demoProduct= OpportunityUtilityClass.TestChangeInOpportunity();
        Test.startTest();
        ProductTrigger.productCreation(demoProduct);
        Test.stopTest();
    }
}