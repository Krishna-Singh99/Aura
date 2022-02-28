public without sharing class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    public Integer recordcount = 0;
    public Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([Select id, name from Lead]);
    }
    
    public void execute(Database.BatchableContext dbc, List<Lead> leads){
        for(Lead l: leads){
            l.leadSource = 'Dreamforce';
        }
        update leads;
        recordcount = recordcount + leads.size();
    }
    public void finish (Database.BatchableContext dbc){
        system.debug('Done '+ recordcount);
    }
}