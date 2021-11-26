({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            { label: 'Bank name', fieldName: 'Bank__c', type: 'text'},
            { label: 'Account Name', fieldName: 'Name', type: 'text'},
            { label: 'IFSC', fieldName: 'IFSC__c', type: 'text'},
            { label: 'Bank Address', fieldName: 'BankAddress__c', type: 'text'},
            { label: 'Total Amount', fieldName: 'TotalAmount__c', type: 'number'},
            { label: 'Transaction ', fieldName: 'Transaction__c', type: 'text'}
           
        ]);
        helper.detailPage(cmp);
    },
    onSave : function(component, event, helper) {
        helper.onsaveHelper(component, event, helper);
        helper.detailPage(component,event, helper);
    },
    onCancel  : function(component, event, helper) {
         
        helper.onCancelHelper(component, event, helper);
   },
   parentComponentEvent : function(component, event, helper) {
     helper.parentComponentEventHelper(component, event, helper);
       helper.detailPage(component);
       component.set("v.accountid",'');
   },
   handleAccountClick : function(component, event, helper) {
       helper.handleAccountClickhelper(component, event, helper);
   }
})