public class NewCaseListController {
    
    public static List<Case> getNewCases(List<Case> cs){
        List<Case>  cases = [select id, CaseNumber from Case where status='New'];
        return cases;
    }
}