public class Salesforce_Integration_With_LinkedIn {
    
   // public static Http http = new Http();
  //  public static HTTPResponse response;
  //  public static HttpRequest request;
  @AuraEnabled
    public static String getAccessToken(List<String> code){
       HttpRequest req = new HttpRequest();
        req.setMethod('POST');
       // req.setHeader('Content-Type','application/json');
        req.setEndpoint('https://www.linkedin.com/oauth/v2/accessToken');
        String codevalue = code[0];
        System.debug('codevalue'+codevalue);
        String  grant_type = 'authorization_code';
        String CLIENT_ID = '86mkovck9p2jgg';
        String CLIENT_SECRET = 'PpFFBWspbmnDq8T1';
        String SCOPE = 'r_emailaddress r_liteprofile';
         String redirect_uri = 'https://cloudanalogy-64d-dev-ed.lightning.force.com/c/Calling_LWC_LinkedIn.app';
        req.setBody('grant_type=authorization_code' + '&code=' + codevalue +'&client_id='+CLIENT_ID + '&client_secret='+CLIENT_SECRET +'&redirect_uri='+redirect_uri);
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        Http http = new Http();
        HTTPResponse response = http.send(req);
        String bodyof = response.getBody();
        Map<String,Object> newAccessToenmap = (Map<String,Object>)Json.deserializeUntyped(response.getbody());
        System.debug('Body ' + bodyof);
        //Map<String,String> info = new Map<String,String>();
        System.debug('Status ' + response.getStatus());
        System.debug('Status code ' + String.valueOf(newAccessToenmap.get('access_token')));
         String info = Salesforce_Integration_With_LinkedIn.getUserInformation(String.valueOf(newAccessToenmap.get('access_token')));
        return info;
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
    @AuraEnabled
    public static String getUserInformation(String access_token){
      System.debug('68'+access_token);
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      req.setEndpoint('https://api.linkedin.com/v2/me?projection=(id,firstName,lastName,profilePicture(displayImage~:playableStreams))');
      req.setHeader('Authorization', 'Bearer '+access_token);
      req.setHeader('content-type','application/json');
     Http http = new http();
     HTTPResponse res = http.send(req);
     Map<String,Object> newAccessToenmap = (Map<String,Object>)Json.deserializeUntyped(res.getbody());
     System.debug('firstname>>>>'+res.getbody());
     Map<String,String> fieldVsValueMap = new Map<String,String>();
     for(String newvalue:newAccessToenmap.keySet()){
      fieldVsValueMap.put(newvalue,String.valueOf(newAccessToenmap.get('newvalue')));
     }
     system.debug('fieldVsValueMap>>>>>'+fieldVsValueMap);
        return res.getbody();
    }

}