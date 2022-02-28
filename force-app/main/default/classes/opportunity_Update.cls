public class opportunity_Update {
 public static void oopUp(){
       //Update all Opportunity with future Closed Date by Opportunity Name=Opportunity Name + 'F'
        List<Opportunity> date1=new List<Opportunity>();
     date1 = [Select Name from Opportunity where CloseDate > Today];
    //  List<Opportunity> updt=new List<Opportunity>();
     for(Opportunity dm: date1){
         dm.name=dm.Name+'H';
         //updt.add(dm);
     } 
            update date1;
     System.debug('Update Successfully'+date1);
            
    }
}