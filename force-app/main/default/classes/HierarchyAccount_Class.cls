public class HierarchyAccount_Class {

    public String accId{get;set;}
    public string fetchId{get;set;}
    public List<Account> accList{get;set;}
    
    public HierarchyAccount_Class(ApexPages.StandardController stdcontroller){
        fetchId = stdcontroller.getid();
      
    }
    public void childclass(){
       
        
      accList = [Select name from Account where ParentId =:fetchId];        
    }
}