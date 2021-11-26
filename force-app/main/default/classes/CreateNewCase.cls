public class CreateNewCase {
    public static void addNewCase(){
        try{
    list<Case> cs = new list<Case>();
        Account acc = [Select id from Account Limit 1];
        Contact con = [Select id from Contact Limit 1];
        for(integer i=0;i<5;i++){
            Case crCase = new Case();
            crCase.AccountId = acc.Id;
            crCase.ContactId = con.Id;
            crCase.Description = 'User wants a new cloud';
            crCase.Subject = 'Software';
            crCase.Comments = ' New Case Created';
            cs.add(crCase);
        }
        insert cs;
        system.debug(cs);
        }Catch(Exception e){
            system.debug(e.getCause());
        }
    }
}