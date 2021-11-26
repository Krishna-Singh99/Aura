({ 
    doinit: function(component, event, helper) {
        helper.showObject(component, event, helper);
        
    },
    
     fieldsset : function(component, event, helper) {
         helper.fieldSet(component, event, helper);
    },
    setfieldform :  function(component, event, helper) {
        
       helper.setField(component, event, helper);
    },
    sucsess :  function(component, event, helper) {
        
       helper.showToast(component, event, helper);
    },
     loadHandler : function(component, event, helper) {
        if(component.get('v.skipFirstLoad')) {
            component.set('v.skipFirstLoad', false);
            return;
        }
        component.set('v.formMode', component.get('v.formMode') === 'view' ? 'edit' : 'view');
    },

    successHandler : function(component, event, helper) {
        component.set('v.formMode', 'view');
    },
    onSave : function(component, event, helper) {
        helper.onsaveHelper(component, event, helper);
    },
     objectApiName : function(component, event, helper) {
         
         helper.objectApiNameHelper(component, event, helper);
    },
    onCancel  : function(component, event, helper) {
         
         helper.onCancelHelper(component, event, helper);
    },
    forceClose: function(c,e,h){
    h.forceToastClose(c,e,h);
  }
})