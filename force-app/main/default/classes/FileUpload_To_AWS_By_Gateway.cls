public with sharing class FileUpload_To_AWS_By_Gateway {
    @AuraEnabled
    public static String sendfileToAWS(String base64, String filename){
        system.debug('filename>>>'+filename);
        system.debug('base64>>>>'+base64);
        String formattedDateString = Datetime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z');
        String key = 'AKIAUM4WCVWQ3ASGAC2H'; //AWS key
        String secret = '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'; //AWS Secret key
        String bucketname = 'krishnafiles'; //AWS bucket name
        String host = 'ap-south-1.amazonaws.com';
        String method = 'PUT';
        filename = filename.replace(' ', '_');
        string fileUrl='https://kpvirampn8.execute-api.ap-south-1.amazonaws.com/v2/krishnafiles/'+ filename;
        HttpRequest req = new HttpRequest();
        req.setMethod(method);
         req.setEndpoint('callout:AWS_S3_Gateway_v1'+'/'+filename);
        Blob pdfBlob = EncodingUtil.base64Decode(base64);
        req.setBodyAsBlob(pdfBlob);
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('ress>>>'+res);
        String status = res.getStatus();
        if(status=='200'){
            return 'success';
        }      
   else {
       return '';
   }
    }  
}