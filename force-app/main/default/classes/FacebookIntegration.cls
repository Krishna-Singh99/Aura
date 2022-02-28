public class FacebookIntegration {

    public String id1{get;set;}
    public String name1{get;set;}
    public String website1{get;set;}
    public Integer friends1{get;set;}
    
    public FacebookIntegration(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://graph.facebook.com/me?fields=name,id,friends&access_token=EAAFDy99simoBADnAiYQUTNJ1gwBvFDWjoDZCQTVbGHoxrZAaj5r6cX90lzBAI1FqkNtHgYSltrmyRe6UNmnZAdWUiyU8HSaGgWGQ4vYxCQB8xsF0ZC7ImVFb1F403ZB6f2Ov2egK8xUIDf5PHkdRRI4Dic2BrxmqsCvZBjfs642OmbafAGfs38SAinlQcMZC4XZAf8qxIlmeVtAm1a0BQJvk5hTjO1sVdqZC17zRnZC04BSbGafZASS7Vtw');
        req.setMethod('GET');
        
        HTTPResponse res = http.send(req);
        
        String str = res.getBody();
      //   Map<String, Object> jsonResult = (Map<String, Object>) JSON.deserializeUntyped(str);
      //      System.debug('JSON Data : '+ jsonResult);
        //    System.debug('json friends : '+jsonResult.get('freinds'));
            
        //String friends_count = res.getBody('freinds[summary][total_count]');
       // System.debug('friends_count>>>>'+friends_count);
        JSON2Apex myclass = JSON2Apex.parse(str);
        id1 = myclass.id;
        name1 = myclass.name;
        website1 = myclass.website;
        
      //  friends1 = myclass.friends;
        System.debug('Response   : '+ res);
        System.debug('Str : '+str);

    }
 /*   public List<PieWedgeData> getPieData(){
        List<PieWedgeData> data = new List<PieWedgeData>();
       data.add(new PieWedgeData('Friends',friends1));
        return data;
    }
    Class PieWedgeData
    {
        public String likes{get;set;}
        public Integer likecount{get;set;}
        
        public PieWedgeData(String likes, Integer likecount){
            this.likes = likes;
            this.likecount = likecount;  
        }
    }  */
}