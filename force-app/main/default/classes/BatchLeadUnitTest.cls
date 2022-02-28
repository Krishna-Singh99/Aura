@isTest
private class BatchLeadUnitTest {

    @isTest
    static void TestBatchLead(){
        Lead ld = new Lead(LAstName='TestLead',Company='Salesforce');
         Test.startTest();
      BatchLead dbc = new BatchLead();
        Database.executeBatch(dbc);
    Test.stopTest();
    }
   
}