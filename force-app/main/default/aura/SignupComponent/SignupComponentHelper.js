({
    helperMethod: function (component, event, helper) {
        
        var firstname = component.get("v.firstname");
        var lastname = component.get("v.lastname");
        var email = component.get("v.email");
        var password = component.get("v.password");
        var confirmPassword = component.get("v.confirmPassword"); 
        var communityNickname = component.get("v.communityNickname");
        var validFields = component.get("v.validateFields");
        var passRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
        

        if($A.util.isEmpty(lastname) || $A.util.isEmpty(email) || $A.util.isEmpty(password) || $A.util.isEmpty(confirmPassword) )
        {
            if($A.util.isEmpty(lastname)){
                validFields.lastname = true; 
                $A.util.addClass(component.find('lastname'), "slds-has-error");
            }
            else{
                validFields.lastname = false;   
                $A.util.removeClass(component.find('lastname'), "slds-has-error");       
            }
            if($A.util.isEmpty(email)){
                validFields.email = true;   
                $A.util.addClass(component.find('email'), "slds-has-error");
            }
            else{
                validFields.email = false;   
                $A.util.removeClass(component.find('email'), "slds-has-error");
            }
            if($A.util.isEmpty(password))
            {
                validFields.password=true;
                $A.util.addClass(component.find('password'), "slds-has-error");
            }
            else{
                validFields.password = false;
                $A.util.removeClass(component.find('password'), "slds-has-error");  
            }
            if($A.util.isEmpty(confirmPassword))
            {
                validFields.confirmPassword=true;
                $A.util.addClass(component.find('confirmPassword'), "slds-has-error");
            }
            else{
                validFields.confirmPassword = false;
                $A.util.removeClass(component.find('confirmPassword'), "slds-has-error");  
            }
            component.set("v.validateFields",validFields);
        }
        else
        {   
            if(!password.match(passRegex) || password !== confirmPassword)
            {
                if(!password.match(passRegex))
                {
                    validFields.password = true;
                    $A.util.addClass(component.find('password'), "slds-has-error");
                }
                else if(password !== confirmPassword)
                {
                    helper.showHideToastHelper(component, event, helper, 'Warning', 'Password Do Not Match');
                }
        }   
            else{
                validFields.firstName = false;
                validFields.lastname = false;   
                validFields.email = false;  
                validFields.password = false;  
                validFields.confirmPassword = false;
                var action = component.get("c.registerUser");
                
                action.setParams({
                firstName:firstname,
                lastName:lastname,
                email:email,
                password:password, 
                confirmPassword:confirmPassword, 
                communityNickname:communityNickname,
                });   

              action.setCallback(this, function(response){
              var rtnValue = response.getReturnValue();
             
                if (rtnValue === 'Valid') {
                    helper.showHideToastHelper(component, event, helper, 'Success', 'Successfully Authorized');
                 window.location.href = $A.get("$Label.c.Successfully_Signup");
                }
                else if(rtnValue === 'No Contact') 
                {
                    helper.showHideToastHelper(component, event, helper, 'Error', 'No Contact Found');
                } 
                else if(rtnValue === 'Account Name Does Not exist for Contact')
                {
                    helper.showHideToastHelper(component, event, helper, 'Error', 'No Account Found');
                }
                else if(rtnValue === 'Password Do Not Match')
                {
                    helper.showHideToastHelper(component, event, helper, 'Warning', 'Password Do Not Match');
                }
                else if(rtnValue === 'User Exist')
                {
                    helper.showHideToastHelper(component, event, helper, 'Warning', 'User Exists');
                }
                else{
                    helper.showHideToastHelper(component, event, helper, 'Error', 'Some Error Occured Please try later!!');
                   
                }
           });
        $A.enqueueAction(action);
            }
            component.set("v.validateFields",validFields);
        }
    },
    setBrandingCookie: function (component) {        
        var expId = component.get("v.expid");

        if (expId) {

            var action = component.get("c.setExperienceId");
            action.setParams({expId:expId});
            action.setCallback(this, function(a){ });
            $A.enqueueAction(action);
        }
    },
    showHideToastHelper : function (component, event, helper,type,msg) {
        try{
          
            if(type && msg) {
                $A.get("e.c:CustomToastEvent").setParams({
                    toastInput: type,
                    message : msg,
                }).fire();
            }
        } catch(e){
            console.log('Error :>>>>'+e);
        }
    },

    

})