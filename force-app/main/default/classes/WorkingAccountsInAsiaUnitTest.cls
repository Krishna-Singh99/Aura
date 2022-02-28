@isTest
private class WorkingAccountsInAsiaUnitTest {

    @isTest
    static void TestWorkingAccountsInAsia(){
        Account acc = new Account(Name='Account',multiPickList__c='ASIA',NumberofEmployees = 200);
        insert acc;
        Opportunity opp = new Opportunity(Name='Opp',Accountid=acc.id,StageName='Closed Won',CloseDate=date.today());
        insert opp;
          Product2 demoProduct = new Product2 (Name = 'Sales');
       insert demoProduct;
          Id pricebookId = Test.getStandardPricebookId();
         PricebookEntry standardPrice = new PricebookEntry(
            Pricebook2Id = pricebookId, Product2Id = demoProduct.Id,
            UnitPrice = 10000, IsActive = true);
        insert standardPrice;
        Pricebook2 prc2 = new Pricebook2(Name='Pc');
        insert prc2;
         PriceBookEntry pbe  = new PriceBookEntry();
         pbe.Product2Id = demoProduct.id;
         pbe.IsActive = true;
         pbe.Pricebook2Id =prc2.id;
         pbe.UseStandardPrice = false;
         pbe.UnitPrice = 1;
        insert pbe;
        OpportunityLineItem oli = new OpportunityLineItem(Opportunityid=opp.id,PricebookEntryId=pbe.id,TotalPrice = 10,Quantity = 10);
        insert oli;
        Test.startTest();
        WorkingAccountsInAsia.asiaAccount();
        Test.stopTest();
    }
    @isTest 
    static void Multiacc(){
         Account acc = new Account(Name='Account',multiPickList__c='ASIA;NA',NumberofEmployees = 200);
        insert acc;
        Test.startTest();
        MultiCheckAccount.multicheckAccount();
        Test.stopTest();
    }
}