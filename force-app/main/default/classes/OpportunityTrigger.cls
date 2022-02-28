public class OpportunityTrigger {

    public static void oppTrig(){
        list<Opportunity> oppc  = new list<opportunity>();
        Opportunity opp = new Opportunity();
        opp.Name = 'OppTrigger';
        opp.StageName = 'closed won ';
        opp.CloseDate = date.today();
         oppc.add(opp);
        insert oppc;
    }
    public static void numberOfLineItems(list<OpportunityLineItem> oli){
        if(oli!=null && !oli.isEmpty()){
        list<OpportunityLineItem > oppli = [Select Opportunityid,Quantity, Opportunity.Accountid from OpportunityLineItem where Opportunity.Accountid!=null and id  in : oli];
            set<id> setopp = new set<id>();
        for(OpportunityLineItem oppset : oppli){
            setopp.add(oppset.Opportunity.Accountid);
        }
        list<Account> setNumberOfLineItems = new list<Account>();
         list<Account> LineItems = [Select Number_of_LineItems__c from account where id in : setopp];
     
           for(OpportunityLineItem oppLine : oppli){
               for(Account acc : LineItems){
                    if(acc.Number_of_LineItems__c==Null){
                    acc.Number_of_LineItems__c = oppLine.Quantity;
                setNumberOfLineItems.add(acc);
                   system.debug( setNumberOfLineItems);
               }else {
                   acc.Number_of_LineItems__c  += oppLine.Quantity;
                setNumberOfLineItems.add(acc);
               }
               } 
        }
       update setNumberOfLineItems;
    }
    }
    public static void oppClosed(List<Opportunity> conList){
       
        for(opportunity showOpp  : conlist){
            if((showOpp.IsClosed == true) && (showOpp.TotalOpportunityQuantity == Null)){
                
                trigger.newmap.get(showOpp.id).addError('No item in OpportunitylineItem, Cannot be update');      
            }
        }
    }
   public static void oppWonSold(List<Opportunity> conList){
       try{
        List<Opportunity> selectedOpr = [SELECT id from Opportunity where stageName = 'Closed Won' and Id = : conList];
        List<OpportunityLineItem> selectdProduct = [SELECT Product2id,quantity from OpportunityLineItem where OpportunityId in :selectedOpr];
       set<Id> sePrId = new set<Id>();
         List<double> stdble = new List<double>();
       for(OpportunityLineItem oppoli : selectdProduct ){
           sePrId.add( oppoli.Product2id);
           stdble.add(oppoli.Quantity);
       }
       list<Product2> addSoldQa = new list<Product2>();
       List<product2> selecedsold = [SELECT No_Of_Products_sold__c FROM Product2 where id in:sePrId];
       Integer K =0;
         for(product2 chensold : selecedsold){
             if(chensold.No_Of_Products_sold__c == null){
                 chensold.No_Of_Products_sold__c = stdble[k];
             }else{
              chensold.No_Of_Products_sold__c += stdble[k];

             }
               K=K+1;
             System.debug(chensold);
             addSoldQa.add(chensold);
           }
           update addSoldQa;
       }catch(Exception es){
           system.debug(es.getLineNumber());
           system.debug(es.getMessage());
           system.debug(es.getCause());
       }
       }
    public static void ContactRoles(list<Opportunity> accList){
        try{
        set<Id> setid = new set<id>();
        // set<Id> oppid = new set<id>();
      //  list<Opportunity> accntId = [Select Id,Accountid from Opportunity where id in : accList];
        for(Opportunity cc:  accList ){
            setid.add(cc.Accountid);
          //  oppid.add(cc.Id);
        }
         list<OpportunityContactRole> addNewContactName = new List<OpportunityContactRole>();
        list<Contact> accId = [Select Accountid, id, Name from Contact where Accountid in : setid ];
            list<OpportunityContactRole> OppConlist = new  list<OpportunityContactRole>();  
            
        for(Contact addname : accId){
            for(Opportunity opp : accList){
                OpportunityContactRole opprole = new OpportunityContactRole();
            if(addname.AccountId == opp.AccountId){
              opprole.OpportunityId  = opp.Id;
                opprole.ContactId = addname.Id;
                opprole.Role = addname.Name + 'T';
                addNewContactName.add(opprole);
                system.debug(addNewContactName);
            }   
            }  
        }
            if(addNewContactName!=NULL){
                insert addNewContactName;
            }
        
        }
       catch(Exception es){
           system.debug(es.getLineNumber());
           system.debug(es.getMessage());
           system.debug(es.getCause());
       }
    }
}