public class S3FileController {
    @AuraEnabled
    public static string getFileUrl(string record)
    {
        try
        {
            List<FileStore__c> files=[SELECT  S3ServerUrl__c,FileExtension__c FROM FileStore__c 
                                      where Id=:record limit 1];
            FileStore__c file = files[0];
            return file.S3ServerUrl__c;
        }
        catch(Exception ex)
        {
            system.debug('ex:'+ex.getMessage());
            return '';
        }
    }
}