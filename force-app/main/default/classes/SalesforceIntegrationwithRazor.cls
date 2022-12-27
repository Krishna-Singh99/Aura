public class SalesforceIntegrationwithRazor {
    @AuraEnabled
    public static String createPaymentLink(Integer amount,String contact,String email,String name){
      Integer amountval = 0;
        String Nameval='';
        Integer contactval;
        String emailval='';        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Razor');
        //req.setHeader('Authorization', 'Basic cnpwX3Rlc3RfeUppTmtrWms2UTdlbXc6dGtJcVl5WG5vSXRsYTNyWmFucXlOWnho');
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setBody('{"amount": '+amount+',"currency": "INR","accept_partial": true,"expire_by": 1691097057,"description": "Payment for policy no #23456","customer": {"name": '+'"'+name+'","contact": '+'"'+contact+'","email": '+'"'+email+'"},"notify": {"sms": true,"email": true},"reminder_enable": true,"notes": {"policy_name": "Jeevan Bima"},"callback_url": "https://example-callback-url.com/","callback_method": "get"}');
       system.debug('req.getBody'+req.getBody());
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String paymentlinkId;
        Map<String, Object> reqvalueMap = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        for(String idvalue: reqvalueMap.keySet()){
            if(reqvalueMap.containsKey('short_url')){
                paymentlinkId = String.valueOf(reqvalueMap.get('short_url'));
                System.debug('idvalue>>>>'+idvalue);
            }
        }      
        return paymentlinkId;
    }
}