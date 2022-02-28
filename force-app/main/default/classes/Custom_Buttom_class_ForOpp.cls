public class Custom_Buttom_class_ForOpp {
  
    public boolean counter{get;set;}
    public string fetchId;
    public  Custom_Buttom_class_ForOpp(ApexPages.StandardController stdcontroller){
      fetchId = stdcontroller.getid();
      counter = true;
    }
    public void check(){
    Opportunity opp = [SELECT ID,Name, Stagename,CloseDate FROM Opportunity where id=:fetchId limit 1];
        if(opp.StageName == 'Closed Won'){
            counter = True;
        }
        else{
            counter = False;
        }
    }
}