public class UpdateCloseDate {
 
     @AuraEnabled
    public static Opportunity fetcOpp(String oppId, Date cldt){
        Opportunity showOpp = new Opportunity(CloseDate = cldt);
        showOpp.put('id', oppId);        
        update showOpp;
        return showOpp;
    }
}