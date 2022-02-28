public class AccountCreation {
    public static void createAccount()
    {
        try{
        List<Account> acc = new List<Account>();
        for(integer i=0;i<=20;i++)
        { 
            Account a=new Account(); 
            a.Name='Name' + i;  
            String save=a.AccountNumber='101'+i;
            a.Rating='Cold';    
            a.Fax='6656';
            a.Description='New account';
            acc.add(a);  
        }
         if(acc!=null){
             insert acc;    
            }           
            system.debug(acc);
        }catch(Exception e){
            system.debug(e.getLineNumber());
        }
    }
}