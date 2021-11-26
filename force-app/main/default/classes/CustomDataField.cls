public class CustomDataField {
    public string AccountId {get;set;}
    public String Result {get;set;}
    public String LastName {get;set;}
    
    public List<Contact> newConList {get;set;}
    public CustomDataField(){
        Result='';
        newConList = [SELECT iD, AccountId, LastName FROM Contact LIMIT 100];
    }
    public PageReference selectedAccId(){
        Result= '';
        if(AccountId != null){
            Account fetchAcc = [SELECT Name FROM Account WHERE Id=:AccountId];
            LastName = fetchAcc.Name; 
        }
        
        
        return null;
    }
    public PageReference newContact(){
        Result = '';
        if(AccountId != '' && LastName != ''){
            Contact newCom = new Contact(LastName=LastName,AccountId=AccountId);
            insert newCom;
            AccountId='';
            LastName='';
            Result = 'A new contact inserted';
        }else{
            Result='Contact Last Name And Lookup Account both are mandatory';
        }
        
        
        return null;
    }
    
}