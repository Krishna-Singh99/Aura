({ 
    doinit: function(component, event, helper) {
        helper.showObject(component, event, helper);
        
    },
    fieldsName : function(component, event, helper) {
        helper.showObjectField(component, event, helper);
    },
    fieldsNameType : function(component, event, helper) {
        helper.showObjectFieldType(component, event, helper);   
      helper.showObjectFieldTypeApi(component, event, helper);  
    }
})