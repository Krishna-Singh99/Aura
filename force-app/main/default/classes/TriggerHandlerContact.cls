public class TriggerHandlerContact {
    public static void updateAccountName(List<Contact> conList){
        try{
            List<Account> accList = new List<Account>();
            
            for(Contact con : [Select AccountId,Account.Name,LastName FROM Contact where ID In : conList]){
                con.Account.Name += con.LastName;
                accList.add(con.Account);
            }
            
            if(accList.size() > 0){
                update accList;
            }
            
        }catch(Exception e){
            System.debug('Exception caught --> '+e);
        }
    }
    public static void removeContactName(List<Contact> conList){
        if(conList!=null && !conList.isEmpty()){
        System.debug(conlist);
        try{
            List<Account> accList = new List<Account>();
            
            for(Contact con : [Select AccountId,Account.Name,LastName from Contact where Id In : conList]){
                con.Account.Name = con.Account.Name.removeEndIgnoreCase(con.LastName);
                accList.add(con.Account);
                
            }
            if(accList.size() > 0){
                update accList;
            }
            
        }catch(Exception e){
            System.debug('Exception Caught --> '+e);
        }
        }
    }
    public static void contactUndelete(list<contact> conList){
        try{
            System.debug('hello');
            System.debug(conList);
            List<Contact> con  = new list<Contact>();
            
            for(Contact conAddUndel : conList){
                contact undelCon = new Contact(); 
                undelCon.Id  = conAddUndel.Id;
                undelCon.LastName = conAddUndel.LastName +  ' Undeleted Contact';
                system.debug(undelCon);
               if(conAddUndel.Email!=null){
              //   EmailManager.SendMail(conAddUndel.Email, 'List ', 'Herrath');
             }
                
                con.add(undelCon);
                
            }
            update con;
        }catch(Exception ee ){
            system.debug(ee.getCause());
            system.debug(ee.getLineNumber());
            system.debug(ee.getMessage());
        }
    }
    public static void contactUndeleteUsingMap(Map<id,Contact> conList){
        try{   
            //  Map<Id,Contact> mapName = new Map<Id,Contact>([Select id,LastName,Email from contact where  id in : conList ] );
              system.debug(conList);            
            Map<Id,Contact> con  = new Map<Id,Contact>();
            
            for(Contact conAddUndel : conList.Values()){
                contact undelCon = new Contact(); 
                undelCon.Id  = conAddUndel.Id;
                undelCon.LastName = conAddUndel.LastName +  ' Undeleted Contact';
                system.debug(undelCon);
                if(conAddUndel.Email!=null){
                   // EmailManager.SendMail(conAddUndel.Email, 'List ', 'Herrath');
                }
                con.put(undelCon.Id,undelCon);
                
                
            }
            update con.values();
        }catch(Exception ee ){
            system.debug(ee.getCause());
            system.debug(ee.getLineNumber());
            system.debug(ee.getMessage());
        }
    }
    public static void sendDetailsThroughMail(List<Contact> contactList){
        
        try{
            Set<Id> setId  = new Set<Id>();
            for(Contact conId : contactList){
                setId.add(conid.ownerid);
                system.debug(setId);
            }
            List<User> usr = [Select id,email from  User where id in : setId];
            System.debug(usr);
            for(User senddmail:usr){
                for(Contact con: contactList){
                    if(con.OwnerId == senddmail.Id){
                        String str =con.Name+' '+ con.Phone + ' ' + con.OtherAddress;
                        
                        EmailManager.sendmail(senddmail.Email, 'Alert [Conatct]','A new contact is inserted in Salesforce' + str);
                        system.debug(senddmail.email);
                    }
                }
            }
            
        }catch(Exception ee){
            system.debug(ee.getCause());
            system.debug(ee.getLineNumber());
            system.debug(ee.getMessage());
        }
    }
}