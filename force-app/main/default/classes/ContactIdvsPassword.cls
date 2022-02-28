public class ContactIdvsPassword {
  @AuraEnabled
  public static Boolean setNamePWd(String username, String passwrd) {
    try {
        system.debug('username>>>'+username + 'passwrd' + passwrd);
      List<Contact> conid = [SELECT Username__c, password__c  FROM Contact where Username__c !=null and password__c !=null ];
        Boolean status=false ;
        for(Contact con : conid){
           if(con.Username__c == username &&  con.password__c  == passwrd){
            status = true;
            system.debug('status'+status);
               return status;
        }
        else{
            status = false;
            system.debug('status'+status);
        }
                    
        }
        
        return status;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
        
    }

  }
}