({
 
    savecontact : function(component, event, helper){       
         var action = component.get('c.save');
        action.setParams({
            acc : component.get('v.newItem')
        });
        action.setCallback(this,function(result){
            var getAllValue = component.get('v.newItem');
            console.log(getAllValue);
            let getval = getAllValue.Name;
            component.set('v.items',getval);
        });
        $A.enqueueAction(action);
    },
    doCancel : function(component, event, helper) {
        component.set('v.newItem','');
    },
     doCancel1 : function(component, event, helper) {
        component.set('v.newItem','');
    },
     doCancel2 : function(component, event, helper) {
        helper.validateFields(component, event, helper);
    }
})