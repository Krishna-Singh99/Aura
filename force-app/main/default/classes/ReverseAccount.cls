public class ReverseAccount {
    public static void reverse_Account(){
        list<Account> acc=new list<Account>();
        acc=[Select Name from Account];
        for(Account str: acc){
            Reverse(str.name);
        } 
    }
    public static void Reverse(string name){
        string temp='';
        for(integer i=name.length()-1;i>=0;i--){
            temp+=name.substring(i,i+1);
            
        }
        system.debug(temp);
    }
}