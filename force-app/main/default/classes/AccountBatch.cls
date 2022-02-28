Global class AccountBatch implements Database.Batchable<sObject>{
    Global Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([Select id,count__c from Account ]);
    }
    
    Global void execute(Database.BatchableContext dbc, list<Account> accList){
        Set<Id> acId = new Set<Id>();
        for(Account ac:accList){
            acId.add(ac.Id);
        }
        List<contact> fetchConList = [Select Accountid from Contact where accountid in : acId];
        System.debug(fetchConList);
        Map<Id,Integer> IdVsCountMap = new Map<Id,Integer>();
        for(contact cont: fetchConList){
            if(IdVsCountMap.containsKey(cont.AccountId)){
                IdVsCountMap.put(cont.AccountId,IdVsCountMap.get(cont.AccountId)+1);
            }else{
                IdVsCountMap.put(cont.AccountId,1);
            }
        }
        List<Account> acc = new  List<Account>();
        
       for(Account aclist : accList){
           if(IdVsCountMap.containsKey(aclist.Id)){
               acList.Count__c = IdVsCountMap.get(aclist.Id);
               acc.add(aclist);
           }
    }
        update acc;
    }
    Global void Finish(Database.BatchableContext dbc){
        System.debug('Updation successfull');
    }
}