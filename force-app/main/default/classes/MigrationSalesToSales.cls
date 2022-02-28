@RestResource(urlMapping = '/Account/*')
global class MigrationSalesToSales {

    @HttpGet
    global static Account getAccount_Records(){
        RestRequest resReq = RestContext.request;
        String accId = resReq.requestURI.subString(resReq.requestURI.lastIndexof('/')+1);
         System.debug('accnumber'+accId);  
        
        List<Account> accResult = [SELECT ID , Name from Account where Id =: accId];
        if(accResult.size()>0){
            return accResult[0];
        }
        return null;
    }
    
    @HttpPost
    
    global static String saveAccountRecords(){
        RestRequest resReq = RestContext.request;
        Blob jsonAccountString = resReq.requestBody;
        
        Account acc = (Account)JSON.deserialize(jsonAccountString.toString(),Account.class );
        //MAp<String,Object>JSON.deserializeUntyped(request.body.toString());
        try{
            insert acc;
        }catch(Exception ex ){
            System.debug(ex.getMessage()+' >> '+ ex.getLineNumber());
        }
        return null;
    }
}