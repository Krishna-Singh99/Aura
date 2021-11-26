trigger TriggerOnOpportunityLineItem2 on OpportunityLineItem (After insert, before update) {
    if(trigger.isAfter){
        if(trigger.isInsert){
           // Accountfortrigger.numberOfLineItems(trigger.new);
        }
    }
     if(trigger.isbefore){
        if(trigger.isUpdate){
          //  Accountfortrigger.numberOfLineItems(trigger.old);
           OpportunityTrigger.numberOfLineItems(trigger.new);
        }
    }
}