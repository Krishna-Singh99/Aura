public with sharing class FileUpload_To_AWS_By_Gateway {
    @AuraEnabled
    public static String sendfileToAWS(String base64, String filename, String recordId){
        Attachment attach = [select Body,ContentType,Name from Attachment where parentid='0015g00000Q8AG8AAN' and ContentType != null limit 1];
        String attachmentBody = EncodingUtil.base64Encode(attach.Body);
        String formattedDateString = Datetime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z');
        String key = 'AKIAUM4WCVWQ3ASGAC2H'; //AWS key
        String secret = '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'; //AWS Secret key
        String bucketname = 'krishnafiles'; //AWS bucket name
        String host = 'ap-south-1.amazonaws.com';
        String method = 'PUT';
        
        //String filename = attach.Id + '-' + attach.Name;
        String[] extension =attach.Name.split('.');
        String contentType = attach.ContentType;
        string fileUrl='https://kpvirampn8.execute-api.ap-south-1.amazonaws.com/v2/krishnafiles/'+ filename;
        HttpRequest req = new HttpRequest();
        req.setMethod(method);
         req.setEndpoint('callout:AWS_S3_Gateway_v1'+'/'+filename);
        //req.setHeader('Host', bucketName + '.' + host);
       // req.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
       // req.setHeader('Content-Encoding', 'UTF-8');
        req.setHeader('Content-type', contentType);
      //  req.setHeader('Connection', 'keep-alive');
       // req.setHeader('Date', formattedDateString);
        //req.setHeader('ACL', 'public-read');
        Blob pdfBlob = EncodingUtil.base64Decode(attachmentBody);
        req.setBodyAsBlob(pdfBlob);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('ress>>>'+res);
        String status = res.getStatus();
        if(res.status=='200')
       return 'success';
   else {
       return '';
   }
    }
   
}