public without sharing class SendEmailHandler {
    
    @AuraEnabled
 public static string processEmail(String email, String Subject, String Message,String caseId){
    
        /*   String sMessage='';
System.debug('Message :: ' + Message);
//String sendMessage =  Message;
System.debug('UserId :: ' + userId);
try{
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
String[] toAddresses = new String[] {email}; 
mail.setToAddresses(toAddresses);
mail.setSubject(Subject);
mail.setHtmlBody(Message);
//Messaging.SendEmailResult [] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
sMessage='Success';
insert new FeedItem(
ParentId = userId, 
Title='Test Title', 
Body = Message, 
Type='TextPost'
);  
*/
        String sMessage='';  
        try{
            
            EmailTemplate emailTem = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Support: Case Response'];   
            Messaging.SingleEmailMessage emails = new Messaging.SingleEmailMessage();
           // User currUser = [Select Id,Signature from User where Id=:userinfo.getuserId()];
            // string userSignature = currUser.Signature;
            emails.setUseSignature(true);
            emails.setSaveAsActivity(true);
            emails.setTemplateId(emailTem.id);
            String htmlbody = emailTem.HtmlValue;
            String templateBody = emailTem.Body;
            system.debug('templateBody>> '+templateBody);
            templateBody = Message + '\n' + templateBody + '\n' ;
            system.debug('templateBody>>>>> '+templateBody);
          //  system.debug('htmlbody '+htmlbody);
            
           // htmlbody = Message + '\n' +  htmlbody + '\n';
          //  System.debug('htmlbody37 '+htmlbody);
            emails.setSubject(Subject);
            emails.setTreatBodiesAsTemplate(true);
            emails.setWhatId(caseId);
            String[] toAddresses = new String[] {email};
                emails.setToAddresses(toAddresses);
          // emails.setHtmlBody(htmlbody);
            emails.setPlainTextBody(templateBody);
            Messaging.SingleEmailMessage[] emailList = new Messaging.SingleEmailMessage[] {emails};
                Messaging.sendEmail(emailList);              
            System.debug(emailList[0].getToAddresses());
                    
            EmailMessage emailMsg = new EmailMessage(); // Created a EmailMessage and copy all details from above.
            emailMsg.ToAddress= email;
            emailMsg.Subject=Subject;
            //emailMsg.HtmlBody=templateBody;
            emailMsg.TextBody = templateBody;
            emailMsg.ParentId = caseId; 
            emailMsg.MessageDate = system.now();
            emailMsg.EmailTemplateId = emailTem.Id;
            emailMsg.Status = '0';
            //emailMsg.BccAddress = 'support@zenlayer.com';
            insert emailMsg;
            system.debug('emailMsg>>>>>'+emailMsg);
          /*  if(emailMsg!=null){
                Attachment attachment=new Attachment();
                attachment.Name = 'New Case Update';
                attachment.Body = Blob.ValueOf(Subject);
                attachment.ParentId = emailMsg.Id; 
                insert attachment;
            }   */
        }
        catch(Exception ex){
            sMessage=ex.getLineNumber()+'\n'+ex.getCause()+'\n'+ex.getMessage()+'\n'+ex.getStackTraceString();
        }
        return sMessage;
    }
}