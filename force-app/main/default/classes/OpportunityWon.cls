public class OpportunityWon {
    public static void oppWon(){
           List<Opportunity> opp = [SELECT Account.Name, 
                                 (SELECT Quantity FROM OpportunityLineItems where quantity > 100)
                                 FROM Opportunity where stageName = 'closed won' ];
        for(Opportunity op: opp){
            if(op!=NULL){
                  system.debug(op.Account.Name);
            }
          
        }
    }
}