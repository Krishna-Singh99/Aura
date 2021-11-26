public class EmailManager {
   public static void sendmail(String address, String subject, String body) {
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        string[] toaddress = new String[]{address};
            mail.setToAddresses(toaddress);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        Messaging.SendEmailResult[] result = Messaging.sendEmail(
                                 new Messaging.SingleEmailMessage[] { mail });
    }
    private static Boolean inspectResult(Messaging.SendEmailResult[] result){
        Boolean sendresult = true;
        for(Messaging.SendEmailResult res: result){
            if(res.issuccess()){
            system.debug('Email sent successfully');
            }
            else{
                sendresult=false;
                System.debug('The following error occured'+ res.getErrors());
            }
        }
        return sendresult;
    }
}