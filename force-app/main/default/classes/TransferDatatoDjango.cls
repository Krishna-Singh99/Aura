@RestResource(urlMapping='/Contactsss/*')
global with sharing class TransferDatatoDjango {
    @HttpGet
    global static List<Contact> doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        //String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<Contact> result = [SELECT Id, LastName,Firstname FROM Contact];
        system.debug('result>>>>'+result);
        return result;
    }
    
    @HttpPost
    global static void doPost() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        System.debug('19>>>'+req);
        Blob blobData = req.requestBody;
        Contact con = [Select id from contact where name like '%Theory%' Limit 1];
        Attachment att=new Attachment();
        att.Body=blobData;
        att.Name='Note_' + System.now().format('yyyy_MM_dd_hh_mm_ss') + '.txt';
        att.parentId=con.id;
        insert att;
        
        /* For string type data   */
        //  String requestData = blobData.toString(); 
        // System.debug('21>>>'+requestData);
        System.debug('20>>>'+res);
        //        Map<String,object> mapData= (Map<String,object>) JSON.deserializeUntyped(requestData);
        // for(String keyData : mapData.keySet()){
        //   System.debug('22>>>'+mapData.get(keyData));
        // }
        //  System.debug('23>>>'+mapData.get('FirstName'));
        //    System.debug('24>>>'+mapData.get('LastName'));      
    }
}