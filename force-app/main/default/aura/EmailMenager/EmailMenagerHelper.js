({
    SendEmail : function(component) {
        var email=this._e('txtEmail').value;
        var Subject=this._e('txtSubject').value;
       var Bcc=helper._e('BccEmail').value;
        var Cc=helper._e('BccEmail').value;
        
        var Message=component.get("v.myMessage");
        console.log('inside sendEmail');
        var myHTMLContent = Message;
        var tempDiv = document.createElement('div');
        tempDiv.innerHTML = myHTMLContent;
        
        Message = tempDiv.innerText;        
        console.log('Message :: ', Message);
        
        var action=component.get("c.processEmail");
        var userId = component.get("v.recordId");
        console.log('UserId :: ', userId);
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
                var result=e.getReturnValue();
                if(result=='Success'){
                    //alert('Email Send Successfully!');
                }
                else{
                    //alert(result);
                }
            }
            else{
                alert(JSON.stringify(e.getError()));
            }
        });
        $A.enqueueAction(action);
    },
    
    _e:function(ele){
        return document.getElementById(ele);
    },
})