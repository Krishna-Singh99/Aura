public class TriggerOnTimeAccRestore {
    public static void timeAccountRestore(List<Time__c> timeList){
        try{
            set<Id> setId = new set<Id>();
             set<Id> ownerrId = new set<Id>();
             List<Id> setIdOfTime = new List<Id>();
            for(Time__c copy: timeList){
                setId.add(copy.id);
                     
            }
 
          List<Time__c> savedAccts = [SELECT Id, ownerid,Name,Start_Date__c,End_Date__c FROM Time__c WHERE id in : setId All Rows]; 
            for(Time__c seet:savedAccts){
                
                date dd = date.today().addMonths(-1);
   
                if( seet.Name.startsWith('A') && ( seet.Start_Date__c.month() == (dd.month())) 
                  && ( seet.End_Date__c.month() == (dd.month()))){
                setIdOfTime.add(seet.id);
                  ownerrId.add(seet.OwnerId);
            }
            }
            list<User> usr= [Select id,Email from user where id in :  ownerrId];
            system.debug('>>' +usr);
         
             for(User usrMail: usr){
                 for(Time__c timec : timeList){
                     if(usrMail.id == timec.OwnerId){
                         String str = ' ';
                          system.debug('>>' +usrMail.Email);
                str += (String)(' Start_Date__c >>> '+timec.Start_Date__c + ' End_Date__c >>>> ' + timec.End_Date__c + ' Name>>>' + timec.Name );
               //  EmailManager.sendmail(usrMail.Email, 'Time Alert', 'Start and End Date ' + str);
                     system.debug('>>>' +str);
                 
                     }
                      
                 }
                 
             }
    TryingFutureApex.recover(setIdofTime);
        }catch(Exception ee){
            system.debug(ee.getCause());
            system.debug(ee.getLineNumber());
            system.debug(ee.getMessage());
        }
    }
   
}