public class TestJsonData {
    
    public static void test(){
        
        List<Map<String, Object>> jsonData = new List<Map<String, Object>>();
        Map<String, List<String>> productCodeVsProductMap = new Map<String, List<String>>();
        
        List<String> dt = new List<string>();
        Map<String, String> productidVsJSonDataMap = new Map<String, String>();
        String[] jsonList = new String[]{'{"Qty":4,"ManufacturerPart#":"C9300-24T-A","LongDescription":"Catalyst930024-portdataonly,NetworkAdvantage","UnitCost":5277.66}','{"Qty":4,"ManufacturerPart#":"IE-4010-4S24P","LongDescription":"IE4010with24GECopperPoE+portsand4GESFPuplinkports","UnitCost":6147.29}','{"Qty":4,"ManufacturerPart#":"C9500-48Y4C-A","LongDescription":"Catalyst950048-portx1/10/25G+4-port40/100G,Advantage","UnitCost":16409.63}','{"Qty":4,"ManufacturerPart#":"CA-9300-48T-A","LongDescription":"Catalyst930048-portdataonly,NetworkAdvantage","UnitCost":7224.28}','{"Qty":4,"ManufacturerPart#":"4PT-KIT-T2=","LongDescription":"4PointType1rackmountkitNew","UnitCost":163.72}','{"Qty":4,"ManufacturerPart#":"C9500-4PT-KIT=","LongDescription":"Extensionrailsandbracketsforfour-pointmounting","UnitCost":171.44}','{"Qty":4,"ManufacturerPart#":"4PT-KIT-T2=","LongDescription":"4PointType1rackmountkitNew","UnitCost":163.72}','{"Qty":4,"ManufacturerPart#":"SFP-H25G-CU5M=","LongDescription":"25GBASE-CUSFP28Cable5Meter","UnitCost":129.06}','{"Qty":4,"ManufacturerPart#":"SFP-H10GB-CU1M=","LongDescription":"10GBASE-CUSFP+Cable1Meter","UnitCost":67.96}','{"Qty":4,"ManufacturerPart#":"GLC-LH-SMD++=","LongDescription":"1000BASE-LX/LHSFPtransceivermodule,MMF/SMF,1310nm,DOM","UnitCost":620.58}','{"Qty":4,"ManufacturerPart#":"GLC-SX-MMD++=","LongDescription":"1000BASE-SXSFPtransceivermodule,MMF,850nm,DOM","UnitCost":311.85}','{"Qty":3,"ManufacturerPart#":"CP-7841-K9++=","LongDescription":"CiscoUCPhone7841,TAA","UnitCost":223.83}','{"Qty":1,"ManufacturerPart#":"CP-6901-C-K9=","LongDescription":"CiscoUCPhone6901,Charcoal,Standardhandset","UnitCost":68.61}','{"Qty":7,"ManufacturerPart#":"CP-HS-W-531-RJ=","LongDescription":"Headset531WiredSingle+QDRJHeadsetCable","UnitCost":152.81}','{"Qty":4,"ManufacturerPart#":"C8500L-8S4X","LongDescription":"CiscoCatalyst8500Series4xSFP+and8xSFP,4x10GE,8x1GE","UnitCost":24226.38}','{"Qty":2,"ManufacturerPart#":"SFP-10G-SR++=","LongDescription":"10GBASE-SRSFPModule","UnitCost":620.58}','{"Qty":3,"ManufacturerPart#":"CAB-C13-C14-2M=","LongDescription":"PowerCordJumper,C13-C14Connectors,2MeterLength","UnitCost":66.61}','{"Qty":7,"ManufacturerPart#":"GLC-LX-SM-RGD=","LongDescription":"1000MbpsSingleModeRuggedSFP","UnitCost":704.06}'};
            for(String str : jsonList){
                Map<String, Object> jsonResult = (Map<String, Object>) JSON.deserializeUntyped(str);
                jsonData.add(jsonResult);
                //System.debug('Info : '+str);
            }
        //System.debug('jsonData>>>'+jsonData);
        List<String> productCode = new List<String>();
        List<String> allData = new List<String>();
        for(Map<String, Object> fillterData : jsonData){
            //  System.debug('fillterData : > '+fillterData); 
            allData = new List<String>();
            for(String skt: fillterData.keySet()){
                
                //  System.debug('skt>>'+skt);
                // System.debug('String.valueOf(fillterData.get(skt)>>'+String.valueOf(fillterData.get(skt)));
                
                allData.add(String.valueOf(fillterData.get(skt)));
            }
            
            productidVsJSonDataMap.put(String.valueOf(fillterData.get('ManufacturerPart#')),String.valueOf(fillterData.get('Qty')));
            // System.debug('Fillter Data : '+fillterData.get('Qty'));
            //  productCode.add(fillterData.get('ManufacturerPart#'));
            productCodeVsProductMap.put(String.valueOf(fillterData.get('ManufacturerPart#')),allData);
            
        }  
        //System.debug('productCodeVsProductMap>>>>>'+productCodeVsProductMap + '\n');
        Set<String> proCode  = productCodeVsProductMap.keySet();
        List<OpportunityLineItem> prodTobeUpdte = new List<OpportunityLineItem>();
        List<Product2> prodTobeInsert = new List<Product2>();
        List<PricebookEntry> prcbkList = new List<PricebookEntry>();
        Map<String,PricebookEntry> fetchedProductVsPricebkEntryMap = new Map<String ,PricebookEntry>();
        if(proCode != null && !proCode.isEmpty()){
            prcbkList = [Select Id, Name, Pricebook2Id, Product2Id,product2.productCode, UnitPrice, UseStandardPrice, IsActive from PricebookEntry WHERE product2.productCode  IN : proCode];
        }
        //System.debug('prcbkList : '+prcbkList.size());
        for(PricebookEntry priceEnt : prcbkList){
            fetchedProductVsPricebkEntryMap.put(priceEnt.product2.productCode, priceEnt);
        }
        for(String data : fetchedProductVsPricebkEntryMap.keySet()){
            System.debug('Key data : '+data);
            System.debug('Value data : '+ fetchedProductVsPricebkEntryMap.get(data));
        }
        for(String product : productCodeVsProductMap.keySet()){
            System.debug('product data : '+product);
            System.debug('product Value : '+ productCodeVsProductMap.get(product));
        }
        for(String proData: productCodeVsProductMap.keySet()){
            if(fetchedProductVsPricebkEntryMap.containsKey(proData)){
                OpportunityLineItem newOLIitems = new OpportunityLineItem(); 
                //OpportunityId = '00k5g00001LOaYhAAL',PricebookEntryId = prc.Id,TotalPrice = 10,Quantity = 110
                newOLIitems.OpportunityId = '0065g00000FQ8FzAAL';
                newOLIitems.PricebookEntryId = fetchedProductVsPricebkEntryMap.get(proData).Id;
                newOLIitems.TotalPrice = Decimal.valueOf(productCodeVsProductMap.get(proData).get(3));
                newOLIitems.Quantity = Integer.valueOf(productCodeVsProductMap.get(proData).get(0));
                prodTobeUpdte.add(newOLIitems);
            }
            else{
                // System.debug('productCodeVsProductMap.get(proData).get(4)>>>>>' + productCodeVsProductMap.get(proData).get('LongDescription'));
                // System.debug('productCodeVsProductMap>>>'+productCodeVsProductMap.get(proData));
                Product2 newPro = new Product2();
                //Product2 newProduct =  new Product2(Name=productData.get(procode),productcode=procode,isActive=true,Description = productData.get(procode));
                if(productCodeVsProductMap.get(proData).get(1) !=null){
                    newPro.Name = String.valueof(productCodeVsProductMap.get(proData).get(1));
                    newPro.Description = productCodeVsProductMap.get(proData).get(1);
                    newPro.isActive = true;
                    newPro.productcode = proData;
                    newPro.Cost__c = Decimal.valueOf(productCodeVsProductMap.get(proData).get(3));
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
        Pricebook2 standardPricebook  = [Select id from Pricebook2 where isStandard = true];
        List<PricebookEntry> pricebookList = new List<PricebookEntry>();
        for(Product2 prcbk : prodTobeInsert){
            PricebookEntry standardPrice = new PricebookEntry(
                Pricebook2Id = standardPricebook.id, Product2Id = prcbk.Id,
                UnitPrice =  Decimal.valueOf(productCodeVsProductMap.get(prcbk.ProductCode).get(3)), IsActive = true);
            pricebookList.add(standardPrice);
        }
        
        insert pricebookList;
        System.debug('pricebookList >>>>'+pricebookList.size());
        
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        for(PricebookEntry pricebkEntry : pricebookList){
            for(String mpofJson : productidVsJSonDataMap.keySet()){
               
                for(Product2 proRec : prodTobeInsert){
                    if(mpofJson == proRec.ProductCode){
                        OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = '0065g00000FQ8FzAAL',PricebookEntryId = pricebkEntry.Id,TotalPrice = pricebkEntry.UnitPrice,Quantity = Integer.valueof(productCodeVsProductMap.get(proRec.ProductCode).get(0)));
                        oliList.add(oli);
                    }
                    
                }
            }                  
        }               
        insert oliList;
        System.debug('oliList >>>>87'+oliList.size());
        
    }
}