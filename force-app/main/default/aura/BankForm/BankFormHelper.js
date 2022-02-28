({
    onsaveHelper : function(component,event,helper){
        var action = component.get("c.saveBankDetails");
        action.setParams({"bank": component.get("v.bank")});
        action.setCallback(this, function(response){
            //<response.getState()> return response status as SUCCESS/ERROR/INCOMPLETE etc.
            var state = response.getState();
            //If response from server side is <SUCCESS>, then we will display a success message.
            if (state === "SUCCESS"){
                document.getElementById("userErr").className = "Success";
                document.getElementById("cls-btn").className = "cross-btn";
                component.set('v.Error', 'Record has been inserted successfully');
                component.set('v.crossIcon', 'X');

            
            }else if (state === "ERROR") {
                //Error message display logic.
                document.getElementById("userErr").className = "Error";
                document.getElementById("cls-btn").className = "cross-btn";
                component.set('v.Error', 'Incorrect phone number');
                component.set('v.crossIcon', 'X');
                helper.toastClose(component,component,component);
                return;

            }else {
                document.getElementById("userErr").className = "Error";
                document.getElementById("cls-btn").className = "cross-btn";
                component.set('v.Error', 'Unknown error');
                component.set('v.crossIcon', 'X');
                helper.toastClose(component,component,component);
                return;
            }
        });
        $A.enqueueAction(action);
    },
    onCancelHelper : function(component, event, helper) {
        component.set('v.bank','');

    },
    toastClose: function (c, e, h) {
        window.setTimeout(
            $A.getCallback(function () {
                c.set('v.Error', '');
                c.set('v.crossIcon', '');
                document.getElementById("userErr").className = "";
                document.getElementById("cls-btn").className = "";

            }), 2000
        );
    },
        forceToastClose: function (c, e, h) {
            c.set('v.Error', '');
            c.set('v.crossIcon', '');
            document.getElementById("userErr").className = "";
            document.getElementById("cls-btn").className = "";
        },

detailPage : function (cmp, e, h) {
            var action = cmp.get('c.fetchBankDetails');
     
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var wrapper=response.getReturnValue();
                cmp.set('v.details', response.getReturnValue());
                cmp.set("v.accountid",'');
                console.log(' v.details', cmp.get('v.details'));
                console.log(' getReturnValue', response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    },
    parentComponentEventHelper : function (cmp, event, h) {     
    let amount = event.getParam("Amount");
        let debOrcred = event.getParam("Transaction");
        console.log('debOrcred Line 75 >>>>',debOrcred);
        console.log('credit Line 76>>',amount);
    cmp.set("v.Credit", amount);
        let action = cmp.get("c.trancation");
        console.log(cmp.get("v.accountid"));
        action.setParams({"amount": cmp.get("v.Credit"),
                         "Accountid": cmp.get("v.accountid"),
                          "transactions": debOrcred,
                         });
        
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(' getReturnValue', response.getReturnValue());
                document.getElementById("userErr").className = "Success";
                document.getElementById("cls-btn").className = "cross-btn";
                cmp.set('v.Error', 'Transaction Successfull');
                cmp.set('v.crossIcon', 'X');
                cmp.set("v.accountid",'');
              location.reload();
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
                document.getElementById("userErr").className = "Error";
                document.getElementById("cls-btn").className = "cross-btn";
                cmp.set('v.Error', 'Transaction unsuccesfull');
                cmp.set('v.crossIcon', 'X');
            }
        }));
        $A.enqueueAction(action);
   },
    handleAccountClickhelper : function (cmp, event, h) {
        event.preventDefault();
        cmp.set("v.accountid",'');
        var selectedRows = event.getParam('selectedRows');
        let sizeOfArray =  selectedRows.length;
        console.log(sizeOfArray);
        //for (var i = 0; i < selectedRows.length; i++){
            if(sizeOfArray != 0){
                console.log("You selected: " + selectedRows[sizeOfArray-1].Id);
                cmp.set("v.accountid",selectedRows[sizeOfArray-1].Id);
            }
           
        //}
        
    },
    //  handleSuccess: function(component, event, helper) {
    //     $A.get('e.force:refreshView').fire();
    // }
})