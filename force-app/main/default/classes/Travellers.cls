public class Travellers {
    public static void travllr(){
        list<Plan__c> plan = new list<Plan__c>();
     	   List<String> availableValues = new List<String>{'A','B','C','D','E','F'};
        Integer listSize = availableValues.size() - 1;
        Integer randomNumber = Integer.valueof((Math.random() * listSize));
         String randomString= availableValues[randomNumber];
       
        for(integer i =0 ;i<1;i++){
        Plan__c addPlan = new Plan__c();
          addPlan.Name = 'Ranchi';
            addPlan.travellHour__c = 5 ;
            addPlan.travelLocation__c = randomString ;
            if(randomString!='F'){
                 addPlan.travelLocation__c = 'A;F' ;
            }
           
            plan.add(addPlan);
            
        }
        insert plan;
        list<Plan__c> planhour = new list<Plan__c>();
        planhour = [Select travellHour__c from Plan__c where travelLocation__c = 'A'or travelLocation__c ='F' ];
         Decimal totalTimeTravel=0;
        for(Plan__c addH: planhour){
            totalTimeTravel = totalTimeTravel+addH.travellHour__c;
        }
        system.debug('Total travell Hour<<<< '+totalTimeTravel);
    }
    
}