public class MapQuery {
    public static void mapq(){
        try{
        list<Account> acc = [Select Id, Name from Account where name like '%Tst149%'];
        set<id> setIs = new set<id>();
        for(Account cc : acc){
            setIs.add(cc.id);
        }
        list<Contact> con = [select id,name from contact where Accountid in: acc];
        system.debug('contact id>>>' + con);
        map<id,list<contact>> lapy = new map<id, list<contact>>();
        for(Account accList:acc){
             lapy.put(accList.id,con);
        }
      // 
        
        system.debug('map>>>'+lapy.keySet());
          system.debug('map>>>'+lapy);
        }catch(Exception e){
            system.debug(e.getCause());
        }
    }
}