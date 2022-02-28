@isTest
private class BankInfoTest {

   
    static testmethod void bankfieldtest(){
        BankInfo.bankField();
    }
    

    static testmethod void saveBankDetailsTest(){
        
       Account acc = new Account(Name='xyz',Bank__c='SBI',BankAddress__c='Mirzapur',TotalAmount__c=1200,IFSC__c='SBI002B',Transaction__c='678' );
        test.startTest();
        BankInfo.saveBankDetails(acc);
        BankInfo.fetchBankDetails();
        test.stopTest();
    }
     
    static testmethod void transactioTest(){
          Account acc = new Account(Name='xyz',Bank__c='SBI',BankAddress__c='Mirzapur',TotalAmount__c=1200,IFSC__c='SBI002B',Transaction__c='678' );
      insert acc;
          test.startTest();
       BankInfo.trancation('100',acc.id,'Credit');
       BankInfo.trancation('50',acc.id,'Debit');
        test.stopTest();
    }
        
}