public class Accountfortrigger {
    public static void accn(list<Account> accList){
        if(accList!=null && !accList.isEmpty()){
            list<Account> numbEmp = [Select  NumberOfEmployees  from Account where id in :  accList limit 5];
            list<Contact> con = new list<Contact>();
            for(Account acc:accList){
                Contact conAcc = new Contact();
                conAcc.AccountId = acc.Id;
                conAcc.LastName = acc.Name;
                con.add(conAcc);    
            }  
            insert con;
        }
    }
    
    public static void salesRepresentative(List<Account> accList){
        if(accList!=null && !accList.isEmpty()){
            try{
                list<Account> accId = [SELECT ownerid from account where id in : accList];
                set<Id> setId = new set<id>();
                for(Account acli : accId){
                    setId.add(acli.ownerid);
                }
                list<User> usrr = [select  FirstName, LastName from User where Id in : setId ];
                system.debug(usrr);
                
                List<String> OwnerName = new List<String>();
                for(User usr : usrr){                    
                    OwnerName.add(usr.FirstName+' '+usr.LastName);                   
                }
                list<Account> fetchid = [Select Sales_Representative__c from account where id in : accList];
                system.debug(fetchid);
                list<Account> acc = new list<Account>();
                Integer I = 0;
                for(Account accAdd : fetchid){
                    accAdd.Sales_Representative__c = OwnerName[I];
                    I=I+1;
                    acc.add(accAdd);
                    system.debug(acc);
                }
                update acc;
            } catch(Exception ee){
                system.debug(ee.getCause());
                system.debug(ee.getLineNumber());
                system.debug(ee.getMessage());
            }
        }
    }
    
}