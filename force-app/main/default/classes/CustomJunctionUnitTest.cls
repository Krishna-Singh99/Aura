@isTest
private class CustomJunctionUnitTest {
    @testSetup
    static void setupset() {
        Event__c ev = new Event__c(Name = 'Rummy Culture');
        insert ev;
        Contact con = new Contact(LastName = 'Singh');
        insert con;
        EventParticipant__c evp = new EventParticipant__c(Event__c=ev.id,Contact__c=con.Id,Name='hy');
        insert evp;
    }
    @isTest
    static void TestCustomJunction() {
        Test.startTest();
        CustomJunction.addJunctionObject();
        Test.stopTest();
        List<EventParticipant__c> sc = [Select id from EventParticipant__c];
        System.assertEquals(17, sc.Size());
    }
     
}