trigger TriggeronAccountTriggerforRevision on Account (before insert,before update, after undelete,before delete) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            AccountTriggerforRevision.insertAccount(trigger.new);
        }
        if(trigger.isUpdate){
         AccountTriggerforRevision.updateAccount(trigger.new);            
        }
        if(trigger.isDelete){
            
            AccountTriggerforRevision.deleteAccount(trigger.new);
        }
    }
    if(trigger.isAfter && trigger.isunDelete){
        AccountTriggerforRevision.undeleteAccount(trigger.new);
    }
}