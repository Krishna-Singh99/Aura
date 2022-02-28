trigger NewCommentsOnCase on CaseComment (before Insert, after Insert) {

for(CaseComment cc : Trigger.new){
  if(cc.CommentBody != NULL){
  Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
message.toAddresses = new String[] { 'krishna.kumar@cloudanalogy.com' };
message.optOutPolicy = 'FILTER';
message.subject = 'Customer Updated Case';
message.plainTextBody = cc.CommentBody;
Messaging.SingleEmailMessage[] messages = 
    new List<Messaging.SingleEmailMessage> {message};
         Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
if (results[0].success) {
    System.debug('The email was sent successfully.');
} else {
    System.debug('The email failed to send: '
          + results[0].errors[0].message);
}
  }
}
}