global class OpportunityBatch implements Database.Batchable<sObject> {
    Global database.QueryLocator start(Database.BatchableContext dbc){
        return database.getQueryLocator([Select id,Name,StageName,CloseDate from opportunity limit 1 ]);
    }
  Global void execute(Database.BatchableContext dbc, List<Opportunity> opp){
        try{
        List<Opportunity> opplist = new List<Opportunity>();
        for(integer i=0;i<5;i++){
            Opportunity createOpp = new Opportunity();
            createOpp.Name = 'BatchOpportunity ' + i;
            createOpp.StageName = 'Closed Won';
            createOpp.CloseDate = date.today();
            opplist.add(createOpp);
        }
        insert opplist;
        } catch(Exception e){
            system.debug(e.getCause());
            system.debug(e.getLineNumber());
            system.debug(e.getMessage());
        }
    }
    public void finish(Database.BatchableContext dbc){
        system.debug('Opportunity created');
    }

}