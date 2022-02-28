public  class Textboxsearch {
    public String AccountName{get;set;}
    public List<Account> accList{get;set;}
    public Textboxsearch(){
        accList = new List<Account>();
     accList = new list<Account>([SELECT id,name,phone,BillingPostalCode  from ACCOUNT limit 200]);   

    }
    public PageReference search_account(){
        accList.clear();
        accList = [SELECT id,name,phone,BillingPostalCode  from ACCOUNT where name =: AccountName limit 200];
        return null;
    }
     public PageReference clear_search(){
        accList.clear();
         
        accList = [SELECT id,name,phone,BillingPostalCode  from ACCOUNT limit 200];
        return null;
    }
     public PageReference searchby_phone(){
        accList.clear();
         
        accList = [SELECT id,name,phone,BillingPostalCode  from ACCOUNT where phone =: AccountName  limit 200];
        return null;
    }
    public PageReference searchby_PostalCode(){
        AccountName = ' ';
        accList.clear();
         
        accList = [SELECT id,name,phone,BillingPostalCode  from ACCOUNT where BillingPostalCode =: AccountName  limit 200];
        return null;
    }
}