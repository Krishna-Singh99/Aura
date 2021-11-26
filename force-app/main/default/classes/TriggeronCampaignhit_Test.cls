@isTest
class TriggeronCampaignhit_Test {

    @isTest
    static void TestTriggeronCampaignhit(){
        List<Campaign> cmp = new List<Campaign>();
        cmp.add(new Campaign(Name='Camp',startDAte = date.today(), enddate = date.today().addDays(4),Status='Completed'));
        insert cmp;
        Product2 pro = new Product2(Name='Product');
        insert pro;
         
        Test.startTest();
        Opportunity opp = new Opportunity( Name =  'Opportunity',  stagename = 'Closed Lost',CloseDate = date.today(),CampaignId = cmp.get(0).id,TotalOpportunityQuantity=6);
        insert opp;
        TriggeronCampaignhit.onCampaign(cmp);
        Test.stopTest();
        system.assertEquals(cmp.size(), 1);
    }
    @isTest
    static void TestTriggeronCampaignhitNegative(){
        List<Campaign> cmp = new List<Campaign>();
        cmp.add(new Campaign(Name='Camp',startDAte = date.today(), enddate = date.today().addDays(4),Status='Completed'));
        insert cmp;
        Product2 pro = new Product2(Name='Product');
        insert pro;
         
        Test.startTest();
        Opportunity opp = new Opportunity( Name = 'Opportunity',  stagename = 'Closed Won',CloseDate = date.today(),CampaignId = cmp.get(0).id,TotalOpportunityQuantity=0);
        insert opp;
        TriggeronCampaignhit.onCampaign(cmp);
        Test.stopTest();
    }
        @isTest
    static void TestTriggeronCampaignhit3(){
        List<Campaign> cmp = new List<Campaign>();
        cmp.add(new Campaign(Name='Camp',startDAte = date.today(),Status='Completed'));
        insert cmp;
        for(Campaign updatecmp:cmp){
            updatecmp.enddate = date.today().addDays(4);
        }
            Test.startTest();
        update cmp;
        Test.stopTest();
    }
}