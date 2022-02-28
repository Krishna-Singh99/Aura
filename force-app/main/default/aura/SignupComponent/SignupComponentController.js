({
    myActionNew:function(component,event,helper)
    {
        var obj={
            firstname : false,
            lastname : false,
            email : false,
            password : false,
            comfirmPassword : false
        };
        component.set("v.validateFields",obj);
    },
    handleSelfRegister: function (component, event, helper) {
        helper.helperMethod(component, event, helper);
    },
    setExpId: function (component, event, helper) {
        var expId = event.getParam('expid');
        if (expId) {
            component.set("v.expid", expId);
        }
        helper.setBrandingCookie(component, event, helper);
    },
    handleOnChange: function(component,event,helper)
    {
        var validFields = component.get("v.validateFields");
        // if(event.getSource().get("v.name") == 'firstName')
        // {
        //     let firstname = component.get("v.firstname");
        //     if($A.util.isEmpty(firstname)){
        //         validFields.firstname = true;
        //         $A.util.addClass(component.find('firstname'), "slds-has-error");
        //     }
        //     else{
        //         validFields.firstname = false;
        //         $A.util.removeClass(component.find('firstname'), "slds-has-error");  
        //     }
        // }
        if(event.getSource().get("v.name") == 'lastname')
        {
            let lastname = component.get("v.lastname");
            if($A.util.isEmpty(lastname)){
                validFields.lastname = true;
                $A.util.addClass(component.find('lastname'), "slds-has-error");
            }
            else{
                validFields.lastname = false;
                $A.util.removeClass(component.find('lastname'), "slds-has-error");  
            }
        }
        if(event.getSource().get("v.name") == 'email')
        {
            var email = component.get("v.email");
            if($A.util.isEmpty(email)){
                validFields.email = true;
                $A.util.addClass(component.find('email'), "slds-has-error");
            }
            else{
                validFields.email = false;
                $A.util.removeClass(component.find('email'), "slds-has-error");  
            }
            component.set("v.validateFields",validFields);
        }
        if(event.getSource().get("v.name") == 'password')
        {
            var password = component.get("v.password");
            if($A.util.isEmpty(password))
            {
                validFields.password=true;
                $A.util.addClass(component.find('password'), "slds-has-error");
            }
            else{
                validFields.password = false;
                $A.util.removeClass(component.find('password'), "slds-has-error");  
            }
            var passRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
            if(password.match(passRegex))
            {   
                validFields.password = false;
                $A.util.removeClass(component.find('password'), "slds-has-error");
            }
        }
        if(event.getSource().get("v.name") == 'copassword')
        {
            var confirmPassword = component.get("v.confirmPassword");
            if($A.util.isEmpty(confirmPassword))
            {
                validFields.confirmPassword=true;
                $A.util.addClass(component.find('confirmPassword'), "slds-has-error");
            }
            else{
                validFields.confirmPassword = false;
                $A.util.removeClass(component.find('confirmPassword'), "slds-has-error");  
            }
        }
        component.set("v.validateFields",validFields);
    }
})