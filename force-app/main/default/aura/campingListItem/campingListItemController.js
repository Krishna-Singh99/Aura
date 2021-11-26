({
    packItem : function(component, event, helper) {
        component.set("v.item.Packed__c",true);
        let packed = component.getSource();
        packed.Packed__c = true;
        let dispatch = packed.getSource();
        dispatch.set("v.disabled",true);
    }
})