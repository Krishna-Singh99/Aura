@RestResource(urlMapping='/LinkedIn/*')
global with sharing class MyRestResource {
    @HttpGet
    global static void doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String userid = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        System.debug('userid>>>'+userid);
      //  return result;
    }

}