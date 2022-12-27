public class FileUploadinAWS {

    public static void sendfileToAWS(){
        Attachment attach = [select Body,ContentType,Name from Attachment where parentid='0015g00000Q8AG8AAN' and ContentType != null limit 1];
String attachmentBody = EncodingUtil.base64Encode(attach.Body);
String formattedDateString = Datetime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z');
String key = 'AKIAUM4WCVWQ3ASGAC2H'; //AWS key
String secret = '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'; //AWS Secret key
String bucketname = 'krishnafiles'; //AWS bucket name
String host = 'ap-south-1.amazonaws.com';
String method = 'PUT';

String filename = attach.Id + '-' + attach.Name;
        String[] extension =attach.Name.split('.');
        String contentType = attach.ContentType;
 string fileUrl='https://' + bucketname + '.' +host + '/' + filename;
                HttpRequest req = new HttpRequest();
                req.setMethod(method);
                req.setEndpoint(fileUrl);
                req.setHeader('Host', bucketName + '.' + host);
                req.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
                req.setHeader('Content-Encoding', 'UTF-8');
                req.setHeader('Content-type', contentType);
                req.setHeader('Connection', 'keep-alive');
                req.setHeader('Date', formattedDateString);
                req.setHeader('ACL', 'public-read');
                Blob pdfBlob = EncodingUtil.base64Decode(attachmentBody);
            	req.setBodyAsBlob(pdfBlob);
                   
                req.setHeader('Authorization','CreateAuthHeader' + CreateAuthHeader(contentType, filename, formattedDateString,'png'));
        Http http = new Http();
                HTTPResponse res = http.send(req);
    }
    
        public static string CreateAuthHeader(String contentType,
                                   String filename, String formattedDateString,string fileExtension){
                                       string auth;
                                       String stringToSign = 'POST'+'\n\n'+contentType+'\n'+formattedDateString+'\n/'+'krishnafiles'+'/'+filename.toLowerCase()+ '.'+fileExtension.toLowerCase();
                                       Blob mac = Crypto.generateMac('HMACSHA1', blob.valueof(stringToSign),blob.valueof( 'YrqGwO6XzHkK17NEqoIujIT1DasRk7/xYget/GxA'));
                                       String sig = EncodingUtil.base64Encode(mac);
                                       auth = 'AWS' + ' ' + 'AKIAUM4WCVWQ3ASGAC2H' + ':' + sig;
                                       return auth;
                                   }
}