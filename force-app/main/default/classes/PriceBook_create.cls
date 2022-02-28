public class PriceBook_create {
    public  PriceBook_create(){
      Pricebook2 obj = new Pricebook2();
        Pricebook2 stnd = [select Id from Pricebook2 where isStandard = True limit 1];
        obj.Name='Algo PriceBook';
        
        insert obj;
       list<Product2> pro = new  list<Product2> ();
        
        for(integer i=0;i<10;i++){
            Product2 pt= new Product2();
           pt.Name='Test_User'+i;
            pro.add(pt);
        }
        insert pro;
        list<PricebookEntry> prbent = new list<PricebookEntry>();
        for(Product2 ajy:pro){
            PricebookEntry standardObj = new PricebookEntry();
            standardObj.Pricebook2Id = stnd.Id;
            standardObj.Product2Id = ajy.Id;
            standardObj.UseStandardPrice = False;
            standardObj.UnitPrice = 12121;
            prbent.add(standardObj);
        }
                for(Product2 ajy:pro){
            PricebookEntry standardObj1 = new PricebookEntry();
                      standardObj1.Product2Id = ajy.Id;
            standardObj1.Pricebook2Id = obj.Id;
          
            standardObj1.UseStandardPrice = False;
            standardObj1.UnitPrice = 3000;
            prbent.add(standardObj1);
        }
        insert prbent;
    }
}