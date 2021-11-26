Global class BatchAccounts implements Database.Batchable<sobject>,  Database.Stateful{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id from Account  where CreatedDate = LAST_N_DAYS:10 ]);
    }
    public void execute(Database.BatchableContext bc, List<Account> accList){
        try{
        if(accList.size() > 0){
            delete accList;
        }
        }catch(Exception e){
            system.debug(e.getCause());
            system.debug(e.getLineNumber());
            system.debug(e.getMessage());
        }
    }
    
    public void finish (Database.BatchableContext bc){
        System.debug('Done');
    }
}