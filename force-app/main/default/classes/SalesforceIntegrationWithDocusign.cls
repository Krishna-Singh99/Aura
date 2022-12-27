public class SalesforceIntegrationWithDocusign {
 Static String documentBaseCode {get;set;}
    @AuraEnabled 
    public static List<Contact> getContact(String accountId){
        try{
            List<Contact> conList = [SELECT Id, FirstName, LastName, Email, AccountId FROM Contact WHERE AccountId = :accountId AND Email != null];
            if(conList != null && !conList.isEmpty()){
                return conList;
            }
        }
        catch(Exception Err){
            System.debug(Logginglevel.ERROR, 'Exception || Line number : '+Err.getLineNumber()+' | Cause is : '+Err.getCause()+' | Message is : '+Err.getMessage()+' | Trace is : '+Err.getStackTraceString());
        }
        return null;
    }
    @AuraEnabled 
    public static Attachment getAttachment(String accountId){
        try{
            
            Attachment attchmnt = [SELECT Id, ParentId, Name, Body, ContentType FROM Attachment WHERE ParentId =:accountId LIMIT 1];
            if(attchmnt != null){
                documentBaseCode = EncodingUtil.Base64Encode(attchmnt.Body);
                return attchmnt;
            }
        }catch(Exception Err){
            System.debug(Logginglevel.ERROR, 'Exception || Line number : '+Err.getLineNumber()+' | Cause is : '+Err.getCause()+' | Message is : '+Err.getMessage()+' | Trace is : '+Err.getStackTraceString());
        }
        return null;
    }
    @AuraEnabled 
    public static void sendEmail(List<Contact> conInfoList, String accountId){
        try{
            System.debug('accountId : '+accountId);
            Integer recipientId = 1;
            Attachment docFile = getAttachment(accountId);
            String recipient=''; 
            if(conInfoList != null && !conInfoList.isEmpty() && docFile != null){
                for(Contact obj :conInfoList){
                   recipient+='{"email":"'+obj.Email+'","name":"'+obj.FirstName+' '+obj.LastName+'","recipientId":"'+recipientId+'","tabs":{"signHereTabs":[{"documentId": "1221", "pageNumber": "1","xPosition": "430", "yPosition": "380",}],"dateTabs": [{"documentId": "1221", "pageNumber": "1","xPosition": "100", "yPosition": "390",}],},},';
                   recipientId+=1;
                }
            }
            sendEnevolpe(recipient, docFile);         
        }catch(Exception Err){
            System.debug(Logginglevel.ERROR, 'Exception || Line number : '+Err.getLineNumber()+' | Cause is : '+Err.getCause()+' | Message is : '+Err.getMessage()+' | Trace is : '+Err.getStackTraceString());
        }
    }

    public static Boolean sendEnevolpe(String recipients, Attachment docFile){
        try{
            DocuSignAuthorization__c hashValue = [SELECT Id, AccessToken__c, Hash_Value__c, Client_Id__c, Client_Secret__c, Template_Id__c FROM DocuSignAuthorization__c LIMIT 1];
            if(recipients != null && String.isNotBlank(recipients) && docFile != null){
                String document = EncodingUtil.Base64Encode(docFile.Body);
                System.debug('document>>> '+docFile.Name);
                List<String> docInfo = docFile.Name.split('\\.');
                System.debug('docInfo>>> '+docInfo[1]);
                HttpRequest req = new HttpRequest();
            req.setEndpoint('https://account-d.docusign.com/oauth/v2.1/accounts/envelopes');                                               
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization','Bearer '+hashValue.AccessToken__c);
            req.setBody('{"documents" :[{"documentBase64":"'+document+'","documentId":1221,"fileExtension": "'+docInfo[1]+'","name": "'+docInfo[0]+'"}],"emailSubject": "Warranty Agreement","recipients":{"signers": ['+recipients+']},"status": "sent"}');
            Http http = new Http();
            HttpResponse res = http.send(req);
            System.debug('code : '+res.getStatusCode());
            System.debug('code : '+res.getStatus());
            System.debug('res : '+res.getBody());
            if(res.getStatusCode() == 201){
                return true;
            }else if(res.getStatusCode() == 401 && res.getStatus() == 'Unauthorized'){
                return false;
            }
                
            }
        }catch(Exception Err){
            System.debug(Logginglevel.ERROR, 'Exception || Line number : '+Err.getLineNumber()+' | Cause is : '+Err.getCause()+' | Message is : '+Err.getMessage()+' | Trace is : '+Err.getStackTraceString());
        }
        return null;
    }
}