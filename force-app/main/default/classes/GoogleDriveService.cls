public with sharing class GoogleDriveService {
      
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    
    public static void getFile() {
 
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('https://www.googleapis.com/drive/v2/files/folderId/children');
 
        response = http.send(request); 
 
        System.debug(response.getBody());
    }
}