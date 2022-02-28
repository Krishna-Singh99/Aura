@isTest
private class PriceBookTriggerTest {

    @isTest
    static void TestPricebook(){
     
        List<Pricebook2> prc = new List<Pricebook2>();
        for(integer i=0;i<5;i++){
            Pricebook2 pr = new Pricebook2();
            pr.Name = 'prc'+i;
            prc.add(pr);
        }
        Test.startTest();
        insert prc;
        Test.stopTest();
    }
}