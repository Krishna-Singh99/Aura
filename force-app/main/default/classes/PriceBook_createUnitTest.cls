@isTest
private class PriceBook_createUnitTest {

    @isTest
    static void TestPriceBook_create(){
        list<Opportunity>  oppList = new list<Opportunity>();
        Opportunity opp = new Opportunity();
        opp.Name =  'Opportunity';
        opp.stagename = 'Closed Lost';
        opp.CloseDate = date.today();
        oppList.add(opp);
         insert oppList;
        Pricebook2 pb1 = new Pricebook2(isActive = true, Id = Test.getStandardPricebookId());
        upsert pb1;
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
        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = opp.Id,PricebookEntryId = pbe.Id,TotalPrice = 10,Quantity = 10);
        insert oli;
         list<Opportunity>  oppListDemo = [Select id,Name from Opportunity where id in : oppList];
        for(Opportunity acc: oppListDemo){
            acc.Name = 'Demon';
        }
       
        Test.startTest();
       PriceBook_create prc = new PriceBook_create();
        Test.stopTest();
    }
}