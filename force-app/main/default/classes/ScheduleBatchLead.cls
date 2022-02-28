public with sharing class ScheduleBatchLead implements Schedulable{
    public void execute(SchedulableContext sc){
        BatchLead blead = new BatchLead();
        database.executeBatch(blead);
    }
    }