public class DatabaseRecords {

    public static List<Account> recordsOf100(){
        List<Account> accList = [SELECT Id,name,CreatedDate,OwnerId,Phone FROM Account limit 100];
        return accList;
    }
}