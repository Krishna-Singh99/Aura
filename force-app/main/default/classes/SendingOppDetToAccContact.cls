public class SendingOppDetToAccContact {
    public static void Oppcc(){
        list<opportunity> opp = new list<opportunity>([SELECT AccountId FROM Opportunity where accountid!=null and closeDate <= Next_n_days:10 ]);
            system.debug(opp);
        list<contact> con = new list<contact>();
        con = [SELECT Id, Email,Name,AccountId FROM Contact where Accountid  =: opp[0].AccountId];
        system.debug(con);
        for(Contact yash: con){
            
            opportunity oppc = new opportunity();
            oppc.ContactId = yash.Id;
            oppc.AccountId = yash.AccountId;
                 List<string> tobody = New List<string>();
                 List<string> toaddress = New List<string>();
            tobody.add(yash.id);
            tobody.add(yash.Name);
            system.debug('  '+ tobody);
             Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            string str = '';
                str  = str + oppc.ContactId + 'Contact id' + yash.Name + ' Contact Name' + oppc.Accountid + 'AccountId' + oppc.Id + 'Opportunity Id';
               
            toaddress.add(yash.Email);
                                   email.setSubject('Testing Apex Scheduler-Subject');
                                    email.setPlainTextBody('Hello my name is suzi'+ str);
                             
                                     email.setTargetObjectId( UserInfo.getUserId() );
                                     email.setSaveAsActivity( false );
                                    email.setToAddresses(toaddress);
                                   Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                                    system.debug('Successfull' + str);   
        
        }  
    }
}