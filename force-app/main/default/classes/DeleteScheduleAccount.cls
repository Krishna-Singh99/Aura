global class DeleteScheduleAccount implements Schedulable{
    public void Execute(SchedulableContext sc){
        BatchAccounts dba = new BatchAccounts();
        Database.executeBatch(dba,2);
    }
}