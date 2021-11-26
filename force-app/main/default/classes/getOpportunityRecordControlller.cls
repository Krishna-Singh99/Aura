public with sharing class getOpportunityRecordControlller {
  @AuraEnabled(cacheable=true)
  public static List<Opportunity> getOpportunity() {
    return [
      SELECT Name, id, StageName
      FROM Opportunity
      WHERE StageName != NULL
    ];
  }
}