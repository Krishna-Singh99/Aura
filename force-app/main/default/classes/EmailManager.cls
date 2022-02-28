public class EmailManager {
   public static String sendmail(String address, String subject, String body, String Bcc, String Cc, String caseId) {
      EmailMessage emailMsg = new EmailMessage(); // Created a EmailMessage and copy all details from above.
             emailMsg.ToAddress= address;
             emailMsg.Subject=Subject;
             //emailMsg.HtmlBody=templateBody;
             emailMsg.TextBody = body;
             emailMsg.ParentId = caseId; 
             emailMsg.MessageDate = system.now();
       if(Bcc != ''){
            emailMsg.BccAddress = Bcc;
       }
       if(Cc != ''){
            emailMsg.CcAddress = Cc;
       }
      
            // emailMsg.EmailTemplateId = emailTem.Id;
             emailMsg.Status = '0';
             //emailMsg.BccAddress = 'support@zenlayer.com';
             insert emailMsg;
        return 'Success';
    }
}