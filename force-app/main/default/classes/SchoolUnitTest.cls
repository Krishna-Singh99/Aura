@isTest
private class SchoolUnitTest {

    @isTest
    static void TestSchool(){
        List<Region__c> rc = new List<Region__c>();
        for(Integer i=0;i<5;i++){
            rc.add(new Region__c(Name='KKr'+i));
        }
        insert rc;
        Test.startTest();
        School.school();
        Test.stopTest();
    }
}