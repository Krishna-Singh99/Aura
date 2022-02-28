public class SalesforceToSalesforceIntegration {

    public static String restServiceorg2Domain = 'https://cloudanalogy-6d7-dev-ed.my.salesforce.com';
    public static String getAuthToken(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        String token= '';
        
        Account__c setting = Account__c.getOrgDefaults();
        System.debug('setting>>>>>'+setting);
        String clientId = '3MVG9fe4g9fhX0E7khnAQsdWBd7STCeKbuDhiHqkoubg53qZxvFgWVAOyRa3vGqdcLHV7cmY0wu0Er4IBtiZ1';
        String clientSecret = 'BABB6453EAA0BBDD743A3395AEAA154C7316855D28455F5BE03ACD3C9D9561D2';
        req.setMethod('POST');
        req.setEndPoint(restServiceorg2Domain + '/services/oauth2/token');
        req.setBody('grant_type=password'+'&client_id='+ clientId + '&client_secret=' 
                   + clientsecret + '&username=' + EncodingUtil.urlEncode(Setting.username__c, 'UTF-8') +
                   '&password=' + EncodingUtil.urlEncode(Setting.password__c+setting.Security_Token__c, 'UTF-8')
                   );
        HttpResponse res = Http.send(req);
        System.debug('res>>> \n'+res);
        Map<String,Object> result = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        system.debug('result>>>>'+result);
        for(String data : result.keySet()){
            if(data == 'access_token'){
                token = result.get(data).toString();
            }
        }
        return token;
    }
    public Static void callGetMethod(String accountId){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        
            req.setEndpoint(restServiceorg2Domain+'/services/apexrest/Account/'+accountId);
            req.setHeader('Authorization', 'Bearer'+'AaZGdxW1gIiltPel3SjcOwXw');
            req.setHeader('Content_Type', 'application/json');
        
        HttpResponse res = http.send(req);
    }
}