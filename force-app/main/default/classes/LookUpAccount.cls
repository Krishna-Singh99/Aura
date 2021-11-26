public class LookUpAccount {
    public static void createContactLookup()
    {

        list<contact> conList = new list<contact>();
        
        //Retriving Account Name
        list<Account> accList = new list<Account>();
        
        accList = [SELECT ID FROM Account LIMIT 10];
        for(Account acc : accList)
        {
            for(integer i=1;i<=10;i++)
            {
                contact con = new contact();
                con.FirstName = 'ConFirst'+i;
                con.Email = 'TestConEmail'+i+'@gmail.com';
                con.LastName = 'ConLast'+i;
                con.AccountId = acc.ID;
             
                conList.add(con);
            } 
        }
        
        
        if(conList != NULL){
            insert conList;
        }
    }
}