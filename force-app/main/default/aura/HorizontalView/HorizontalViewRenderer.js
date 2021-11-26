({

// Your renderer method overrides go here
submit : function(component, event, helper) {
        $A.get('e.force:refreshView').fire();
    }
})