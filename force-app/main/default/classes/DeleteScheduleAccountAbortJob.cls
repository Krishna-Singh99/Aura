public class DeleteScheduleAccountAbortJob {
    public static void deleteschedule(){
      cronJobDetail cjd = [Select id from cronJobDetail where name = 'Delete Account' limit 1];
        if(cjd != Null){
            cronTrigger ct = [Select id from crontrigger where cronJobDetailId =: cjd.id];
            system.abortJob(ct.id);
        }
       
    }
}