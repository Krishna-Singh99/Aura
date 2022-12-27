public class Salesforce_Integration_With_LinkedIn {
    
   // public static Http http = new Http();
  //  public static HTTPResponse response;
  //  public static HttpRequest request;
  @AuraEnabled(cacheable=true)
    public static string getAccessToken(String code){
      List<String> codevalue = code.split('code=');
     // String statevalue = codevalue.split('$state');
      System.debug('codevalue'+codevalue );
       HttpRequest req = new HttpRequest();
        req.setMethod('POST');
       // req.setHeader('Content-Type','application/json');
        req.setEndpoint('https://www.linkedin.com/oauth/v2/accessToken');
        String  grant_type = 'authorization_code';
        String CLIENT_ID = '86mkovck9p2jgg';
        String CLIENT_SECRET = 'PpFFBWspbmnDq8T1';
        String SCOPE = 'r_emailaddress r_liteprofile';
         String redirect_uri = 'https://cloudanalogy-64d-dev-ed.my.salesforce.com/services/authcallback/LinkedIn_Information';
        req.setBody('grant_type=client_credentials' + '&client_id='+CLIENT_ID + '&client_secret='+CLIENT_SECRET + '&scope='+SCOPE+'&client_authentication=send_client_credential_in_body&auth_url='+redirect_uri);
        Http http = new Http();
        HTTPResponse response = http.send(req);
        String bodyof = response.getBody();
        System.debug('Body ' + bodyof);
        System.debug('Status ' + response.getStatus());
        System.debug('Status code ' + response.getStatusCode());
        return response.getBody();
    }
    @AuraEnabled(cacheable=true)
    public static string getAuthorize(){
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      String clientid = '86mkovck9p2jgg';
      String redirect_uri = 'https://cloudanalogy-64d-dev-ed.lightning.force.com/c/Calling_LWC_LinkedIn.app';
        string aouth = '';
     // req.setHeader('Content-Type','application/json');
aouth = 'https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id='+clientid+'&redirect_uri='+redirect_uri+'&state=foobar&scope=r_liteprofile%20r_emailaddress%20w_member_social';
     
        return aouth;
    }
    @AuraEnabled
    public static void postUCG(){
         HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://api.linkedin.com/v2/ugcPosts');
        String  access_token = 'AQVPSAzruE03LT2ziwurLYbftp52Umk_BOs_4TMEWidld6oxE7_tUaC29xe8GUgrzetdSIjRWHxKZN-2g6qQrFTrE9pyTNpGf9PG5AW7Dhhdb2nnENhtPb3r8sooQv9ORjT_Kn1VoEthacxvaD8CJKdzJhomt--OXYgghrF2xCDkUhoY0P7V5zWt7BxzHBZ9UuK_iPyqdrIuB9LEXwjamqQifuDBVkYSzwKUE2TZBsFmyZgaaJtriyqKM8-70XMoUgCHakwmQP1JoToLkAnACahSyBfMP3FpyChqLJsX20DUv4EEFDzStF3y3eVnUb_1pQ4ZGVCeLPdvA3gt2H7lZhSXYKQd5A';
       // String CLIENT_ID = '86mkovck9p2jgg';
       // String CLIENT_SECRET = 'PpFFBWspbmnDq8T1';
      //  String SCOPE = 'r_emailaddress r_liteprofile';
         String redirect_uri = 'https://cloudanalogy-64d-dev-ed.my.salesforce.com/services/authcallback/LinkedIn_Information';
        req.setBody('{"author": "urn:li:person:ENp3CoDPSv","lifecycleState": "PUBLISHED","specificContent":{"com.linkedin.ugc.ShareContent": {"shareCommentary": {'+
                '"text": "500 Gateway!"'+
                    '},"shareMediaCategory": "NONE"}},'+
                    '"visibility": {"com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC"}}');
        req.setHeader('Authorization', 'Bearer '+access_token);
        req.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HTTPResponse response = http.send(req);
        System.debug('Success'+response.getBody());
        System.debug('Status Code'+response.getStatusCode());
        System.debug('Status'+response.getStatus());
    }

}