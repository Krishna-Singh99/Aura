public class DeleteOpportunityBatchSchedule {
    public static void deleteOppBatch(){
        cronjobDetail cjd = [Select id from cronjobDetail where name like '%OpportunityScheduler%' limit 10];
        if(cjd != null){
            crontrigger ct = [select id from crontrigger where cronJobDetailId =: cjd.id];
            system.abortJob(ct.id);
        }
    }
}