@IsTest
class TestContactTrigger {
    @IsTest
    static void insertContact(){
        List<Contact> newConList = new List<Contact>();
        for(integer i=0;i<5;i++){
            Contact newCon = new Contact(LastName='Test Con');
            newConList.add(newCon);
        }
        if(newConList != null && newConList.Size()>0){
            Test.startTest();
            insert newConList;
            Test.stopTest();
        }
    }

     @IsTest
    static void undeleteContact(){
        List<Contact> newConList = new List<Contact>();
        for(integer i=0;i<5;i++){
            Contact newCon = new Contact(LastName='TestCon');
            newConList.add(newCon);
             
        }
        insert newConList;
             delete newConList;
       
        List<Contact> undelCont  = [SELECT Id FROM Contact WHERE IsDeleted=True ALL ROWS];
            
             Test.startTest();
           
            undelete undelCont;
            Test.stopTest();
        
    }

}