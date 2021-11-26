public class ObjectListClass {
    @AuraEnabled
    public static List<String> fetchObjectName(){
        List<String> objects = new List<String>();
        List<Schema.SObjectType> globalDb = Schema.getGlobalDescribe().Values();  
        for(SObjectType sot:globalDb){
            if(sot.getDescribe().getName() == 'Account' || sot.getDescribe().getName() == 'Contact' || sot.getDescribe().getName() == 'lead' || sot.getDescribe().getName() == 'Opportunity')
                objects.add(sot.getDescribe().getName());
            objects.sort();  
        }
        return objects;
    }
    @AuraEnabled
    public static List<String> fetchObjectfields(String str){
        SObjectType accountType = Schema.getGlobalDescribe().get(str);
        Map<String,Schema.SObjectField> mfields = accountType.getDescribe().fields.getMap();
        List<String> sobjFieldName = new List<String>();
        for(String fld: mfields.keySet()){
            String sn = String.valueOf(mfields.get(fld));
            sobjFieldName.add(sn);
        }
        return sobjFieldName; 
    }
    @AuraEnabled
    public static String fetchObjectfieldsType(String fldtype,String str){
        SObjectType r = ((SObject)(Type.forName('Schema.'+str).newInstance())).getSObjectType();
        DescribeSObjectResult dsr = r.getDescribe();
        return String.valueOf(dsr.fields.getMap().get(fldtype).getDescribe().getType());
        
    }
    @AuraEnabled
    public static List<String> fetchObjectfieldsTypeApi(String fldtypeapi,String fldlabel){
        SObjectType accountType = Schema.getGlobalDescribe().get(fldlabel);
        List<String> setApi = new  List<String>();
        Map<String,Schema.SObjectField> mfields = accountType.getDescribe().fields.getMap();
        for(String fldapi : mfields.Keyset()){
            if(fldapi==fldtypeapi){
                system.debug('mfields'+fldapi);
                setApi.add(fldapi);  
            }  
        }
        return setApi;
    }
   
    
}