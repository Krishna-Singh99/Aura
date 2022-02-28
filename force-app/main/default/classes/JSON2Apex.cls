public class JSON2Apex {

    public string id;
    public String name;
    public String Website;
    public Integer friends;
    public Posts posts;
    
    public class Paging{
        public Cursors cursors;
        public String next;
        
    }
    public class Cursors {
        public String before ;
        public String after;
    }
    public class Posts{
        public List<Data> data;
    public Paging paging;
    }
    Public Class Data{
        public String created_time;
        public String message;
        public String id;
        public String story;
    }
    public static JSON2Apex parse(String json){
        return (JSON2Apex)System.JSON.deserialize(json,JSON2Apex.class);
    }
    
}