public class GandhiGChasma {
    public static void  gandhiGChasma(){
        list<OpportunityLineItem> oli = new list<OpportunityLineItem >();
        oli = [Select Totalprice,id,Product2Id  from opportunitylineitem where product2.name = 'gandhigchasma'];
       // list<Opportunity> opp = new list<Opportunity>();
      //  opp = [Select Id from Opportunity where Product2Id in : oli ];
    Decimal totalPriceopp=0;
        for(OpportunityLineItem show: oli){
            System.debug('items are : '+ show);
            totalPriceopp+=show.totalprice;
                   }
         system.debug('Total price In GandhijiChasma Account is '+ totalPriceopp );
        
    }

}