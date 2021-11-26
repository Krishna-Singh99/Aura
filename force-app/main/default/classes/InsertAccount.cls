public class InsertAccount {
    public static void insertOnAccount(){
        list<Account> accList = new list<Account>();
        accList= [Select Id,Name from Account LIMIT 10];
        
        list<Contact> con = new list<Contact>();
        integer j=0;
        for(integer i=1;i<=10;i++){
       
            contact cc = new contact();
            cc.AccountId = accList.get(j).Id;
            cc.LastName = accList.get(j).Name;
           con.add(cc);
             j++;
        }
if(con!=null && !con.isEmpty()){
    Insert con;
        }
}
    }