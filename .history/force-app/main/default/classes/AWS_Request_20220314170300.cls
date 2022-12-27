public class AWS_Request {
@AuraEnabled(cacheable=true)
    public static Map<String,Object>  awsRequestforbody(){
    HttpRequest req = new HttpRequest();
    req.setEndpoint('callout:AWS_S3');
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
         Map<String,Object> mapData =(Map<String,Object>) JSON.deserializeuntyped(res.getBody());
         SYstem.debug('mapData>>>'+mapData);
        return mapData;
    }
}