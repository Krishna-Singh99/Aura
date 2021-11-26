public class Opportunity_Date {
public string Opportunity_details{get;set;}

public boolean counter{get;set;}

public Opportunity_Date(ApexPages.StandardController controller) {

String Opportunity_details = controller.getId();
    if(Opportunity_details != null){
        opportunity oppobject =[SELECT id,CloseDate FROM opportunity where id = :Opportunity_details and TotalOpportunityQuantity > 0];
if(oppobject!=null && oppobject.CloseDate >= Date.Today() && oppobject.CloseDate<= Date.Today().addDays(4))
{
counter=true;
}
else
counter=false;

}
    }

}