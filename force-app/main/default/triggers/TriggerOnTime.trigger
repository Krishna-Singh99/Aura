trigger TriggerOnTime on Time__c (After undelete, after delete,After insert) {
    if(trigger.isAfter){
        if(trigger.isDelete){
            TriggerOnTimeAccRestore.timeAccountRestore(trigger.old);
        }
        
    }
}