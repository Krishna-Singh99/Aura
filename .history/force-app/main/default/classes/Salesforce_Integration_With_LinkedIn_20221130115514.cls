public class Salesforce_Integration_With_LinkedIn {
    
   // public static Http http = new Http();
  //  public static HTTPResponse response;
  //  public static HttpRequest request;
    
    public static void getAccessToken(){
       HttpRequest req = new HttpRequest();
        req.setMethod('POST');
       // req.setHeader('Content-Type','application/json');
        req.setEndpoint('https://www.linkedin.com/oauth/v2/accessToken');
        String  grant_type = 'authorization_code';
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
    
    public static void getAuthorize(){
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      String clientid = 'ENp3CoDPSv';
      String redirect_uri = 'https://cloudanalogy-64d-dev-ed.my.salesforce.com/services/authcallback/LinkedIn_Information';
     // req.setHeader('Content-Type','application/json');
      req.setEndpoint('https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id='+clientid+'&redirect_uri='+redirect_uri+'&state=foobar&scope=r_liteprofile%20r_emailaddress%20w_member_social');
      Http http = new Http();
      HTTPResponse response = http.send(req);
      System.debug('response '+ response);
      System.debug('body '+ response.body);
    }
   
}