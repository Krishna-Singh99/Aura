public class AccountTriggerforRevision {
    
    public static void insertAccount(List<Account> acclist){
        if(acclist!=null && !acclist.isEmpty()){
            try{
            List<Account> newaccList = new List<Account>();
            for(Account acc: acclist){
                if(acc.Active__c == 'Yes'){
                    Account insertAcc = new Account();
                    insertAcc.Name = acc.Name;
                    newaccList.add(insertAcc);
                }
            }
            insert newacclist;
            }catch(Exception e){
                System.debug(e.getMessage());
            }
        }
    }
    public static void updateAccount(List<Account> accList){
        if(accList!=null && !accList.isEmpty()){
            try{
                for(Account acc : accList){
                    if(acc.BillingCity == null){
                        acc.BillingCity = 'Tokyo';
                        
                    }
                     update accList;
                }
               
            }catch(Exception e){
                System.debug(e.getMessage());
            }
        }
    }
    public static void deleteAccount(List<Account> accList){
        if(accList!=null && !accList.isEmpty()){
            List<Account> deleteAcc = new List<Account>();
            try{
                for(Account acc : accList){
                    if(acc.CreatedDate == date.today()){
                        deleteAcc.add(acc);
                    }
                     delete deleteAcc;
                }
               
            }catch(Exception e){
                System.debug(e.getMessage());
            }
        }
    }
    public static void undeleteAccount(List<Account> accList){
         if(accList!=null && !accList.isEmpty()){
           List<Account> undeleteAcc = [Select id,CreatedDate from Account where id =: accList All Rows];
            try{
                for(Account acc : undeleteAcc){
                    if(acc.CreatedDate == date.today()){
                        undeleteAcc.add(acc);
                    }
                    else{
                         trigger.newmap.get(acc.id).addError('Can`t Restore');  
                    }
                     undelete undeleteAcc;
                }
               
            }catch(Exception e){
                System.debug(e.getMessage());
            }
    }
    }
}