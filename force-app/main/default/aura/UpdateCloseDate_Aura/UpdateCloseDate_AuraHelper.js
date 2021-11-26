({
    finalUpdate : function(component,event, helper) {
        try{
            console.log('in helper');
       
        var action = component.get("c.fetcOpp");
        action.setParams({
            oppId: component.get('v.recordId'),
            cldt: component.get('v.onnlyClsDate')
            
        });
            action.setCallback(this, function(data){
                var returnedData = data.getReturnValue();
                console.log('data>>>>>>>>>>>>>>>>>>>>>>> ' + returnedData);
            });

        $A.enqueueAction(action); 
        }
        catch(Err){
            console.log('Something went wrong     >  '+ Err);
        }
      
    },
    
showToast : function(component, event, helper) {
    var dateValue = component.get('v.onnlyClsDate');
    if(dateValue){
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": "Success!",
         mode: 'sticky',
        type: 'success',
        "message": "The record has been updated successfully."
    });
        
    toastEvent.fire();
    }else
    {
        var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": "Opppssss!",
        mode: 'sticky',
        type: 'error',
        "message": "Please Select Date First."
    });
        
    toastEvent.fire();
    }    
},
handleSuccess: function(component, event, helper) {
        $A.get('e.force:refreshView').fire();
    }    
})