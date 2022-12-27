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
    public static String getPdfFileAsBase64String(String details) {
        PageReference pdfPage = Page.envelopes;
       // Blob pdfBlob = pdfPage.getContent();
        Blob pdfBlob = EncodingUtil.base64Encode(details);
        String base64Pdf = EncodingUtil.base64Encode(pdfBlob);
        return base64Pdf;
    }
  } 