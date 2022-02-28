public class TriggeronCampaignhit {
    public static void onCampaign(list<Campaign> cmpList){
        if(cmpList!=null && !cmpList.isEmpty()){
            try{
                list<Opportunity> cmp = [Select Id,CampaignId,TotalOpportunityQuantity from Opportunity where CampaignId!=null and  CampaignId in :cmpList];
                system.debug('id>>'+cmp.get(0).id+'campaignid>>'+cmp.get(0).campaignid+'TotalOpportunityQuantity'+cmp.get(0).TotalOpportunityQuantity);
                for(Campaign com : cmpList){
                    if(com.Status == 'Completed'){
                        for(Opportunity opp : cmp){
                            if(opp.TotalOpportunityQuantity > 0){
                                opp.Stagename = 'Closed Won';
                                
                            }else{
                                opp.Stagename = 'Closed lost';
                            }
                            
                        }
                        
                    }
                    update cmp;
                }
            }Catch(Exception ex){
                system.debug('GetLine>>'+ex.getLineNumber()+'getMessage'+ex.getMessage());
            }
        }
    }
}