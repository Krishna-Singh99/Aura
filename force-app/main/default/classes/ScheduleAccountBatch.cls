Global class ScheduleAccountBatch implements Schedulable {
    Global void execute(SchedulableContext sc){
        AccountBatch accBatch = new AccountBatch();
        database.executeBatch(accBatch, 50);
    }

}