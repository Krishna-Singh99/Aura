global class EmailServices implements Messaging.InboundEmailHandler {
global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    System.debug('result>>>>'+result);
    Map<String, List<String>> idVsStringMap = new  Map<String, List<String>>();
    List<String> dataList = new  List<String>();
    List<String> costList = new List<String>();
    for(Messaging.InboundEmail.BinaryAttachment atch : email.binaryAttachments ){
        if(atch.filename.contains('.CSV') || atch.filename.contains('.csv')){
            String allData =  atch.body.toString();
            dataList = allData.split('\n');
        }
}

for(String rowData : dataList){
   

    
    rowData = rowData.remove('$');
    List<String> FinalData = rowData.split(',');
    list<String> cleanedData = new List<String>();
    Boolean compositeField = false;
    String composeString = '';
    for(String columnData : FinalData){
        columnData = columnData.trim();
        if(columnData.startsWith('"') && !columnData.endsWith('"')){
            compositeField = true;
        }else if(!compositeField){
            columnData = columnData.replaceAll('"', '');
            cleanedData.add(columnData.remove('"'));
            
        }
        if(compositeField && !columnData.endsWith('"')){
            if(composeString == ''){
                composeString += columnData;
            }
            else{
                composeString += ' ' + columnData;
            }
          
        }
        else if(compositeField && columnData.endsWith('"')){
            composeString += ' ' + columnData;
            //composeString = composeString.remove('"');
            cleanedData.add(composeString.remove('"'));
            composeString = '';
            compositeField = false;
        }
    }

    System.debug('before map list is : '+ cleanedData);
    System.debug('before map list is index 0 is : '+ cleanedData[0]);
        String tempData = cleanedData.get(16).remove(' ');
        cleanedData.add(16,tempData);
        idVsStringMap.put(cleanedData[2],cleanedData);
    
    
}

    // idVsStringMap.remove('Quote Name');
    // idVsStringMap.remove('Quote#');
    // idVsStringMap.remove('Version');
    // idVsStringMap.remove('Customer Account Name');
    // idVsStringMap.remove('#');
    // idVsStringMap.remove('Products');
    // idVsStringMap.remove('');
    List<String> productCode = new List<String>();
    List<String> Description = new List<String>();
    // List<String> productCode = new List<String>();
    for(String strr : idVsStringMap.keySet()){
      System.debug('Key : '+strr);
      System.debug('Data : '+idVsStringMap.get(strr));
      System.debug('Data 35: '+idVsStringMap.get(strr).get(16));
      System.debug('list Size : '+idVsStringMap.get(strr).size());
    //   Product pro = new Product(Name=idVsStringMap.get(strr).get(3), Active =true, Description = idVsStringMap.get(strr).get(3), productcode.idVsStringMap.get(strr).get(2) );
    // productCode.add(idVsStringMap.get(strr).get(2));
    // costList.add(idVsStringMap.get(strr).get(17));
      
    }
   CosicoTemplate.getProduct(idVsStringMap);
    System.debug('idVsStringMap>>>>'+idVsStringMap);
    // for(String str : dataList){
    //     List<String> cv = str.split(',');
    //     idVsStringMap.put(cv[0],str);
    // }
    //System.debug('idVsStringMap>>>>>'+idVsStringMap);
    return result;
}
}