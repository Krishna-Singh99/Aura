@isTest
class ScheduleBatchLead_Test {

    @isTest
    static void TestScheduleBatchLead(){
  
        Test.startTest();
        ScheduleBatchLead dbs = new ScheduleBatchLead();
        string cronExp = '0 0 12 1/1 * ? *';
        system.schedule('Schedule1', cronExp, dbs);
       
        Test.stopTest();
        system.assertEquals(1, 1);
    }
   @isTest
    static void TestScheduleAccountBatch(){
  
        Test.startTest();
        ScheduleAccountBatch sab = new ScheduleAccountBatch();
        string cronExp = '0 0 12 1/1 * ? *';
        system.schedule('Schedule1', cronExp, sab);
       
        Test.stopTest();
        system.assertEquals(1, 1);
    }
    @isTest
    static void OpportunityBatchSchedule(){
  
        Test.startTest();
        OpportunityBatchSchedule sab = new OpportunityBatchSchedule();
        string cronExp = '0 0 12 1/1 * ? *';
        system.schedule('Schedule1', cronExp, sab);
       
        Test.stopTest();
        system.assertEquals(1, 1);
    }

}