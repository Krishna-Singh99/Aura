@isTest
private class ProductDescUnitTest {

    @isTest
    static void TestProductDesc(){
        Product2 pro = new Product2(Name='Product2',Description='Elkbg');
        insert pro;
        Test.startTest();
        ProductDesc.OppDes();
        Test.stopTest();
    }
}