public class AscendingNamesOfAccount {
    public static void Ascname(){
        list<Account> acc=new list<Account>();
        acc = [Select Name from Account ORDER by Name ASC];
        system.debug(acc);
    }
}