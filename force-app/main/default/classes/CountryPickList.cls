public class CountryPickList {
    
    @AuraEnabled
    public static  List<WrapperClass> fetchCountryfields(String countryName){
        String strObjectName = 'Country__c';
        String strPicklistField = countryName+'__c';
        
        List<WrapperClass> wrapperList = new  List<WrapperClass>();
        Map<String,String> countryBank = new Map<String,String>();
        Map<String, String> mapPickListValues = new Map<String, String>();
        Schema.SObjectType objSobjectType = Schema.getGlobalDescribe().get(strObjectName);
        Schema.DescribeSObjectResult objDescribeSobject = objSobjectType.getDescribe();
        Map<String, Schema.SObjectField> mapFields = objDescribeSobject.fields.getMap();
        List<Schema.PicklistEntry> lstPickListValues = mapFields.get(strPicklistField).getDescribe().getPickListValues();
        for (Schema.PicklistEntry objPickList : lstPickListValues) {
            countryBank.put(objPickList.getLabel(),objPickList.getValue());
            WrapperClass obj = new wrapperClass();
            obj.label = objPickList.getLabel();
             obj.value = objPickList.getValue();
            wrapperList.add(obj);
           // System.debug('Value = ' +objPickList.getValue() +' , Label = ' +objPickList.getLabel());
        }
        //String jsonMap=JSON.serialize(countryBank);
        return wrapperList; 
    }
     
    public class WrapperClass{
        @AuraEnabled
        public  String label='';
                @AuraEnabled
            public  String value='';
    }
}