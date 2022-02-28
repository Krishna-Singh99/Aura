public class AWS_Request {

    public static void awsRequestforbody(){
    HttpRequest req = new HttpRequest();
    req.setEndpoint('callout:AWS_S3');
    req.setMethod('GET');
    req.setHeader('Content-Type', 'application/json');
    Http http = new Http();
    HttpResponse res = http.send(req);
        List<String> v = new List<String>();
        v.add( res.getBody());
        String[] str = new String[]{};     
        for(String result : v){
            String mm = String.valueof(result.replace('<',''));
            str.add(mm);
            System.debug('Result>>>'+mm);
        }  
           System.debug('str>>>'+str);
     //    Map<String,Object> result = (Map<String,Object>)JSON.deserializeUntyped(str);
       // system.debug('result>>>>'+result);
       // for(String results : result.keySet()){
       //     system.debug('result>>>'+result.get(results));
      //      system.debug('result value >>>'+result);
    //    }
    System.debug('req body'+res.getBody());
        System.debug('req header'+res.getHeader('16778ba7-4e72-42d3-a03a-8f6cceb85329'));
         System.debug('req body'+res.getStatus());
        
    }
}