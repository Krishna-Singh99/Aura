@isTest
private class LeadProcessorTest {

    @istest
    private static void testBatchClass(){
        
        //Load test Data
        list<Lead> leads = new List<Lead>();
        for(Integer i=0;i<200;i++){
            leads.add(new Lead(LastName = 'Connock', Company='Salesforce'));
        }
        insert leads;
        
        //perform the test
        
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        id batchid = Database.executeBatch(lp,200);
        Test.stopTest();
        
        //checkthe result
        
        List<lead> updatedLeads = [Select id from lead where LeadSource= 'Dreamforce'];
        System.assertEquals(200,updatedLeads.size(),'Error: Atleast 1 lead record not updated correctly');
    }
}