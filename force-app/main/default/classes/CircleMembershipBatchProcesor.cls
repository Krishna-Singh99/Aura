global class CircleMembershipBatchProcesor implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    
    // Start Method
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String apexClassId = '01p1U00000QoPw6QAF';
        List<AsyncApexJob> jobs = [SELECT CreatedDate FROM AsyncApexJob WHERE JobType = 'BatchApex' AND ApexClassId =: apexClassId ORDER BY CreatedDate DESC LIMIT 1];
        DateTime jobDate = null;
        if (jobs != null && jobs.size() > 0) {
            System.debug('using AsyncApexJob');
            AsyncApexJob job = jobs[0];
            jobDate = job.CreatedDate;
        } else {
            System.debug('using System.now()');
            jobDate = System.now().addHours(-1);
        }
        String dateStr = jobDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ');
        System.debug(dateStr);
        String Query='SELECT Id, FirstName, LastName, Email, npo02__MembershipJoinDate__c, npo02__MembershipEndDate__c, npo02__LastMembershipDate__c FROM Contact WHERE npo02__MembershipJoinDate__c != NULL AND (CreatedDate > ' + dateStr + ' OR LastModifiedDate > ' + dateStr + ')';
        return Database.getQueryLocator(Query);
    }
    // Execute Method
    global void execute(Database.BatchableContext bc, List<Contact> scope){
        String JSONString = JSON.serialize(scope);
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        Http http = new Http();
        
        // Retrieve username and password from Custom Setting
        //     CircleMembershipBatchSettings__c myCS1 = CircleMembershipBatchSettings__c.getValues('default');
          String username = 'kk';
              //myCS1.username__c;
           String password = '12345';
              //myCS1.password__c;
        
        // Add basic authentication to header        
        // Create blob of user:pass
        Blob headerValue = Blob.valueOf(username + ':' + password);
        // Base 64 Encode the blob and prepend "Basic "
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        // Add the basic auth string to the Request Header
        request.setHeader('Authorization', authorizationHeader);
        
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint('https://th-webhook-test.herokuapp.com/webhook');
        request.setMethod('POST');
        request.setBody(JSONString);
        response = http.send(request);
        if (response.getStatusCode() == 200) {
            String jsonResponse = response.getBody();
            System.debug('Response-' + jsonResponse);
            System.debug(JSONString);
        } else {
            throw new applicationException('Callout was not successful');
        }
    }
    // Finish Method
    global void finish(Database.BatchableContext bc){
        Id job= bc.getJobId();
        System.debug(job);
    }
    public class applicationException extends Exception {}
}