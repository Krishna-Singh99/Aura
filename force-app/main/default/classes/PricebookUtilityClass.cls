@isTest(SeeAllData=true)
public class PricebookUtilityClass {

    public static void TEstPriceBook(){
            Product2 demoProduct = new Product2(Name = 'Sales');
       insert demoProduct;
          Id pricebookId = Test.getStandardPricebookId();
      
         PricebookEntry standardPrice = new PricebookEntry(
            Pricebook2Id = pricebookId, Product2Id = demoProduct.Id,
            UnitPrice = 10000, IsActive = true);
        insert standardPrice;
        
    }
}