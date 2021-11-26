public class Confrim_Choice_class {
    public String AccountName{get;set;}
    public void Confrim_ac(ApexPages.StandardController controller){
        Account acc = new Account(Name=AccountName);
        insert acc;
    }
}