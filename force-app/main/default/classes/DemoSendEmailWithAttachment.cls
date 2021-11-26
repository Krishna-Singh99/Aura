public class DemoSendEmailWithAttachment
{
    public static void SendEmailWithAttachment()
    {
        String subject = 'Closed won opportunities with Amount';
        String body = 'This is testing for Send emails with attachment from your apex class in Salesforce';
 
    // Creating the CSV file
    String finalstr = 'Id, Name, Amount \n';
 String attName = 'Closed won opportunities.csv'; 
 
  // get all the closed won opportunities
    for (Opportunity myOpportunity : [SELECT ID, Name, Amount FROM Opportunity WHERE StageName = 'Closed Won' limit 1])
        {
     string recordString = '"'+myOpportunity.id+'","'+myOpportunity.Name+'","'+myOpportunity.Amount+'"\n';
            finalstr = finalstr +recordString;
 }
 // Define the email
 Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
 // Create the email attachment    
 Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
 efa.setFileName(attName);
 efa.setBody(Blob.valueOf(finalstr));
  // Set the paramaters to the email object
 email.setSubject( subject );
 
 // Here I am accessing current user email id to whom we are sending email
   email.setToAddresses( new String[] {UserInfo.getUserEmail()} );
 email.setPlainTextBody( body );
 
 // Attach file using setFileAttachments function
 email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
 // Sends the email
 Messaging.SendEmailResult [] r = 
 Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
    }
}