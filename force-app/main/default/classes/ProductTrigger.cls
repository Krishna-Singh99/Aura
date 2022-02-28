public class ProductTrigger {
    public static void productCreation(List<Product2> proList){
        try {
            List<PriceBookEntry> prc = [Select product2id, pricebook2id,UseStandardPrice,IsActive,UnitPrice from PriceBookEntry where product2id in : prolist ];
            system.debug('prc>>>>>'+prc);
            List<PriceBookEntry> updatePrc = new List<PriceBookEntry>();
            for(PriceBookEntry updateprice : prc){
                PriceBookEntry pbe  = new PriceBookEntry();
                pbe.UseStandardPrice = false;
                pbe.Product2Id = updateprice.Product2Id;
                pbe.IsActive = true;
                pbe.Pricebook2Id =updateprice.Pricebook2id;
                pbe.UnitPrice = 1;
                updatePrc.add(pbe);
            } if(!updatePrc.isEmpty()) {
                insert updatePrc;
            }
        } catch(Exception ex) {
            System.debug('Message>>>'+ex.getMessage()+'at Line number>>>'+ex.getLineNumber());
        }
        
    }
    
}