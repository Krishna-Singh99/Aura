public class OpenCases {
    private List<Case> cse;
    private Account acnt; 
    public OpenCases(ApexPages.StandardController controller) {
        this.acnt= (Account)controller.getRecord();
    }
    public List<Case> getcse()
    {
        Account acc = [Select id FROM Account where id = :acnt.id];
        if (acc.id == null)
         return null;
        cse = [Select CaseNumber, Type from case  where Case.isclosed = False];  //where Case.Account.id = :acc.id and
        return cse;
    }
}