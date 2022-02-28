Global class OpportunityBatchSchedule implements Schedulable{
    public void execute(SchedulableContext sc){
        OpportunityBatch db = new OpportunityBatch();
        database.executeBatch(db,2);
    }
}