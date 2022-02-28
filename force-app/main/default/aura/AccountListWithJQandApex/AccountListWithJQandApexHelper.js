({
     COLUMNS: [
        
        {
            label: 'Name',
            fieldName: 'Name',
            type: 'String',
            sortable: true,
            cellAttributes: { alignment: 'left' },
        },
        { label: 'Phone', fieldName: 'Phone', type: 'String' },
    ],    
    setColumns: function(cmp) {
        cmp.set('v.columns', this.COLUMNS);
    },
    initHelper : function(cmp,event,helper) {
        var action = cmp.get("c.fetchAccount");
         action.setCallback(this, function(actionResult) {
              console.log('data>>>>>>>>>>>>>>   ' + JSON.stringify(actionResult.getReturnValue()));
           var dt = cmp.set('v.data', actionResult.getReturnValue());
         console.log(dt);
        });
        $A.enqueueAction(action);    
    },
    // Used to sort the 'Name' column
    sortBy: function(field, reverse, primer) {
        var key = primer
            ? function(x) {
                  return primer(x[field]);
              }
            : function(x) {
                  return x[field];
              };

        return function(a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    },

    handleSort: function(cmp, event) {
        var sortedBy = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        var data = cmp.get('v.data');
        var cloneData = data.slice(0);
        cloneData.sort((this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1)));
        
        cmp.set('v.data', cloneData);
        cmp.set('v.sortDirection', sortDirection);
        cmp.set('v.sortedBy', sortedBy);
    },
       handleSortByApex :  function(cmp, event,helper) {
        var dataforclass = cmp.get('v.data');
           var action =cmp.get('c.sortByApex');
           action.setParams({
               "acc":dataforclass
           });
        action.setCallback(this, function(actionResult) {
         cmp.set('v.data', actionResult.getReturnValue());
       
        });
        $A.enqueueAction(action);
    }
})