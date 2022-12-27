public class VoiceMail_Aws_Callout {
@AuraEnabled(cacheable=true)
    public static List<Object>  awsRequestforbody(){
    HttpRequest req = new HttpRequest();
    req.setEndpoint('callout:AWS_S3_CA');
    req.setMethod('GET');  
    req.setHeader('Content-Type', 'application/json');
    Http http = new Http();
    HttpResponse res = http.send(req);
    //     List<String> v = new List<String>();
    //     v.add( res.getBody());
    //     String[] str = new String[]{};     
    //     for(String result : v){
    //         String mm = String.valueof(result.replace('<',''));
    //         str.add(mm);
    //         System.debug('Result>>>'+mm);
    //     }  
    //        System.debug('str>>>'+str);
    //    List<String> result = new List<String>();
    //     result.add(res.getBody());
    //     system.debug('result>>>>'+result);
    //     for(String results : result){
    //         system.debug('result>>>'+result);
    //         //system.debug('result value >>>'+result);
    //    }
    // System.debug('req body'+res.getBody());
    //     System.debug('req header'+res.getHeader('16778ba7-4e72-42d3-a03a-8f6cceb85329'));
    //      System.debug('req body'+res.getStatus());
         //Map<String,Object> mapData =(Map<String, Object>) JSON.deserializeuntyped(res.getBody());
         //SYstem.debug('mapData>>>'+mapData.size());
        // SYstem.debug('mapData Size>>>'+mapData);
        //  List<Object> obj = new List<object>();
        //List<Object> objdata;
        //  for(String strdata : mapData.keyset()){
        //      Map<
        //     objdata.add(strdata);
        //  }
        Blob body123 = res.getBodyAsBlob();
        ContentVersion cVersion = new ContentVersion();
            cVersion.ContentLocation = 'S'; 
            cVersion.PathOnClient = 'vOICE.WAV';//File name with extension
            cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
            cVersion.OwnerId = '0055g00000CSLZBAA5';//Owner of the file
            cVersion.Title = 'vOICE Test';//Name of the file
            cVersion.VersionData = body123;//File content
        //cVersion.FileExtension='WAV';
                //cVersion.FileType='audio';
            insert cVersion;
           ContentDocumentLink cdl = new ContentDocumentLink();
           cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM 
           ContentVersion WHERE Id =: cVersion.Id].ContentDocumentId;
           cdl.LinkedEntityId = '0015g00000SRHqPAAX';
           cdl.ShareType = 'V';
           insert cdl;
          System.debug('35>>>'+res.getBodyAsBlob());
        return null;
    }
}