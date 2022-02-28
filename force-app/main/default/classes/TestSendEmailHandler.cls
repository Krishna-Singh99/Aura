@isTest
private  class TestSendEmailHandler {
   
     static testmethod void testEmailHandlerClass() {
            Case testCase = new Case(Subject = 'Test',origin = 'Instant Messager', status='new');
            insert testCase;
            String email = 'xyz@gmail.com';
            String Subject = 'Test Subject';
            String Message = 'Test Message';
            String caseId = testCase.id;
        
        Test.startTest();
        String validate = SendEmailHandler.processEmail(email,Subject,Message,caseId);
        Test.stopTest();
    
        System.assert(true,String.isNotBlank(validate));
    } {

    }
}