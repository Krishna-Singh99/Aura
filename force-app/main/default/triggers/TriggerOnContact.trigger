trigger TriggerOnContact on Contact (After Insert,before insert,before Update, After Update,after Undelete) {
if(trigger.isAfter){
     if(trigger.isUndelete){
         
         TriggerHandlerContact.contactUndelete(trigger.new);
           TriggerHandlerContact.contactUndeleteUsingMap(trigger.newmap);
        }
        if(trigger.isInsert){
         TriggerHandlerContact.updateAccountName(Trigger.new);
          TriggerOnMail.fillConMailAsAccShipping(trigger.new);
            TriggerHandlerContact.sendDetailsThroughMail(trigger.new);
            
        }
    
    }
    
    if(trigger.isBefore){
        if(trigger.isDelete){
          //  TriggerHandlerContact.removeContactName(Trigger.Old);
        }
    }
}