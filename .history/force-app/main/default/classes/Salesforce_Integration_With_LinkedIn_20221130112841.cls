public class Salesforce_Integration_With_LinkedIn {
    
   // public static Http http = new Http();
  //  public static HTTPResponse response;
  //  public static HttpRequest request;
    
    public static void getAccessToken(){
       HttpRequest req = new HttpRequest();
        req.setMethod('GET');
       // req.setHeader('Content-Type','application/json');
        req.setEndpoint('https://www.linkedin.com/oauth/v2/accessToken');
        String CLIENT_ID = '86mkovck9p2jgg';
        String CLIENT_SECRET = 'PpFFBWspbmnDq8T1';
        String SCOPE = 'r_emailaddress r_liteprofile';
        req.setBody('grant_type=client_credentials' + '&client_id='+CLIENT_ID + '&client_secret='+CLIENT_SECRET + '&scope=USER' + '&scope='+SCOPE);
        Http http = new Http();
        HTTPResponse response = http.send(req);
        String bodyof = response.getBody();
        System.debug('Body ' + bodyof);
        System.debug('Status ' + response.getStatus());
        System.debug('Status code ' + response.getStatusCode());
    }
    
   
}