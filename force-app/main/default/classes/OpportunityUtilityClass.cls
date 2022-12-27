@isTest
public class OpportunityUtilityClass {

  public  static List<Product2> TestChangeInOpportunity(){
        list<Opportunity>  oppList = new list<Opportunity>();
        Opportunity opp = new Opportunity();
        opp.Name =  'Opportunity';
        opp.stagename = 'Closed Lost';
        opp.CloseDate = date.today();
        oppList.add(opp);
         insert oppList;
      
      list<Product2> newProduct = new list<Product2>();
        Product2 demoProduct = new Product2 (Name = 'gandhigchasma');
      newProduct.add(demoProduct);
       insert newProduct;
      
          Id pricebookId = Test.getStandardPricebookId();
      
         PricebookEntry standardPrice = new PricebookEntry(
            Pricebook2Id = pricebookId, Product2Id = newProduct.get(0).Id,
            UnitPrice = 10000, IsActive = true);
        insert standardPrice;
      
        Pricebook2 prc2 = new Pricebook2(Name='Pc');
        insert prc2;
      
         PriceBookEntry pbe  = new PriceBookEntry();
         pbe.Product2Id = newProduct.get(0).Id;
         pbe.IsActive = true;
         pbe.Pricebook2Id =prc2.id;
         pbe.UseStandardPrice = false;
         pbe.UnitPrice = 1;
        insert pbe;
        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = opp.Id,PricebookEntryId = pbe.Id,TotalPrice = 10,Quantity = 110);
        insert oli;  
      return newProduct;
    }

}