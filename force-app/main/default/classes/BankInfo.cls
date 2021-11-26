public class BankInfo {
    @AuraEnabled
    public static List<string> bankField() {
        try {
            List<String> fieldName = new  List<String>();
            Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
            Schema.SObjectType sobjType = gd.get('Bank__c'); 
            Schema.DescribeSObjectResult describeResult = sobjType.getDescribe(); 
            Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap(); 
            //system.debug('fieldsMap'+fieldsMap);
            for(String fldname : fieldsMap.keySet()){
                fieldName.add(fldname);
            }
            return fieldName;
        } catch (Exception Err) {
            System.debug(
                'Error >>>>>>>>>>>> ' +
                Err.getLineNumber() +
                ' ' +
                Err.getCause() +
                ' ' +
                Err.getMessage()
            );
            return null;
        }
    }
     @AuraEnabled
    public static String saveBankDetails(Account bank) {
        // system.debug('bank'+bank);
        if(bank != null){
            Insert bank;
        return 'Success';
        }else{
            return null;
        }
        
    }
     @AuraEnabled
    public static List<Account> fetchBankDetails() {
        List<Account> accList = [Select id,Name,Bank__c,BankAddress__c,TotalAmount__c,IFSC__c,Transaction__c from Account where Bank__c!=null];
        if(accList!=null){
             return accList;
        }else{
            return null;
        }
       
    }
    @AuraEnabled
    public static List<Account> trancation(String amount,String Accountid,String transactions) {
        System.debug('amount>>>'+amount+'<<<<<<<<<<Accountid>>>>'+Accountid);
        if(!String.isBlank(amount) && !String.isBlank(Accountid)){
             List<Account> accList = [Select id,Name,Bank__c,BankAddress__c,TotalAmount__c,IFSC__c,Transaction__c from Account where id =: Accountid];
         List<Account> upList  = new List<Account>();
        for(Account acc : accList){
            Account updateTransaction = new Account();
            updateTransaction.Id = acc.id;
            
            if(transactions == 'Credit'){
                updateTransaction.Transaction__c = '+' + amount;
            updateTransaction.TotalAmount__c = acc.TotalAmount__c + Decimal.valueOf(amount);
                
            }
             if(transactions == 'Debit'){
                updateTransaction.Transaction__c = '-' + amount;
                 if(updateTransaction.TotalAmount__c>=Decimal.valueOf(amount)){
           updateTransaction.TotalAmount__c = acc.TotalAmount__c - Decimal.valueOf(amount);                     
                 }
           
                
            }
            
            upList.add(updateTransaction);
        }
        update upList;
        System.debug('upList>>>>>'+upList);
            return upList;
        }
        else{
            return null;
        }
       
        
    }
}