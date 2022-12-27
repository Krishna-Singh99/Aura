@isTest
Private class FieldSetObjectTest {
 static testmethod void sObjectHasFieldSetTest() {

     Test.startTest();
     String str = '{"Name" : "Xytrex Co.","Description" : "Industrial Cleaning Supply Company","Account Number" : "ABC15797531"}';
     FieldSetObject.sObjectHasFieldSet();
     FieldSetObject.fieldSetSelected('Account');
     FieldSetObject.updateData(str, 'Account');
     FieldSetObject.FieldSetName('AccountFieldSet1', 'Account');
     Test.stopTest();
 }
}