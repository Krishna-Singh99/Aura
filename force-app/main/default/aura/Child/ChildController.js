({
        childComponentEvent : function(cmp, event,helper) { 

            var cmpEvent = cmp.getEvent("sampleCmpEvent"); 
           
            cmpEvent.setParams({"message" : "Welcome"}); 
            cmpEvent.fire(); 
    }
    })