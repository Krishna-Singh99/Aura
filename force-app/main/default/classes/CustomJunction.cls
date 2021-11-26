public class CustomJunction {
    public static void addJunctionObject(){
        list<EventParticipant__c> cstevent = new list<EventParticipant__c>();
        list<Contact> con = new list<Contact>([Select Id from Contact limit 1]);
        list<Event__c> eve = new list<Event__c>([Select Id from Event__c limit 1]);
        for(integer i=0;i<16;i++){
            EventParticipant__c addEvent = new EventParticipant__c();
            addEvent.Contact__c = con.get(0).Id;
            addEvent.Event__c = eve.get(0).Id;
            if(i>=0 && i<=10){   
                addEvent.multipicklist__c = 'Attendee';
                addEvent.Name = 'EventFootball'+i;
                
            }
            if(i>=11 && i<14){
                
                addEvent.multipicklist__c = 'Presenter';
                addEvent.Name = 'EventjunFootball'+i+i;
            }
            if(i>=14 && i<17)
            {
                addEvent.multipicklist__c = 'Organizer';
                addEvent.Name = 'EventjunFootball'+i+i+i; 
            }
            cstevent.add(addEvent);
        }if(cstevent!=Null){
            insert cstevent;
            system.debug(cstevent.size());
        }
        
    }
}