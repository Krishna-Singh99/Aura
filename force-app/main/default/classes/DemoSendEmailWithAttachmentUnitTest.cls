@isTest
private class DemoSendEmailWithAttachmentUnitTest {
    
    @isTest
    static void TestDemoSendEmailWithAttachment(){
        string finalstr = 'Test';
        Opportunity myOpportunity = new Opportunity(Name='Opp',stagename='Close Won', CloseDate=date.today(),Amount=30);
        string recordString = '"'+myOpportunity.id+'","'+myOpportunity.Name+'","'+myOpportunity.Amount+'"\n';
        finalstr = finalstr +recordString;
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('Demo');
        efa.setBody(Blob.valueOf(finalstr));
        email.setSubject( 'Test' );
        email.setToAddresses( new String[] {UserInfo.getUserEmail()} );
        email.setPlainTextBody( recordString );
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
        Test.startTest();
        DemoSendEmailWithAttachment.SendEmailWithAttachment();
        Test.stopTest();
    }
    
}