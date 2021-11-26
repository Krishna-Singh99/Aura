@isTest
 class PolicyTriggerUnitTest {

     @isTest
     static void TestPolicyTrigger(){
         Opportunity opp = new Opportunity(Name='KKr',StageName='Closed Won', CloseDate=date.today(),policy_number__c = 12445);
         insert opp;
         Policy__c pol = new Policy__c(Name='Policy',Renew_Policy__c=False,policy_number__c=12445,opportunity_name__c = opp.Id);
         insert pol;
         pol.Name='KKR';
         Test.startTest();
         update pol;
         Test.stopTest();
     }
}