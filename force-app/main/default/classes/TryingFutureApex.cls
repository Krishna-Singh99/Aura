public class TryingFutureApex {
@future
    public static void recover(List<Id> rec){
        Database.undelete(rec);
    }
}