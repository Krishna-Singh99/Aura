public class AU_CustPayProfilefromJSON {
    public cls_messages messages;
    //public List<cls_messages> message;
    public String customerProfileId;
    public String customerPaymentProfileId;
    public String validationDirectResponse;
    
    public class cls_messages {
        public String resultCode;	//Ok
        public cls_message[] message;
    }
    public class cls_message {
        public String code;	//I00001
        public String text;	//Successful.
    }
}