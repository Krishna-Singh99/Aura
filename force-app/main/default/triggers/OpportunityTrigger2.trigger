trigger OpportunityTrigger2 on Opportunity (after update, before update) {
    if(trigger.isafter && trigger.isupdate){
        OpportunityTrigger.oppClosed(trigger.new);
        }
        if(trigger.isAfter ){
        if(trigger.isInsert){
            OpportunityTrigger.oppClosed(trigger.new);
        }
        if(trigger.isUpdate){
        OpportunityTrigger.oppWonSold(trigger.new); 
                }            
    }
    if(trigger.isbefore ){
        if(trigger.isUpdate){
           // ChangeInOpportunity.Chngopp(trigger.new);
        }
    }
    }