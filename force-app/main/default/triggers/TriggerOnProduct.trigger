trigger TriggerOnProduct on Product2 (after insert) {
 if(Trigger.isAfter){
        if(Trigger.IsInsert){
            ProductTrigger.productCreation(trigger.new);
        }
 }
 
}