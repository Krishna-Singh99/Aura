@isTest(seeAllData=true)
public class TriggerOnTimeAccRestore_Test {

    @isTest
    static void TestTriggerOnTimeAccRestore(){

        User usr = new User(
     ProfileId = UserInfo.getProfileId(),
     LastName = 'last',
     Email = 'puser000@amamama.com',
     Username = 'puser000@amamama.com' + System.currentTimeMillis(),
     CompanyName = 'TEST',
     Title = 'title',
     Alias = 'alias',
     TimeZoneSidKey = 'America/Los_Angeles',
     EmailEncodingKey = 'UTF-8',
     LanguageLocaleKey = 'en_US',
     LocaleSidKey = 'en_US');
        insert usr;
        List<Time__c> timeList = new List<Time__c>();
        timeList.add(new Time__c(Name='Aka',Start_Date__c=date.today().addMonths(-1),End_Date__c =date.today().addMonths(-1).addDays(5),OwnerId=usr.id ));
        insert timeList;
        Test.startTest();
        TriggerOnTimeAccRestore.timeAccountRestore(timeList);
        delete timeList;
        Test.stopTest();
    }
    
}