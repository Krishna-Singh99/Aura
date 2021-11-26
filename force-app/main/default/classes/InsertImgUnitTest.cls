@isTest
private class InsertImgUnitTest {
    @TestSetup
    static void Testattachment() {
        
        string str = 'abd';
        Account acc = new Account(Name = 'Tst149');
        insert acc;
        Contact con = new Contact(LastName='Contact',Accountid=acc.id);
        insert con;
        system.debug(con);
        system.debug(acc);
        Attachment ach = new Attachment( Name = 'Abd.png',body = blob.valueof(str),parentid = acc.id);
        insert ach;
        system.debug(ach);
    }
    @isTest
    static void TestInsertImg() {
        Test.startTest();
        InsertImg.insrtJpg();
        Test.stopTest();
    }
}