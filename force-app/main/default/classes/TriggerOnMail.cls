public class TriggerOnMail {
public static void fillConMailAsAccShipping(List<Contact> conList){
        
        List<Contact> con = [Select Id,AccountId,Account.ShippingStreet,Account.ShippingCity, Account.ShippingState,
                             Account.ShippingPostalCode, Account.ShippingCountry,COPY_ADDRESS_FROM_ACCOUNT__c  from Contact where   ID In : conList];
        List<Contact> co = new List<Contact>();
        for(Contact c: con){
            if(c.COPY_ADDRESS_FROM_ACCOUNT__c == True){
                 c.MailingStreet = c.Account.ShippingStreet;
            c.MailingCity = c.Account.ShippingCity;
            c.MailingState = c.Account.ShippingState;
            c.MailingPostalCode = c.Account.ShippingPostalCode;
            c.MailingCountry = c.Account.ShippingCountry;
            co.add(c);
            }
           
        }


        if(co !=null ){
            upsert co;
        }
    }
}