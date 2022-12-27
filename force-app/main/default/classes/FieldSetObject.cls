public class FieldSetObject {
    @AuraEnabled
    public static List<String> sObjectHasFieldSet() {
        try {
            List<String> sObjHasFieldset = new List<String>();
            Map<String, Schema.SObjectType> global_describe = Schema.getGlobalDescribe();
            for (String sObj : global_describe.keySet()) {
                Schema.SObjectType sobject_type = global_describe.get(sObj);
                Schema.DescribeSObjectResult sobject_type_describe = sobject_type.getDescribe();
                Map<String, Schema.FieldSet> FsMap = sobject_type_describe.FieldSets.getMap();
                if (FsMap.size() > 0) {
                    sObjHasFieldset.add(String.valueOf(global_describe.get(sObj)));
                }
            }
            
            if (sObjHasFieldset.size() > 0) {
                return sObjHasFieldset;
            }
            return null;
        } catch (Exception Err) {
            System.debug(
                'Error >>>>>>>>>>>> ' +
                Err.getLineNumber() +
                ' ' +
                Err.getCause() +
                ' ' +
                Err.getMessage()
            );
            return null;
        }
    }
    @AuraEnabled
    public static List<string> fieldSetSelected(String objName) {
        try {
             if(objName !=null){
        List<String> fieldSetList = new List<String>();
            Map<String, Schema.SObjectType> global_describe = Schema.getGlobalDescribe();
            
            Schema.SObjectType sobject_type = global_describe.get(objName);
            
            Schema.DescribeSObjectResult sobject_type_describe = sobject_type.getDescribe();
            
            Map<String, Schema.FieldSet> FsMap = sobject_type_describe.FieldSets.getMap();
            for (String fields : FsMap.keySet()) {
                fieldSetList.add(fields);
            }
            if (fieldSetList.Size() > 0) {
                return fieldSetList;
            }
       
      }
                 return null;
        } catch (Exception Err) {
            System.debug(
                'Error >>>>>>>>>>>> ' +
                Err.getLineNumber() +
                ' ' +
                Err.getCause() +
                ' ' +
                Err.getMessage()
            );
            return null;
        }
    }
    @AuraEnabled
    public static List<FieldSetMemberWrapperClass> FieldSetName(
        String fieldSetName,
        String ObjectName
    ) {
        
        try {
            Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe();
            List<String> sobjectList = new List<String>();
            List<FieldSetMemberWrapperClass> wrapperList = new List<FieldSetMemberWrapperClass>();
            Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
            Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
            Map<String,Schema.SObjectField> pickList = DescribeSObjectResultObj.fields.getMap() ;
            Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap()
                .get(fieldSetName);
            List<Schema.FieldSetMember> fieldSetMemberList = fieldSetObj.getFields();
            
            for (Schema.FieldSetMember sr : fieldSetMemberList) {
                FieldSetMemberWrapperClass fieldset = new FieldSetMemberWrapperClass();
                fieldset.fieldLabel = sr.getLabel();
                fieldset.fieldAPIName = sr.getFieldPath();
                fieldset.isDBRequired = sr.getDbRequired();
                fieldset.isRequired = sr.getRequired();
                fieldset.wrapperfld = '';
                
                fieldset.fieldType = String.valueOf(sr.getType()).toLowercase();
                if(fieldset.fieldType == 'picklist'){
                    Schema.DescribeFieldResult pickListIn = pickList.get(String.valueOf(sr.getSObjectField())).getDescribe();
                    List<Schema.PicklistEntry> pickListValues = pickListIn.getPicklistValues();
                    fieldset.pickListValues  = new List<String>();
                    for(Schema.PicklistEntry pickval: pickListValues){
                        fieldset.pickListValues.add(pickval.getValue());
                    }
                    fieldset.isPickList = true;
                    
                    
                }
                if(fieldset.fieldType == 'boolean'){
                    fieldset.fieldType = 'checkbox';
                    fieldset.isCheckbox = true;
                    fieldset.defaultValueOfCheckbox = false;
                }
                wrapperList.add(fieldset);
            }
            return wrapperList;
        } catch (Exception Err) {
            System.debug(
                'Error >>>>>>>>>>>> ' +
                Err.getLineNumber() +
                ' ' +
                Err.getCause() +
                ' ' +
                Err.getMessage()
            );
            return null;
        }
    }
    @AuraEnabled
    public static String updateData(String objectData, String objname) {
        System.debug('objectData'+objectData);
        try {
            Schema.SObjectType convertType = Schema.getGlobalDescribe().get(objname);
            Sobject sObjType = convertType.newSObject();
            
            Map<String, Object> sobjectData = (Map<String, Object>) JSON.deserializeUntyped(
                objectData
            );
            System.debug('sobjectData>>>'+sobjectData);
            if(objectData!=null && objname!=null){
                for(String fieldAPI: sobjectData.keySet()){
                String Value = String.valueOf(sobjectData.get(fieldAPI));
                System.debug('Value'+Value);
                SObjectType r = ((SObject)(Type.forName('Schema.'+objname).newInstance())).getSObjectType();
                DescribeSObjectResult d = r.getDescribe();
                String Type = String.valueOf(d.fields.getMap().get(fieldAPI).getDescribe().getType());
                if(Type == 'DATE'){
                    sObjType.put(fieldAPI, Date.valueOf(Value));
                }else
                    if(Type == 'CHECKBOX'){
                    sObjType.put(fieldAPI, Boolean.valueOf(Value));
                    }
                else if(Type == 'CURRENCY'){
                    
                    sObjType.put(fieldAPI,Decimal.valueOf(Value));
                }else if(Type == 'BOOLEAN'){
                    
                    sObjType.put(fieldAPI,Boolean.valueOf(Value));
                }
                else {
                    sObjType.put(fieldAPI,Value);
                }               
            }
            
            if(sObjType!=null){
                
                insert sObjType;
                
            }
            }
            
            return 'Success';
        } catch (Exception e) {
            system.debug(
                'Error>>>>' +
                e.getLineNumber() +
                ' ' +
                e.getMessage() +
                ' ' +
                e.getCause()
            );
            return 'not inserted';
        } 
    }
    public class FieldSetMemberWrapperClass {
        @AuraEnabled
        public Boolean isDBRequired { get; set; }
        @AuraEnabled
        public Boolean isRequired { get; set; }
        @AuraEnabled
        public String fieldType { get; set; }
        @AuraEnabled
        public String fieldLabel { get; set; }
        @AuraEnabled
        public String fieldAPIName { get; set; }
        @AuraEnabled
        public Boolean isPickList { get; set; }
         @AuraEnabled
        public Boolean isCheckbox { get; set; }
        @AuraEnabled
        public Boolean defaultValueOfCheckbox { get; set; }
        @AuraEnabled
        public List<String> pickListValues { get; set; }
        @AuraEnabled
        public String wrapperfld { get; set; }
    }
}