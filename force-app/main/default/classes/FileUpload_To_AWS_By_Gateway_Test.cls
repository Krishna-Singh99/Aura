@isTest
Private class FileUpload_To_AWS_By_Gateway_Test {
    
    static testmethod void sendfileToAWSTest(){
        Attachment attach = [Select Body,ContentType,Name from Attachment where parentid='0015g00000Q8AG8AAN' and ContentType != null limit 1];
        System.debug('attach>>>>'+attach);
        String attachmentBody = EncodingUtil.base64Encode(attach.Body);
        String filename = attach.Id + '-' + attach.Name;
        FileUpload_To_AWS_By_Gateway.sendfileToAWS(attachmentBody,filename);
    }
}