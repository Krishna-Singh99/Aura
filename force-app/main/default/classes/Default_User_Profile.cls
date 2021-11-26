public class Default_User_Profile {      
    @AuraEnabled
    public static list<User>  fetchUser(){
            list<User> usr = [SELECT Id FROM User where isActive !=false];
        return usr;
    }
     @AuraEnabled
    public static List<wrapperclass>  fetchUser(String userId){
        List<wrapperclass> wrapperList = new list<wrapperclass>();
            list<Account> accList = [SELECT Name,Id FROM Account where ownerid =: userId];
        for(Account acc:accList){
            wrapperclass wrapper = new wrapperclass();
            wrapper.accName =  acc.Name;
             wrapper.accId =  acc.Id;
            wrapperList.add(wrapper);
        }
         list<Contact> conList = [SELECT FirstName,LastName,Id FROM Contact where ownerid =: userId];
        for(Contact con:conList){
            wrapperclass wrapper = new wrapperclass();
            wrapper.conLastName =  con.LastName;
             wrapper.conFirstName =  con.FirstName;
             wrapper.conId =  con.id;
            wrapperList.add(wrapper);
        }
         list<Opportunity> oppList = [SELECT Name FROM Opportunity where ownerid =: userId];
           for(Opportunity opp:oppList){
            wrapperclass wrapper = new wrapperclass();
            wrapper.oppName =  opp.Name;
             wrapper.oppId =  opp.id;
               wrapperList.add(wrapper);
        }
        return wrapperList;
    }

    public class wrapperclass {
        @AuraEnabled
        public  String accName;
         @AuraEnabled
        public  String accId;
        @AuraEnabled
        public  String conLastName;
         @AuraEnabled
        public  String conFirstName;
         @AuraEnabled
        public  String conId;
         @AuraEnabled
        public  String oppName;
         @AuraEnabled
        public  String oppId;
        
    }
}