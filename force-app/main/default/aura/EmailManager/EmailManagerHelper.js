({
    SendEmail : function(component,event,helper) {
        let email=this._e('txtEmail').value;
        let Subject=this._e('txtSubject').value;
        let Bcc=helper._e('BccEmail').value;
        let Cc=helper._e('CcEmail').value;
        let Message=component.get("v.myMessage");
        let myHTMLContent = Message;
        let tempDiv = document.createElement('div');
        tempDiv.innerHTML = myHTMLContent;
        
        Message = tempDiv.innerText;        
        
        let action=component.get("c.processEmail");
        let userId = component.get("v.recordId");
        
        action.setParams({
            email:email,
            Subject:Subject,
            Message:Message,
            caseId : userId,
            Bcc : Bcc,
            Cc : Cc
        })
        action.setCallback(this,function(e){
            if(e.getState()=='SUCCESS'){
                let result=e.getReturnValue();
                if(result=='success'){
                   helper.SuccessToast(component,event,helper);
                }
                else if(result=='unmatch'){
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!",
                        "message": "Can't Reply to this Case Type!",
                        type: 'error',
                        duration:' 5000',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                 }
                else{
                    helper.ErrorToast(component,event,helper);
                }
            }
            else{
               toastEvent.setParams({
                        "title": "Error!",
                        "message": "Error!",
                        type: 'error',
                        duration:' 5000',
                        mode: 'pester'
                    });
                    toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
    
    _e:function(ele){
        return document.getElementById(ele);
    },
    SuccessToast : function(component, event, helper) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'Your Reply has been sent.',
            duration:' 5000',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
    },
    ErrorToast : function(component, event, helper) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Error!",
            "message": "Reply failed",
            type: 'error',
            duration:' 5000',
            mode: 'pester'
        });
        toastEvent.fire();
    },
    ErrorforSupportCase : function(component, event, helper) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Error!",
            "message": "Can`t Reply to this Case Type",
            type: 'error',
            duration:' 5000',
            mode: 'pester'
        });
        toastEvent.fire();
    },
    
})