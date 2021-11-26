public class InsertImg {
    public static void insrtJpg(){
        try{
            list<Attachment> ach = new list<Attachment>();
            list<Contact> s1o = [Select accountid,id  from Contact where account.name != null limit 1];
            system.debug(s1o);
            set<id> setId = new set<Id>();
            for(Contact con : s1o){
                setId.add(con.Accountid);
            }
            list<Attachment> attch = [Select name,parentId, body from Attachment where  parentId in : setId];
            system.debug(s1o);
            for(Contact solo: s1o){
                
                for(Attachment am: attch){
                    
                    Attachment con = new Attachment();
                    con.ParentId = solo.Id;
                    con.Name = 'Account Attachment';
                    con.Body = am.body;
                    ach.add(con);
                }
                insert ach;
                system.debug('Insertion Done');
                
            }
        }catch(Exception e){
            
        }
    }
    
}