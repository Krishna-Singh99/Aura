({
    doinit: function(cmp, event, helper) {
        
       helper.initHelper(cmp,event, helper);
        helper.setColumns(cmp);
    },
    
    handleSort: function(cmp, event, helper) {
        helper.handleSort(cmp, event);
    },
    handleClick : function(cmp, event, helper) {
        helper.handleSortByApex(cmp, event,helper);
    }
})