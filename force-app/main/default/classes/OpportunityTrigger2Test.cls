@isTest
private class OpportunityTrigger2Test {
    @isTest
    static void TestOpportunityTrigger2(){
         Account acc = new Account(Name='Krishna');
        insert acc;
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
        list<Opportunity>  oppList = new list<Opportunity>();
        Opportunity opp = new Opportunity();
        opp.Name =  'Opportunity';
        opp.stagename = 'Closed Lost';
        opp.CloseDate = date.today();
        opp.Pricebook2Id = prc2.id;
        opp.AccountId=acc.id;
        opp.TotalOpportunityQuantity = 5;
        oppList.add(opp);
         insert oppList;
        list<OpportunityLineItem> oliList = new list<OpportunityLineItem>();
        oliList.add(new OpportunityLineItem(OpportunityId = opp.Id,PricebookEntryId = pbe.Id,TotalPrice = 10,Quantity = 10));
        insert oliList;
        Test.startTest();
       OpportunityTrigger.numberOfLineItems(oliList);
        
        Test.stopTest();
    }
     @isTest
    static void TestOpportunityTrigger(){
        Test.startTest();
        OpportunityTrigger.oppTrig();
        Test.stopTest();
    }
     @isTest
    static void TestOpportunityTrigger24(){
         Account acc = new Account(Name='Krishna');
        insert acc;
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
        list<Opportunity>  oppList = new list<Opportunity>();
        Opportunity opp = new Opportunity();
        opp.Name =  'Opportunity';
        opp.stagename = 'Closed Won';
        opp.CloseDate = date.today();
        opp.Pricebook2Id = prc2.id;
        opp.AccountId=acc.id;
        opp.TotalOpportunityQuantity = 5;
        oppList.add(opp);
         insert oppList;
        list<OpportunityLineItem> oliList = new list<OpportunityLineItem>();
        oliList.add(new OpportunityLineItem(OpportunityId = opp.Id,PricebookEntryId = pbe.Id,TotalPrice = 10,Quantity = 10));
        insert oliList;
        Test.startTest();
       OpportunityTrigger.ContactRoles(oppList);
        
        Test.stopTest();
    }
}