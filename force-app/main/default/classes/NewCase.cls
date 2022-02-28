public class NewCase {
public static void addNewCase(){
    try{
    list<Case> cs = new list<Case>();
      list<contact> ss = new list<Contact>();
  ss = [Select accountid, id from Contact  limit 1];
        for(Contact st: ss){
            Case crCase = new Case();
            crCase.AccountId = st.Accountid;
            crCase.ContactId = st.Id;
            crCase.Description = 'User wants a new cloud';
            crCase.Subject = 'Software';
            crCase.Comments = ' New Case Created';
            cs.add(crCase);
        }
    if(cs!=Null){
           insert cs; 
    } 
        system.debug(cs);
    }catch(Exception e){
        system.debug(e.getCause());
        system.debug(e.getLineNumber());
        system.debug(e.getMessage());
    }
}
}