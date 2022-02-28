trigger TriggerOnAccount on Account (after insert) {  
 if(trigger.isAfter){
        if(Trigger.isInsert){
            //Accountfortrigger.accn(trigger.new);
             Accountfortrigger.salesRepresentative(trigger.new);
           
            }
      }        
  }