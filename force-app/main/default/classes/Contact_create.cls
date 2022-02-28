public class Contact_create {
    public static void newContact(String str){
        try{
        list<Contact> con = new list<Contact>();
        for(integer i=0;i<10;i++){
            Contact ct = new Contact();
            ct.LastName=str+i;
            con.add(ct);
        }
        insert con;
        }catch(Exception e){
            system.debug(e.getCause());
        }
    }
}