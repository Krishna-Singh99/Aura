public class School {   
    public static void school(){
list<Region__c> rg=new list<Region__c>();
   rg=[select Id from Region__c limit 5];
        list<School__c> sl = new  list<School__c>();
        integer i=0;
        for(Region__c ac:rg){
            School__c sch = new School__c();
            sch.Name = 'School'+i;
            i++;
            sch.AccountId__c = ac.Id;
            sl.add(sch);
        }
    insert sl;
        System.debug('School Records : '+sl);
}
}