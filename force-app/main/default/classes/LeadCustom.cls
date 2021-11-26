public class LeadCustom {
    public static void leadCustom(){
        list<lead> leadList = new list<lead>();
        
        leadList = [SELECT Id, Name, Records__c, CreatedDate  FROM Lead where Records__c includes ('Seller') and Records__c includes ('Tenant')  and (createdDate = LAST_YEAR)];
        for(lead acc: leadList){
            //if(acc.CreatedDate < THIS_YEAR()){
            system.debug(acc.Name + ' <<Name '+ acc.Id + ' <<Id ' + acc.Records__c + ' <<Record');                
            //}
             
        }
      
        }
        
       
    
}