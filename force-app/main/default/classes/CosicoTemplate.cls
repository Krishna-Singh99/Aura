public with sharing class CosicoTemplate {
public static String  getProduct(Map<String, List<String>> productCodeVsProductMap) {
if(productCodeVsProductMap != null && !productCodeVsProductMap.isEmpty()){
    Set<String> proCode  = productCodeVsProductMap.keySet();
    List<OpportunityLineItem> prodTobeUpdte = new List<OpportunityLineItem>();
    List<Product2> prodTobeInsert = new List<Product2>();
    List<PricebookEntry> prcbkList = new List<PricebookEntry>();
    Map<String ,PricebookEntry> fetchedProductVsPricebkEntryMap = new Map<String ,PricebookEntry>();
    if(proCode != null && !proCode.isEmpty()){
        prcbkList = [Select Id, Name, Pricebook2Id, Product2Id,product2.productCode, UnitPrice, UseStandardPrice, IsActive from PricebookEntry WHERE product2.productCode  IN : proCode];
    }
    System.debug('prcbkList : '+prcbkList.size());
    for(PricebookEntry priceEnt : prcbkList){
        fetchedProductVsPricebkEntryMap.put(priceEnt.product2.productCode, priceEnt);
    }
    for(String data : fetchedProductVsPricebkEntryMap.keySet()){
        System.debug('Key data : '+data);
            System.debug('Value data : '+ fetchedProductVsPricebkEntryMap.get(data));
    }
    for(String proData: productCodeVsProductMap.keySet()){
        if(fetchedProductVsPricebkEntryMap.containsKey(proData)){
            OpportunityLineItem newOLIitems = new OpportunityLineItem(); 
            //OpportunityId = '00k5g00001LOaYhAAL',PricebookEntryId = prc.Id,TotalPrice = 10,Quantity = 110
            newOLIitems.OpportunityId = '0065g00000FQ8FBAA1';
            newOLIitems.PricebookEntryId = fetchedProductVsPricebkEntryMap.get(proData).Id;
            newOLIitems.TotalPrice = 50;
            newOLIitems.Quantity = 112;
            prodTobeUpdte.add(newOLIitems);
        }else{
            System.debug('productCodeVsProductMap.get(proData).get(4)>>>>>'+productCodeVsProductMap.get(proData).get(4));
            System.debug('productCodeVsProductMap>>>'+productCodeVsProductMap.get(proData));
            Product2 newPro = new Product2();
            //Product2 newProduct =  new Product2(Name=productData.get(procode),productcode=procode,isActive=true,Description = productData.get(procode));
            if(productCodeVsProductMap.get(proData).get(4) !=null){
                newPro.Name = productCodeVsProductMap.get(proData).get(4);
                newPro.Description = productCodeVsProductMap.get(proData).get(4);
                newPro.isActive = true;
                newPro.productcode = proData;
                //newPro.Cost__c = Decimal.valueOf(productCodeVsProductMap.get(proData)[16]);
                prodTobeInsert.add(newPro);
            
            }
               
            
        }
    }
    if(prodTobeInsert != null && !prodTobeInsert.isEmpty()){
        insert prodTobeInsert;
        System.debug('prodTobeInsert.size()'+prodTobeInsert.size());
    }
    if(prodTobeUpdte != null && !prodTobeUpdte.isEmpty()){
        insert prodTobeUpdte;
         System.debug('prodTobeUpdte.size()'+prodTobeUpdte.size());
    }
  //  Id standardPricebook = Test.getStandardPricebookId();
    Pricebook2 standardPricebook  = [Select id from Pricebook2 where isStandard = true];
        List<PricebookEntry> pricebookList = new List<PricebookEntry>();
        for(Product2 prcbk : prodTobeInsert){
            PricebookEntry standardPrice = new PricebookEntry(
                Pricebook2Id = standardPricebook.id, Product2Id = prcbk.Id,
                UnitPrice = 10000, IsActive = true);
                pricebookList.add(standardPrice);
        }
        
        insert pricebookList;
        System.debug('pricebookList >>>>'+pricebookList.size());
        // List<Pricebook2> newpriceBookList = new List<Pricebook2>();
        // for(Product2 pricebook2 : prodTobeInsert){
        //     Pricebook2 prc2 = new Pricebook2(Name=pricebook2.Name);
        //     newpriceBookList.add(prc2);
        // }
        
        // insert newpriceBookList;
        // System.debug('newpriceBookList >>>>'+newpriceBookList.size());
        // List<PricebookEntry> prcbkEntry = new List<PricebookEntry>();
        // for(Product2 pro : prodTobeInsert){
        //     for(Pricebook2 prc : newpriceBookList){
        //         PriceBookEntry pbe  = new PriceBookEntry();
        // pbe.Product2Id = pro.Id;
        // pbe.IsActive = true;
        // pbe.Pricebook2Id =prc.id;
        // pbe.UseStandardPrice = false;
        // pbe.UnitPrice = 1;
        //     prcbkEntry.add(pbe);
        //     }
        // }
        //     insert prcbkEntry;
        //     System.debug('prcbkEntry >>>>'+prcbkEntry.size());
            List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
            for(PricebookEntry pricebkEntry : pricebookList){
            OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = '0065g00000FQ8FBAA1',PricebookEntryId = pricebkEntry.Id,TotalPrice = 10,Quantity = 110);
            oliList.add(oli);
            }
        insert oliList;
        System.debug('oliList >>>>87'+oliList.size());
}
// if(productCode !=null && Description != null && costList != null){
//     Map<String,String> productData = new  Map<String,String>();
//     for(integer i=0 ; i<productCode.size();i++){
//         productData.put(productCode[i],Description[i]);
//     }
   
//     List<PricebookEntry> prcbkList = [Select Id, Name, Pricebook2Id, Product2Id, UnitPrice, UseStandardPrice, IsActive from PricebookEntry WHERE product2.productCode  in : productCode];
//     if(prcbkList != null){
// List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
// for(PricebookEntry prc : prcbkList){
//     OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = '00k5g00001LOaYhAAL',PricebookEntryId = prc.Id,TotalPrice = 10,Quantity = 110);
//     oliList.add(oli);
// }

// insert oliList;
//     }
// else{
//     List<Product2> prodTobeInsert  = new List<Product2>();
//     for(String procode : productData.keyset()){
//         Product2 newProduct =  new Product2(Name=productData.get(procode),productcode=procode,isActive=true,Description = productData.get(procode));
//         prodTobeInsert.add(newProduct);
        
//     }
//     insert prodTobeInsert;
//     Id standardPricebook = Test.getStandardPricebookId();
//     List<PricebookEntry> pricebookList = new List<PricebookEntry>();
//     for(Product2 prcbk : prodTobeInsert){
//         PricebookEntry standardPrice = new PricebookEntry(
//             Pricebook2Id = standardPricebook, Product2Id = prcbk.Id,
//             UnitPrice = 10000, IsActive = true);
//             pricebookList.add(standardPrice);
//     }
    
//     insert pricebookList;
//     List<Pricebook2> newpriceBookList = new List<Pricebook2>();
//     for(Product2 pricebook2 : prodTobeInsert){
//         Pricebook2 prc2 = new Pricebook2(Name=pricebook2.Name);
//         newpriceBookList.add(prc2);
//     }
    
//     insert newpriceBookList;

//     List<PricebookEntry> prcbkEntry = new List<PricebookEntry>();
//     for(Product2 pro : prodTobeInsert){
//         for(Pricebook2 prc : newpriceBookList){
//             PriceBookEntry pbe  = new PriceBookEntry();
//     pbe.Product2Id = pro.Id;
//     pbe.IsActive = true;
//     pbe.Pricebook2Id =prc.id;
//     pbe.UseStandardPrice = false;
//     pbe.UnitPrice = 1;
//         prcbkEntry.add(pbe);
//         }
//     }
//         insert prcbkEntry;
//         List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
//         for(PricebookEntry pricebkEntry : prcbkEntry){
//         OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = '00k5g00001LOaYhAAL',PricebookEntryId = pricebkEntry.Id,TotalPrice = 10,Quantity = 110);
//         oliList.add(oli);
//         }
//     insert oliList;
// }


   
// }
return null;
}

// Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(jsonInput);
// Map<String, Object> m2 = (Map<String, Object>) m.get('info5');
// List<decimal> d = new List<decimal>();

// for(String s:m2.keyset()) {
//     decimal t = (decimal) m2.get(s);
//     d.add(t);
// }
}