public class ContactSearch 
{
    public static List<Contact> searchForContacts(String LName, String MPcode)
    {
        
        List <Contact> cts =[SELECT Id, Name from Contact where LastName=:LName and MailingPostalCode =:MPcode];
        return cts;
    }
    
}