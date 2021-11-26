public class TestAccountClass {
@AuraEnabled
    public static String getAccount(){
       Account acc =  [Select Name from Account limit 1];
        return acc.name;
    }
}