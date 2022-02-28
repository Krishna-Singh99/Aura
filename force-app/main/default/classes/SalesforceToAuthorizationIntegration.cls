public class SalesforceToAuthorizationIntegration {
    
    public static void authorizationNet() {
        HTTP h = new HTTP();
        
        HTTPRequest r = new HTTPRequest();
        
        r.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        
        Blob headerValue = Blob.valueOf('krishna44theman' + ':' + 'Karansingh44@');
        
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        
        r.setHeader('Authorization', authorizationHeader);
        
        r.setMethod('GET');
        System.debug('r>>>>>>'+r);
        HttpResponse res = h.send(r);
        system.debug('res>>>>>>'+res);
    }
    
    
    public static void authorizationNetPost(){
        HTTP h = new HTTP();
        
        HTTPRequest r = new HTTPRequest();
        
        r.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
        
        Blob headerValue = Blob.valueOf('krishna44theman' + ':' + 'Karansingh44@');
        
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        
        r.setHeader('Authorization', authorizationHeader);
        
        r.setMethod('POST');              
    }
}