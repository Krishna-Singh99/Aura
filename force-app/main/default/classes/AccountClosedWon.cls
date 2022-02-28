public class AccountClosedWon {
    public static void accWon(){
        try{
      AggregateResult[] ar = [SELECT count(id)avg ,accountid FROM Opportunity  where stagename = 'Closed Won' group by AccountId];
      integer innn = (Integer)ar[0].get('avg');
        if(innn >=10){
            system.debug(ar[0].get('avg'));
            system.debug(ar[1].get('accountid'));
        }
        else 
        {
            system.debug('None to show');
        }
    }Catch(Exception e){
        system.debug(e.getcause());
    }   
}
}