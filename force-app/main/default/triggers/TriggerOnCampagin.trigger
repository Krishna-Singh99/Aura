trigger TriggerOnCampagin on Campaign (After insert,before update) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            TriggeronCampaignhit.onCampaign(trigger.new);
        }
    }
      if(trigger.isbefore){
        if(trigger.isUpdate){
            TriggeronCampaignhit.onCampaign(trigger.new);
        }
    }
}