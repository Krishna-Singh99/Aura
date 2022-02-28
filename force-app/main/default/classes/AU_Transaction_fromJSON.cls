public class AU_Transaction_fromJSON {
    public cls_transactionResponse transactionResponse;
    public cls_messages messages;
    public class cls_transactionResponse {
        public String responseCode;	//1
        public String authCode;	//HW617E
        public String avsResultCode;	//Y
        public String cvvResultCode;	//
        public String cavvResultCode;	//
        public String transId;	//2157047189
        public String refTransID;	//
        public String transHash;	//E7CEB0A9F1BECA32A02493E1B31D5955
        public String testRequest;	//0
        public String accountNumber;	//XXXX1111
        public String accountType;	//Visa
        public cls_messages[] messages;
        public String transHashSha2;	//D0C4FFF5648511A5862B917CFD9BB78ABF8A6E1D90C119CBBC4C0B454F4FF40DED15B204E042F36ECA5FB15D02588E4E4A7B85B94E7279599CE6020462CB7DEE
        public Integer SupplementalDataQualificationIndicator;	//0
        public String networkTransId;	//123456789NNNH
    }
    public class cls_messages {
        public String resultCode;	//Ok
        public cls_message[] message;
    }
    public class cls_message {
        public String code;	//I00001
        public String text;	//Successful.
    }
}