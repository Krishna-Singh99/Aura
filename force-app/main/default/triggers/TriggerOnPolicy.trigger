trigger TriggerOnPolicy on Policy__c (before update) {
    if(trigger.isBefore){
        if(trigger.isUpdate){
            PolicyTrigger.policyTrig(trigger.new);
        }
    }

}