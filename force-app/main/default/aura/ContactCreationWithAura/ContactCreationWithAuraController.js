({
    
    handleSubmit: function(cmp) {
        var LastName = cmp.get('v.contactLastName');
       console.log(LastName);
        var Email = cmp.get("v.contactEmail");
        console.log(Email);
        var AccountId = cmp.get("v.contactId");
        console.log(AccountId);
        var action = cmp.get('c.setContact');
        action.setParams({ 
            "conName" : LastName,
            "email" : Email,
            "accId" :AccountId
        });
        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if(state=="Success"){
                console.log("Success");
            }
       
        });
           $A.enqueueAction(action);
       }
    
})