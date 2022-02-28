public class TwitterIntegrationWithSalesforce {
    
    public String retrieveAccessToken(){
        String API_Key='J9Jwk4vsbs2euxsI4WUCyaCS7';
        //EncodingUtil.urlEncode(Twitter_API_Settings__c.getInstance( 'API Key' ).value__c, 'UTF-8');
        String API_Secret_Key='RTihaFaiyw7xjM46ErIPBs4hf1uRiYuhAaRV6JxfLlcL7tC9o0';
        //EncodingUtil.urlEncode(Twitter_API_Settings__c.getInstance( 'API Secret Key' ).value__c, 'UTF-8');      
        
        String Consumer_API_key=API_Key + ':' + API_Secret_Key;
        
        Blob httpRequestHeader=Blob.valueOf(Consumer_API_key);
        System.debug('Twitter HeaderBlob ' + httpRequestHeader);        
        
        HttpRequest req=new HttpRequest();
        req.setEndpoint('https://api.twitter.com/oauth2/token');
        req.setMethod('POST');        
        
        string basicAuthorizationHeader='Basic ' + EncodingUtil.base64Encode(httpRequestHeader);
        req.setHeader('Authorization',basicAuthorizationHeader);
        req.setBody('grant_type=client_credentials');        
        System.debug('Twitter Http request ' + req);        
        
        Http http=new Http();        
        HttpResponse res=http.send(req);
        String accessToken;        
        if(res.getStatusCode()==200)
        {
            JSONParser parser=JSON.createParser(res.getBody());
            System.debug('Twitter JSON response ' + parser);
            while(parser.nextToken()!=null)
            {
                if(parser.getCurrentToken()==JSONToken.FIELD_NAME && parser.getText() == 'access_token')
                {
                    parser.nextToken();
                    accessToken=parser.getText();
                }
            }
        }
        return accessToken;
    }
    public   class users {
        public String id;
        public String id_str;
        public String name;
        public String screen_name;
        public String location;
        public String description;
        public Integer followers_count;
        public Integer friends_count;
        public Integer listed_count;
        public String profile_image_url;
        public String profile_image_url_https;
        
        public List<users> parse(String json) {
            return (List<users>) System.JSON.deserialize(json, List<users>.class);
        }
    }
    
    // Method to get twitter user's information and desearlize into above class
    
    public users getTwitterInfo(string twitterHandle)
    {
        HttpRequest req=new HttpRequest();
        req.setEndpoint('https://api.twitter.com/1.1/users/lookup.json?screen_name='+twitterHandle);
        req.setMethod('GET');
        String bearerAuthorizationHeader='Bearer '  + retrieveAccessToken();
        req.setHeader('Authorization',bearerAuthorizationHeader);
        
        Http http=new Http();
        System.debug('Twitter Request :- ' + req);
        HttpResponse res=http.send(req);
        if(res.getStatusCode()!=200)
        {
            System.debug('Twitter Response :- ' + res.getBody());
            return null;
        }
        String sBody=res.getBody();
        System.debug('Twitter sBody :- ' + sBody);
        
        Map <String, users> TwitterResultsMap = new Map<String, users> ();
        users tObj=new users();
        List<users> tresult=tObj.parse(sBody);
        
        for(users t: tresult)
        {
            TwitterResultsMap.put(t.screen_name,t);
        }
        System.debug('TwitterResultsMap :- ' + TwitterResultsMap);
        return TwitterResultsMap.get(twitterHandle);        
    }
    
}