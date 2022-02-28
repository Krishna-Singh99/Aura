public class testAccount {

    public static void testfunction(){
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
        Account acc1 = new Account(Name='Test');
        insert acc1;
        insert new Account(Name='test');
    }
}