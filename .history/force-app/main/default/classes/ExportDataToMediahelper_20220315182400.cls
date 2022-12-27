public with sharing class ExportDataToMediahelper { 
    public String records {get; set;}
    public String str;
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
    public  String getPdfFileAsBase64String(String details) {
      System.debug('details>>>>>'+details);
      this.str = details;
      ExportDataToMediahelper.ExportDataToMediahelper(details);
        PageReference pdfPage = Page.envelopes;
       // Blob pdfBlob = pdfPage.getContent();
        Blob pdfBlob =  Blob.valueOf(details);
        System.debug('pdfBlob>>>>>'+pdfBlob);
        String base64Pdf = EncodingUtil.base64Encode(pdfBlob);
        System.debug('base64Pdf>>>>>'+base64Pdf);
        return base64Pdf;
    }
public ExportDataToMediahelper(){
records = str;
}

  } 