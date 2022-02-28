public class MultiCheckAccount {
    public static void multicheckAccount(){
        list<Account> acc = new list<Account>();
        acc = [Select Id,name,multiPickList__c from Account where multiPickList__c = 'Asia;NA'];
        integer i=0;
        for(Account display: acc){
            i++;
          // System.debug('Account Name>>>'+display.Name + 'AccountId>>>'+display.Id + 'MultiPickList__c>>'+ display.multiPickList__c);
        }
        System.debug('No of employees Working in Asia and North America Are : ' + i);
    }
}