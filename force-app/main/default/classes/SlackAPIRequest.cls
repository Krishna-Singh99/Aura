public class SlackAPIRequest {
    public static void slackApirequest(){                                                                             
HttpRequest req = new HttpRequest();
        req.setMethod('GET');
         req.setEndpoint('https://slack.com/oauth/authorize');
         req.setHeader('client_id', '3271660849732.3254724252871');
          req.setHeader('scope', 'bot');                  
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug(res.getBody()+'>>>>>>>res');
    }

    public static void sendMessagetoSlack(){ 
       
        HttpRequest req = new HttpRequest();
        Id currentUserId = UserInfo.getUserId();
        Feeditem [] fi = [Select Id, body, ParentId from FeedItem WHERE CreatedById =: currentUserId];
        req.setMethod('POST');
        req.setEndpoint('https://hooks.slack.com/services/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');
        req.setHeader('Content-Type', 'application/json');  
        req.setBody('{"text":"Hello, World!"}');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        FeedItem post = new FeedItem();
        post.ParentId = '0055g00000CSLZBAA5';
        post.Body = res.getBody();
        insert post;
        system.debug(res+'>>>>>>>res');
    }
    public static void fetchMessagefromSlack(){  
         Id userId = userInfo.getUserId();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://slack.com/api/conversations.history?channel=C038M2C443A');
        req.setHeader('Content-Type', 'application/json');  
        req.setHeader('scope', 'channels:read');  
        req.setHeader('Authorization', 'Bearer xoxb-3271660849732-3269750692787-8JvbB8QyazqM1LvS4mzPlRT0');
        req.setHeader('channel','C038M2C443A');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        List<String> strList = new List<String>();
        Map<String,Object> strObject = (Map<String,Object>) Json.deserializeUntyped(res.getBody());
        List<object> objList = (List<Object>) strObject.get('messages');
        
        for(Object str : objList){
            Map<String,Object> strObject1 = (Map<String,Object>) str;
            
            if(strObject1.containskey('text')){
                String str1 = String.valueof(strObject1.get('text'));
                strList.add(str1);
                System.debug('strObject1'+strObject1.get('text'));
            }
            
        }
        List<FeedItem> fdList = new List<FeedItem>();
        for(String strBody : strList){
            FeedItem postfeed = new FeedItem();
            postfeed.ParentId = userID;
            postfeed.Body = strBody;
            fdList.add(postfeed);
            
        }
        insert fdList;
       // system.debug('strObject>>>'+strObject);
       //system.debug(res.getBody()+'>>>>>>>res');
    }
}