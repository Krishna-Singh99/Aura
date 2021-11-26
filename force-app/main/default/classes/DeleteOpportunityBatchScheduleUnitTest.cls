@isTest
Private class DeleteOpportunityBatchScheduleUnitTest {

    @isTest
    static void TestDeleteOpportunityBatchSchedule(){
        
        Test.startTest();
        DeleteOpportunityBatchSchedule.deleteOppBatch();
        Test.stopTest();
    }
        @isTest
    static void Test_DeleteScheduleAccountBatch(){
        
        Test.startTest();
        DeleteScheduleAccountBatch.deleteScheduleAccountBatch();
        Test.stopTest();
    }
       @isTest
    static void Test_DeleteScheduleAccountAbortJob(){
        
        Test.startTest();
        DeleteScheduleAccountAbortJob.deleteschedule();
        Test.stopTest();
    }
     @isTest
    static void Test_deleteschedule(){
        Test.startTest();
       DeleteScheduleAccount dbc  = new DeleteScheduleAccount();
           string tm = '0 0 1 1/1 * ? *';
    system.schedule('Extra',tm,dbc);
        Test.stopTest();
    }
   
}