public class BatchLead implements Database.Batchable<sobject>,  Database.stateful{
    public String Records = 'Id' +','+ 'Name' +','+ 'Company' + '\n ' ;
    public  Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([Select id,name,Company from Lead where CreatedDate = Today and Phone = null]);
    }
    public void execute(Database.BatchableContext dbc,List<Lead> leadList){
        if(leadList!=null){
             system.debug(leadList);
        for(Lead ld : leadList){
            system.debug('Leadid>>>>>'+ld.id);
           String Details  =  String.valueOf(ld.id) +','+ String.valueOf(ld.Name)  +','+ String.valueOf(ld.Company) + '\n';  
            Records += Details;
        }
        system.debug(Records);
        }
       
    }
    public void finish(Database.BatchableContext dbc){
       // User pr = [Select email from User where Profile.name = 'System Administrator' limit 1]; 
       // EmailManager.sendMail(pr.email, 'List', Records);
       
       Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
        blob csvBlob = Blob.valueOf(Records);
        string csvname= 'LeadReport.csv';
        csvAttc.setFileName(csvname);
        csvAttc.setBody(csvBlob);
        
        Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
        String[] toAddresses = new list<string> {userInfo.getUserEmail()};
            String subject ='Lead Report';
        email.setSubject(subject);
        email.setToAddresses( toAddresses );
        email.setPlainTextBody('Lead Report ');
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
        Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
        
    }
}