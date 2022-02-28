public class AccountStatus {
    public static void accountStat(){
        list<Account> accList = new list<Account>();
        for( integer i = 0; i<3 ; i++){
            Account acc = new Account();
            acc.Name = 'AccStatus'+i;
            acc.NumberOfEmployees = 1;
            accList.add(acc);
        }
        insert accList;
        
        list<Opportunity> opp = new list<Opportunity>();
        for(integer i = 0; i<5; i++){
            Opportunity oppCrt = new Opportunity();
            
            if(i>=0&&i<3){
                oppCrt.AccountId = accList.get(0).Id;
                oppCrt.Name = 'Opportunity'+i;
                oppCrt.CloseDate = system.today();
                oppCrt.StageName = 'Closed won';
            }
            if(i>2){
                oppCrt.AccountId = accList.get(1).Id;
                oppCrt.Name = 'Opportunity'+i;
                 oppCrt.CloseDate = system.today();
                oppCrt.StageName = 'Closed lost';
            }
          
            opp.add(oppCrt);
        }
        insert opp;
        system.debug([Select Account.Name from opportunity where stagename = 'Closed won' group by Account.Name having count(Name) > 2]);
    }
}