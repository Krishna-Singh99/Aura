({
    transaction : function(component, event, helper) {
        let cmpEvent = component.getEvent("transaction");
        console.log('cmpEvent>>>',cmpEvent);
        var amount  = component.get("v.money");
        if(!amount.includes("-") && !amount.includes("+")){
            let isNumber = Number(amount);
        
        if(Number.isInteger(isNumber)){
            console.log('isNumber>>',isNumber);        
        console.log('amount>>',amount);
        console.log(event.getSource().getLocalId());
        cmpEvent.setParams({
            "Amount" : amount,
            "Transaction":event.getSource().getLocalId()
        });
        component.set("v.money",'0');
        cmpEvent.fire();
    }
        }
    }
         
})