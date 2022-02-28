({
      showObject : function(component, event, helper) {
            var action = component.get("c.fetchObjectName");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {           
                var allValues = response.getReturnValue();
                component.set("v.options", allValues);
            }                    
            else {
                console.log("Unknown Error");
            }
        });
        $A.enqueueAction(action);
    },

  showObjectField : function(component, event, helper) {
      try{
           console.log('selectedValue>>>>>>>>>>>>>>   ' +  component.get("v.selectedValue"));
        var ObjectName = component.get("v.selectedValue");
        var action = component.get("c.fetchObjectfields");
     
        action.setParams({
            "str": ObjectName
        }); 
          action.setCallback(this, function(actionResult) {
              console.log('data>>>>>>>>>>>>>>   ' + JSON.stringify(actionResult.getReturnValue()));
            component.set('v.options2', actionResult.getReturnValue());
        });
       console.log(action);
        $A.enqueueAction(action);
      }catch(error){
          console.log(error);
      }
  },
    
     showObjectFieldType : function(component, event, helper) {
      try{
           console.log('selectedValue>>>>>>>>>>>>>>   ' +  component.get("v.Fieldname"));
        var ObjectNameType = component.get("v.Fieldname");
          var ObjectName = component.get("v.selectedValue");
        var action = component.get("c.fetchObjectfieldsType");
     
        action.setParams({
            "fldtype": ObjectNameType,
            "str" : ObjectName
        }); 
          action.setCallback(this, function(actionResult) {
              console.log('data>>>>>>>>>>>>>>   ' + JSON.stringify(actionResult.getReturnValue()));
            component.set('v.options3', actionResult.getReturnValue());
        });
       console.log(action);
        $A.enqueueAction(action);
      }catch(error){
          console.log(error);
      }
  },
         showObjectFieldTypeApi : function(component, event, helper) {
      try{
           console.log('selectedValue>>>>>>>>>>>>>>   ' +  component.get("v.Fieldname"));
        var ObjectNameType = component.get("v.Fieldname");
          var fldlabel = component.get("v.selectedValue");
        var action = component.get("c.fetchObjectfieldsTypeApi");
     
        action.setParams({
            "fldtypeapi": ObjectNameType,
            "fldlabel" : fldlabel
        }); 
          action.setCallback(this, function(actionResult) {
              console.log('data>>>>>>>>>>>>>>   ' + JSON.stringify(actionResult.getReturnValue()));
            component.set('v.options4', actionResult.getReturnValue());
        });
       console.log(action);
        $A.enqueueAction(action);
      }catch(error){
          console.log(error);
      }
  }
})