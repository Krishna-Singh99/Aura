public class Salesforce_Integration_With_LinkedIn {
    
   // public static Http http = new Http();
  //  public static HTTPResponse response;
  //  public static HttpRequest request;
  @AuraEnabled
    public static String getAccessToken(List<String> code){
      try {
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
        if(response.getStatusCode() == 200 || response.getStatusCode() == 201){
          String bodyof = response.getBody();
          Map<String,Object> newAccessToenmap = (Map<String,Object>)Json.deserializeUntyped(response.getbody());
          System.debug('Body ' + bodyof);
          //Map<String,String> info = new Map<String,String>();
          System.debug('Status ' + response.getStatus());
          System.debug('Status code ' + String.valueOf(newAccessToenmap.get('access_token')));
           String info = Salesforce_Integration_With_LinkedIn.getUserInformation(code[0],String.valueOf(newAccessToenmap.get('access_token')));
          // Map<String,Object> idVsValuemap = (Map<String,Object>)JSON.deserializeUntyped(info);
          return info;
        }
        else{
          return '400';
        }
      } catch (Exception e) {
        System.debug(e);
      }
      return '500';
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
    public static Integer postUCG(String code, String text){
      Integer statuscode=401;
      try {
        LinkedIn_Information__c linkdata = new LinkedIn_Information__c();
        
        if(code !=null && String.isNotEmpty(code) &&  String.isNotBlank(code) && text !=null && String.isNotEmpty(text) &&  String.isNotBlank(text)){
          linkdata = [SELECT Name, Expires_In_Seconds__c, LinkedIn_code__c, AuthResponse__c, Access_Token__c, Id FROM LinkedIn_Information__c WHERE LinkedIn_code__c =:code  limit 1];
          System.debug('linkdata'+linkdata);
          HttpRequest req = new HttpRequest();
          req.setMethod('POST');
          req.setEndpoint('https://api.linkedin.com/v2/ugcPosts');
           String redirect_uri = 'https://cloudanalogy-64d-dev-ed.lightning.force.com/c/Calling_LWC_LinkedIn.app';
          req.setBody('{"author": "urn:li:person:ENp3CoDPSv","lifecycleState": "PUBLISHED","specificContent":{"com.linkedin.ugc.ShareContent": {"shareCommentary": {'+
                  '"text":'+ text + 
                      '},"shareMediaCategory": "NONE"}},'+
                      '"visibility": {"com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC"}}');
          req.setHeader('Authorization', 'Bearer '+linkdata.Access_Token__c);
          req.setHeader('Content-Type', 'application/json');
          Http http = new Http();
          HTTPResponse response = http.send(req);
          System.debug('Success'+response.getBody());
          System.debug('Status Code'+response.getStatusCode());
          System.debug('Status'+response.getStatus());
          statuscode = response.getStatusCode();
          return response.getStatusCode();
        }
       return statuscode;
      } catch (Exception e) {
        System.debug('e>>>>'+e.getMessage());
      }
      return statuscode;
    }
    @AuraEnabled
    public static String getUserInformation(String code, String access_token){
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
     LinkedIn_Information__c newlinkedindata = new LinkedIn_Information__c();
           newlinkedindata.Name = res.getbody().id;
           newlinkedindata.Access_Token__c = access_token;
           newlinkedindata.LinkedIn_code__c = code;
           if(newlinkedindata !=null){
            insert newlinkedindata;
           }
        return res.getbody();
    }

}