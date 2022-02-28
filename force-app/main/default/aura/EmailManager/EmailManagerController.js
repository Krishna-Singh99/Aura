({
    Send : function(component, event, helper) {
        let email=helper._e('txtEmail').value;
        let Subject=helper._e('txtSubject').value;
        let Message=component.get("v.myMessage");
       
        let regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/; 

        if(email==''){
            let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: "Error!",
            message: "Field Required!",
            type: 'error',
            duration:' 5000',
            mode: 'pester'
        });
        toastEvent.fire();
        }
        else if(Subject==''){
            let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: "Error!",
            message: "Field Required!",
            type: 'error',
            duration:' 5000',
            mode: 'pester'
        });
        toastEvent.fire();
        }
        else if(Message==''){
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title: "Error!",
                message: "Field Required!",
                type: 'error',
                duration:' 5000',
                mode: 'pester'
            });
            toastEvent.fire();
        }
        else if(!isBlank(Bcc) && !isBlank(Cc)){
                if(!email.match(regExpEmailformat) && !Bcc.match(regExpEmailformat) && !Cc.match(regExpEmailformat)){
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title: "Error!",
                        message: "Invalid Email Id",
                        type: 'error',
                        duration:' 5000',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }
            }else if(!isBlank(Bcc) && isBlank(Cc) ){
                if(!email.match(regExpEmailformat) && !Bcc.match(regExpEmailformat)){
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title: "Error!",
                        message: "Invalid Email Id",
                        type: 'error',
                        duration:' 5000',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }
            }else if(isBlank(Bcc) && !isBlank(Cc)){
                if(!email.match(regExpEmailformat) && !Cc.match(regExpEmailformat)){
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title: "Error!",
                        message: "Invalid Email Id",
                        type: 'error',
                        duration:' 5000',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }
            }else if(!email.match(regExpEmailformat)){
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title: "Error!",
                        message: "Invalid Email Id",
                        type: 'error',
                        duration:' 5000',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }
            
            
            else{
               
                    helper.SendEmail(component,event,helper);
                
                }              
        
    },
    
    showSpinner: function(component, event, helper) {        
        component.set("v.Spinner", true); 
    },
    
    hideSpinner : function(component,event,helper){        
        component.set("v.Spinner", false);
    },
 })