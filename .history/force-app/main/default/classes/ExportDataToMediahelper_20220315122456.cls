public with sharing class ExportDataToMediahelper { 
    public class ContactWrapper{  
      @AuraEnabled  
      public string contactName;  
      @AuraEnabled  
      public string contactEmail;  
      public ContactWrapper(Contact contactObj){  
        this.contactName = contactObj.Name;  
        this.contactEmail = contactObj.Email;  
      }  
    }  
    @AuraEnabled  
    public static List<ContactWrapper> getContacts(){  
      List<ContactWrapper> contactWrapperList = new List<ContactWrapper>();  
      for(Contact cwObj : [select id, Name, Email from Contact limit 5]){  
        contactWrapperList.add(new ContactWrapper(cwObj));  
      }  
      return contactWrapperList;  
    }  
    @AuraEnabled  
    public static Boolean downloadPDF() {
        // Was hoping this would trigger the download to start
        Page.envelopes.getHeaders().put('content-disposition', 'attachment; filename=envelope.pdf');
        return true;
      }
    
  } 