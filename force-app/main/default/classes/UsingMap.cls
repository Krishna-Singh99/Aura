public class UsingMap {
    public static void mapForAccount(){
        try{
        Map<id,Contact> contactidVsAccount = new Map<id,Contact>([Select id, Account.id,Firstname,Lastname, Account.name, Account.BillingStreet from contact where Account.BillingStreet != null]);
        set<id> setId = new set<id>();
        for(Contact addid : contactidVsAccount.values() ){
            setId.add(addid.AccountId);
        }
        
        list<opportunity> oppor = [Select id from opportunity where Accountid in : setId];
        list<Contact> addNewContact = new  list<Contact>();
        system.debug('contactidVsAccount : '+ contactidVsAccount);
        for(Contact con : contactidVsAccount.values()){
            Contact opp = new Contact();
            string str = ' ' ;
            str += con.Account.BillingStreet + '@gmail.com';
              opp.Id = con.id;
            opp.AccountId = con.AccountId;
            opp.FirstName = 'Mathew';
            opp.LastName = con.LastName;
            opp.Email  = str ;
          addNewContact.add(opp);     
        }
        insert addNewContact;
        system.debug('addNewOpportunity:  '+ addNewContact);
        }catch(Exception e){
           system.debug(e.getCause()); 
             system.debug(e.getLineNumber());
             system.debug(e.getMessage());
        }
    }
}