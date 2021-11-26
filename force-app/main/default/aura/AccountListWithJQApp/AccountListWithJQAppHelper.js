({
    COLUMNS: [
        
        {
            label: 'Name',
            fieldName: 'name',
            type: 'String',
            sortable: true,
            cellAttributes: { alignment: 'left' },
        },
        { label: 'Phone', fieldName: 'phone', type: 'String' },
    ],

    DATA: [
        { id: 1, name: 'Billy Simonns', age: 40, email: 'billy@salesforce.com' },
        { id: 2, name: 'Kelsey Denesik', age: 35, email: 'kelsey@salesforce.com' },
        { id: 3, name: 'Kyle Ruecker', age: 50, email: 'kyle@salesforce.com' },
        {
            id: 4,
            name: 'Krystina Kerluke',
            age: 37,
            email: 'krystina@salesforce.com',
        },
    ],
    
    setColumns: function(cmp) {
        cmp.set('v.columns', this.COLUMNS);
    },

    setData: function(cmp) {
        cmp.set('v.data', this.DATA);
    },

    // Used to sort the 'Age' column
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
    initHelper : function(cmp, event,helper) {  
      var getfield = cmp.get("c.methodName");   
         action.setCallback(this, function(actionResult) {
                console.log('action',action);
                component.set('v.data',actionResult.getReturnValue());
              }); 
              $A.enqueueAction(action);
    },
    handleSort: function(cmp, event) {
        var sortedBy = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');

        var cloneData = this.DATA.slice(0);
        cloneData.sort((this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1)));
        
        cmp.set('v.data', cloneData);
        cmp.set('v.sortDirection', sortDirection);
        cmp.set('v.sortedBy', sortedBy);
    }
})