public with sharing class DeleteScheduleAccountBatch {
public static void deleteScheduleAccountBatch() {
    list<cronJobDetail> cjd = [Select id from cronJobDetail where name like '%AccountBatch%'];
        list<cronTrigger> ct = [Select id from crontrigger where cronJobDetailId =: cjd];
        for(cronTrigger ctid : ct){
             if(ctid != Null){
             system.abortJob(ctid.id);
        }
       
    }
}
}