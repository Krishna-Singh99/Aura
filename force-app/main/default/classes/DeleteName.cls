public class DeleteName {
    public static void delname(){
        try{
        //Delete all contacts belonging to Accounts Name FIELD having 'A' in them.
        List<Contact> name=new List<Contact>();
        name = [Select Name from Contact where Account.Name like '%A%' ];
        if(name!=NULL){
           Database.delete(name,False);
        }
        else{
            System.debug('Error occured');
        }
        }catch(Exception e){
            system.debug('done');
        }
    }
}