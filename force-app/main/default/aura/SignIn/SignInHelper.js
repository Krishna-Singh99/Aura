({
    loginHelper : function(component, event, helper) {
        try{
            var usrname = component.get("v.contactUserName");
            console.log('usernae',usrname);
            var pssword = component.get("v.contactPassword");
            if(usrname!==null && pssword!=null){
                var action = component.get("c.setNamePWd");
                action.setParams({
                    "username": usrname,
                    "passwrd": pssword
                }); 
                
                action.setCallback(this, function(actionResult) {
                    let storedResponse = actionResult.getReturnValue();
                    console.log('stored',storedResponse);
                    let str = true;
                    console.log('action',action);
                    component.set('v.result',actionResult.getReturnValue());
                    console.log(actionResult.getReturnValue()); 
                    if(str === actionResult.getReturnValue()){
                        helper.showToast(component, event, helper); 
                    window.open('https://zenly-developer-edition.ap24.force.com/customer',"_parent");
                    }
                    else
                        var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Warning!",
                        "message": "Username or password is incorrect."
                    });
                    toastEvent.fire();
                });
                $A.enqueueAction(action);
            }
        }catch(error){
            console.log(error);
        }
    },
    showToast : function(component, event, helper) {
        var loginValue = component.get('v.result');
        if(loginValue!=null){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Success!",
                "variant": "success",
                "message": "The record has been updated successfully."
            });
            toastEvent.fire();
        }
    }
})