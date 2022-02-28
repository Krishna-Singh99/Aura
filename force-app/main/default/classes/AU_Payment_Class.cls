public class AU_Payment_Class{
    public Id payId {get;set;}
    public String firstName {get;set;}
    public String lastName {get;set;}
    public String Add1 {get;set;}
    public String Add2 {get;set;}
    public String city {get;set;}
    public String state {get;set;}
    public String zip {get;set;}
    public String email {get;set;}
    public String country {get;set;}
    public String cardName {get;set;}
    public String cardNumber {get;set;}
    public String cardExpMonth {get;set;}
    public String cardExpYear {get;set;}
    public String cardCVV {get;set;}
    public boolean cardTermCheck {get;set;}  
    public boolean tankFlag {get;set;}
    public boolean payFlag {get;set;}
    public String ResString {get;set;}
    public Decimal Amount {get;set;}
    private String transactionID;
    public Payment_Request__c payReqRec;
    public Contact conRec {get;set;}
    public Opportunity oppRec;
    
    public string securityCode{get;set;}
    public  string bankRouting {get;set;}
    public  string accountNum {get;set;}
    public string confirmAccNum {get;set;}
    public string creditCard {get;set;}
    
    public static string bankRouting1 {get;set;}
    public  static string accountNum1 {get;set;}
    
    public AU_Payment_Class(){
        bankRouting1 = '';
        accountNum1 = '';
        email = '';
        payId = apexpages.currentpage().getparameters().get('id');
        payReqRec = new Payment_Request__c();
        Contact conRec = new Contact();
        tankFlag = true;
        payFlag = true;
        system.debug('cardno==>'+cardNumber);
        cardNumber = '';
        cardExpMonth = '';
        cardExpYear = '';
        cardCVV = '';
        
        
        System.debug('payId=>'+payId );
        if(payId != null){
            payReqRec = [SELECT Id, Billing_Contact__c,Opportunity__c ,Status__c FROM Payment_Request__c WHERE Id =: payId];
            conRec = [SELECT Id, FirstName, LastName, Email, MailingCity, MailingState, MailingPostalCode, MailingCountry, MailingStreet FROM Contact WHERE Id =: payReqRec.Billing_Contact__c];
            oppRec = [SELECT Id, Name, Amount FROM Opportunity WHERE Id =: payReqRec.Opportunity__c];
            System.debug('Contact=>'+conRec);
            firstName = conRec.FirstName;
            lastName = conRec.LastName;
            Add1 = conRec.MailingStreet;
            city = conRec.MailingCity;
            state = conRec.MailingState;
            zip = conRec.MailingPostalCode;
            email = conRec.Email;
            country = conRec.MailingCountry;
            //Amount = oppRec.Amount;
            Amount = 10;
            
            
        }
    }
    
    public PageReference submitPayProfile() {
        System.debug('submitPayProfile==>'+cardNumber+cardExpYear+cardExpMonth);
        System.debug('bankRouting1==>'+bankRouting1);
        String custPayProfileId;
        String custProfileId;
        AuthorizeNet__c ANetCS = AuthorizeNet__c.getInstance('Cred');
        
        //Create Customer Profile
        JSONGenerator gen = JSON.createGenerator(true);
        
        // Write data to the JSON string.
        gen.writeStartObject();
        gen.writeFieldName('createCustomerProfileRequest');
        gen.writeStartObject();
        gen.writeFieldName('merchantAuthentication');
        gen.writeStartObject();
        gen.writeStringField('name', ANetCS.Api_Login_ID__c);
        gen.writeStringField('transactionKey', ANetCS.Transaction_Key__c);
        gen.writeEndObject();
        gen.writeFieldName('profile');
        gen.writeStartObject();
        gen.writeStringField('email', email);
        gen.writeFieldName('paymentProfiles');
        gen.writeStartObject();
        gen.writeStringField('customerType', 'individual');
        gen.writeFieldName('payment');
        gen.writeStartObject();
        gen.writeFieldName('creditCard');
        gen.writeStartObject();
        gen.writeStringField('cardNumber', cardNumber);
        gen.writeStringField('expirationDate', cardExpYear+'-'+cardExpMonth);
        gen.writeEndObject();
        gen.writeEndObject();
        gen.writeEndObject();
        gen.writeEndObject();
        gen.writeEndObject();
        gen.writeEndObject();
        // Get the JSON string.
        String CreateCustProString = gen.getAsString();      
        System.debug('CreateCustProString==>'+CreateCustProString);
        Http http1=new Http();
        HttpRequest req1=new HttpRequest();
        System.debug('Endpoint_URL__c==>'+ANetCS.Endpoint_URL__c);
        req1.setendpoint(ANetCS.Endpoint_URL__c);
        req1.Setheader('Content-Type','application/json');
        req1.setmethod('POST'); //you can also SET method `GET` with Get there is no need of req1.setbody()
        req1.setbody(CreateCustProString);
        
        HttpResponse res1;
        res1 = http1.send(req1);
        system.debug('res1==>' +res1);
        system.debug('res1==>' +res1.getBody());
        if(res1.getStatusCode()==200){
            
            String str=res1.getbody().escapeUnicode();
            string FinalJSON=str.replaceall('uFEFF','');
            FinalJSON=FinalJSON.replaceall('\\\\','');
            System.debug(FinalJSON);
            
            AU_CustPayProfilefromJSON  custProfileObj=new AU_CustPayProfilefromJSON ();
            custProfileObj=(AU_CustPayProfilefromJSON ) System.JSON.deserialize(FinalJSON, AU_CustPayProfilefromJSON.class);
            
            AU_CustPayProfilefromJSON.cls_messages custProfileMsg=custProfileObj.messages;
            List<AU_CustPayProfilefromJSON.cls_message> custProfileSubMsg = custProfileMsg.message;
            
            if(custProfileSubMsg[0].text == 'Successful.'){
                custProfileId = custProfileObj.customerProfileId;
            }else if(custProfileSubMsg[0].text.containsIgnoreCase('duplicate')){
                custProfileId = custProfileSubMsg[0].text.replaceAll('[^-?0-9]+', ''); 
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,custProfileSubMsg[0].text));
                return null;
            }
            System.debug('custProfileId=>'+custProfileId );
            
            //Create Customer Profile
            JSONGenerator genPayPro = JSON.createGenerator(true);
            
            // Write data to the JSON string Customer Payment Profile .
            genPayPro.writeStartObject();
            genPayPro.writeFieldName('createCustomerPaymentProfileRequest');
            genPayPro.writeStartObject();
            genPayPro.writeFieldName('merchantAuthentication');
            genPayPro.writeStartObject();
            genPayPro.writeStringField('name', ANetCS.Api_Login_ID__c);
            genPayPro.writeStringField('transactionKey', ANetCS.Transaction_Key__c);
            genPayPro.writeEndObject();
            genPayPro.writeStringField('customerProfileId', custProfileId );
            genPayPro.writeFieldName('paymentProfile');
            genPayPro.writeStartObject();
            genPayPro.writeFieldName('billTo');
            genPayPro.writeStartObject();
            genPayPro.writeStringField('firstName', firstName );
            genPayPro.writeStringField('lastName', lastName );
            genPayPro.writeStringField('address', Add1 + Add2 );
            genPayPro.writeStringField('city', city );
            genPayPro.writeStringField('state', state );
            genPayPro.writeStringField('zip', zip );
            genPayPro.writeStringField('country', country );
            genPayPro.writeStringField('phoneNumber', '');
            genPayPro.writeEndObject();
            genPayPro.writeFieldName('payment'); 
            genPayPro.writeStartObject();
            genPayPro.writeFieldName('creditCard');
            genPayPro.writeStartObject();
            genPayPro.writeStringField('cardNumber', cardNumber);
            genPayPro.writeStringField('expirationDate', cardExpYear+'-'+cardExpMonth);
            genPayPro.writeEndObject();
            genPayPro.writeEndObject();
            genPayPro.writeStringField('defaultPaymentProfile', 'true');
            genPayPro.writeEndObject();
            genPayPro.writeEndObject();
            genPayPro.writeEndObject();
            
            // Get the JSON string.
            String CreateCustPayProString = genPayPro.getAsString();      
            System.debug('CreateCustProString==>'+CreateCustPayProString );
            Http http2=new Http();
            HttpRequest req2=new HttpRequest();
            req2.setendpoint(ANetCS.Endpoint_URL__c);
            req2.Setheader('Content-Type','application/json');
            req2.setmethod('POST'); //you can also SET method `GET` with Get there is no need of req1.setbody()
            req2.setbody(CreateCustPayProString);
            
            HttpResponse res2;
            res2 = http2.send(req2);
            if(res1.getStatusCode()==200){
                
                String str2=res2.getbody().escapeUnicode();
                string FinalJSON2=str2.replaceall('uFEFF','');
                FinalJSON2=FinalJSON2.replaceall('\\\\','');
                System.debug('FinalJSON2=>'+FinalJSON2);
                
                AU_CustPayProfilefromJSON custProfileObj2=new AU_CustPayProfilefromJSON();
                custProfileObj2=(AU_CustPayProfilefromJSON) System.JSON.deserialize(FinalJSON2, AU_CustPayProfilefromJSON.class);
                
                AU_CustPayProfilefromJSON.cls_messages custProfileMsg2=custProfileObj2.messages;
                List<AU_CustPayProfilefromJSON.cls_message> custProfileSubMsg2 = custProfileMsg2.message;
                
                custPayProfileId = custProfileObj2.customerPaymentProfileId;
                System.debug('custPayProfileId=>'+custPayProfileId);
                
                //Create Customer Profile
                JSONGenerator genPayPro2 = JSON.createGenerator(true);
                
                genPayPro2.writeStartObject();
                genPayPro2.writeFieldName('createTransactionRequest');
                genPayPro2.writeStartObject();
                genPayPro2.writeFieldName('merchantAuthentication');
                genPayPro2.writeStartObject();
                genPayPro2.writeStringField('name', ANetCS.Api_Login_ID__c);
                genPayPro2.writeStringField('transactionKey', ANetCS.Transaction_Key__c);
                genPayPro2.writeEndObject();
                genPayPro2.writeFieldName('transactionRequest');
                genPayPro2.writeStartObject();
                genPayPro2.writeStringField('transactionType', 'authCaptureTransaction');
                genPayPro2.writeStringField('amount', String.ValueOf(Amount));
                genPayPro2.writeFieldName('profile');
                genPayPro2.writeStartObject();
                genPayPro2.writeStringField('customerProfileId', custProfileId);
                genPayPro2.writeFieldName('paymentProfile');
                genPayPro2.writeStartObject();
                genPayPro2.writeStringField('paymentProfileId', (custPayProfileId !=null ? custPayProfileId:''));
                genPayPro2.writeEndObject();
                genPayPro2.writeEndObject();
                genPayPro2.writeEndObject();
                genPayPro2.writeEndObject();
                genPayPro2.writeEndObject();
                
                // Get the JSON string.
                String JSONRequestBODY = genPayPro2.getAsString();      
                System.debug('JSONRequestBODY==>'+JSONRequestBODY );
                
                Http http3=new Http();
                HttpRequest req3=new HttpRequest();
                req3.setendpoint(ANetCS.Endpoint_URL__c);
                req3.Setheader('Content-Type','application/json');
                req3.setmethod('POST'); //you can also SET method `GET` with Get there is no need of req1.setbody()
                req3.setbody(JSONRequestBODY);
                
                HttpResponse res3;
                res3 = http3.send(req3);
                if(res1.getStatusCode()==200){
                    
                    String str3=res3.getbody().escapeUnicode();
                    string FinalJSONTran=str3.replaceall('uFEFF','');
                    FinalJSONTran=FinalJSONTran.replaceall('\\\\','');
                    System.debug(FinalJSONTran);
                    
                    Transaction__c tanRec = new Transaction__c();
                    
                    AU_Transaction_fromJSON transactionObj=new AU_Transaction_fromJSON();
                    transactionObj=(AU_Transaction_fromJSON) System.JSON.deserialize(FinalJSONTran, AU_Transaction_fromJSON.class);
                    
                    AU_Transaction_fromJSON.cls_messages tranMsg=transactionObj.messages;
                    List<AU_Transaction_fromJSON.cls_message> tranSubMsg = tranMsg.message;
                    
                    if(tranSubMsg[0].text == 'Successful.'){
                        AU_Transaction_fromJSON.cls_transactionResponse tranData=transactionObj.transactionResponse;
                        
                        tanRec.Amount__c = Amount;
                        tanRec.Authorization__c = tranData.authCode;
                        tanRec.Card_Last_4__c = cardNumber.right(4);
                        tanRec.Credit_Card_Name__c = cardName;
                        tanRec.Credit_Card_Type__c = tranData.accountType;
                        tanRec.Opportunity__c = payReqRec.Opportunity__c;
                        //tanRec.Payment_Method__c = 
                        tanRec.Payment_Request__c = payReqRec.Id;
                        //tanRec.Reason_Code__c = 
                        //tanRec.Reason_Text__c =
                        //tanRec.Recurring__c =
                        //tanRec.Response__c = 
                        tanRec.Response_Code__c = tranData.responseCode;
                        tanRec.Type__c = 'Charge';
                        
                        List<AU_Transaction_fromJSON.cls_messages> tranSubData = tranData.messages;
                        tanRec.Response_Message__c = String.ValueOf(tranSubData[0].message);
                        tanRec.Response_Status__c = String.ValueOf(tranSubData[0].resultCode);
                        //tanRec.Security_Response__c = 
                        tanRec.Tokenization__c = tranData.transId;
                        //tanRec.Type__c = 
                        
                        Insert tanRec;
                        
                        system.debug('custPayProfileId=>'+custPayProfileId);
                        system.debug('custProfileId=>'+custProfileId);
                        system.debug('payReqRec=>'+payReqRec);
                        system.debug('conRec=>'+conRec);
            
                        tankFlag = false;
                        payFlag = true;
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'This transaction has been approved'));
                        return null;
                    }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,tranSubMsg[0].text));
                        return null;
                    }
                    //System.debug('Tansaction=>'+custProfileId );
                }   
                
            }
        }
        tankFlag = false;
        payFlag = true;
        return null;
    }
    public List<SelectOption> getCreditCards() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','None'));
        options.add(new SelectOption('Visa','Visa'));
        options.add(new SelectOption('MasterCard','MasterCard'));
        options.add(new SelectOption('American Express','American Express'));
        return options;
    }
    
    public List<SelectOption> getYear() {
        //integer year = Datetime.now().year();
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Year','Year'));
        // for(integer i =0;i<25;i++){
        //  integer years = Datetime.now().year();
        // options.add(new SelectOption('Year','Year'));
        options.add(new SelectOption('2020','2020'));
        options.add(new SelectOption('2021','2021'));
        options.add(new SelectOption('2022','2022'));
        options.add(new SelectOption('2023','2023'));
        options.add(new SelectOption('2024','2024'));
        options.add(new SelectOption('2025','2025'));
        options.add(new SelectOption('2026','2026'));
        options.add(new SelectOption('2027','2027'));
        options.add(new SelectOption('2028','2028'));
        options.add(new SelectOption('2029','2029'));
        options.add(new SelectOption('2030','2030'));
        options.add(new SelectOption('2031','2031'));
        // }
        return options;
    }
    public List<SelectOption> getMonth() {
        integer year = Datetime.now().year();
        List<SelectOption> options = new List<SelectOption>();
        //options.add(new SelectOption('Year','Year'));
        // for(integer i =0;i<25 electoption="" i="" list="" new="" options.add="" options="" public="" return="" selectoption="" string.valueof="" year=""> getMonths() {
        // integer year = Datetime.now().year();
        //List options = new List();
        options.add(new SelectOption('MTH','MTH'));
        options.add(new SelectOption('01','Jan'));
        options.add(new SelectOption('02','Feb'));
        options.add(new SelectOption('03','Mar'));
        options.add(new SelectOption('04','Apr'));
        options.add(new SelectOption('05','May'));
        options.add(new SelectOption('06','Jun'));
        options.add(new SelectOption('07','Jul'));
        options.add(new SelectOption('08','Aug'));
        options.add(new SelectOption('09','Sep'));
        options.add(new SelectOption('10','Oct'));
        options.add(new SelectOption('11','Nov'));
        options.add(new SelectOption('12','Dec'));
        
        return options;
        // }
        
    }
}