public class MyCaseListController {

    public string getuserId {get; set;}
     //public  List<Case> results {get; set;}
  
    
    public List<Case> getListOfCases() {
    id userId = UserInfo.getUserId();
       List<Case> results = [SELECT CaseNumber,Id, Status, OwnerId,Contact.Name,Priority,Subject FROM Case WHERE status='New' And ownerId =: userId ];
            return results;
    }
}