public with sharing class IntegrateWithAuthorizeNet {
    @AuraEnabled
    public static Boolean IntegrateWithAuthorizeNet(String cardNumber, String expirationDate, String cardCode) {
        try{
        if(cardNumber != null && expirationDate != null && cardCode != null ){
        System.debug(cardNumber+expirationDate+cardCode);
        List<AuthorizeNet__c> mcs = AuthorizeNet__c.getall().values();
        String url='';
        Boolean isCode;
        for(AuthorizeNet__c acz : mcs){
            url = acz.Endpoint_URL__c;
        }
        String name = '3tNn28Dkd27';
         Http httpObject = new Http();
         HttpRequest request = new HttpRequest();
         request.setEndpoint(url);
         request.setMethod('POST');
         request.setBody('{ "createTransactionRequest": { "merchantAuthentication": {"name": "'+name+'", "transactionKey": "23L38M948eAwWkY6"}, "refId": "12385564","transactionRequest": {"transactionType": "authCaptureTransaction","amount": "550", "payment": {"creditCard": {"cardNumber": "5424000000000015","expirationDate": "'+expirationDate+'","cardCode": "'+cardCode+'"}}}}}');
         HttpResponse response = httpObject.send(request);
         System.debug('response>>>'+response);
         String responseBody = response.getBody();
         String[] elements = responseBody.split(' ');
         System.debug('responseBody>>>>'+responseBody);
         System.debug('responseBody>>>>'+elements);
          isCode = responseBody.contains('successful');
         System.debug('responseBody>>>>'+isCode);
       //  Map<String, Object> m =(Map<String, Object>)JSON.deserializeUntyped(responseBody);
        // List<Object> a = (List<Object>)m.get('accessories');
         
        // System.debug('m>>>>'+m);
         return isCode;
    }else{
        return false;
    }
}catch(Exception e){
    System.debug(e.getMessage()+e.getLineNumber());
    return null;
}
   
    }
}