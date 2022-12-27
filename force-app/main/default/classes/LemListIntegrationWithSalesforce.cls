public class LemListIntegrationWithSalesforce {
    
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    
    public static void createLead(){
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://api.lemlist.com/api/activities?access_token=f4656a7c0c13566f4caf902b3b1356fe');
        response = http.send(request); 
        List<Object> fieldList = (List<Object>)JSON.deserializeUntyped(response.getBody());
        System.debug('fieldList>>'+ fieldList);
        List<Lead> leadList = new List<Lead>();
        for(Object fld : fieldList){    
            Map<String,Object> data = (Map<String,Object>)fld;
            Lead newLead = new Lead();
            newLead.FirstName = String.valueof(data.get('leadFirstName'));
            newLead.LastName = String.valueof(data.get('leadLastName'));
            if(String.valueof(data.get('companyName')) !=null && String.valueof(data.get('companyName')) == ''){
                newLead.Company = String.valueof(data.get('companyName'));
            }
            else{
                newLead.Company = 'CA';
                
            }
            leadList.add(newLead);
            system.debug(data.get('leadFirstName'));
        } 
        Insert leadList;
    }
    
}