public with sharing class GoogleWebService {
      
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
 
    public static void getProfile(String userEmail) {
 
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:Gmail/gmail/v1/users/' + userEmail + '/profile');
 
        response = http.send(request); 
     
        System.debug('Inside profile'+response.getBody());
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        System.debug(results);
    }
 
    public static void getUserDrafts(String userEmail) {
 
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:Gmail/gmail/v1/users/' + userEmail + '/drafts');
         
        response = http.send(request); 
 
        System.debug('Inside draft'+response.getBody());
    }
 
  
}