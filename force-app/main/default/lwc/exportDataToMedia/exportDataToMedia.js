import {  
   LightningElement,  
   track  
 } from "lwc";  
 import getContacts from "@salesforce/apex/ExportDataToMediahelper.getContacts";  
 import downloadPDF from '@salesforce/apex/ExportDataToMediahelper.getPdfFileAsBase64String';
 //import downloadPDF1 from '@salesforce/apex/ExportDataToMediahelper.ExportDataToMediahelper';
 
 import { loadScript } from 'lightning/platformResourceLoader';
 import downloadjs from '@salesforce/resourceUrl/downloadJS';
 const columns = [{  
     label: "Name",  
     fieldName: "contactName",  
     type: "text"  
   },  
   {  
     label: "Email",  
     fieldName: "contactEmail",  
     type: "text"  
   }  
 ];  
 export default class ExportToExcelDemo extends LightningElement {  
   @track hrefdata;  
   @track contactList;  
   @track contactColumns = columns;  
    boolShowSpinner = false;
    pdfString;
   connectedCallback() {  
     this.getContacts();  
   }  
   getContacts() {  
     getContacts()  
       .then(result => {  
         this.contactList = result;  
       })  
       .catch(error => {  
         this.error = error;  
         console.log(this.error);  
       });  
   }  
   exportToCSV() {  
     let columnHeader = ["Name", "Email"];  // This array holds the Column headers to be displayd
     let jsonKeys = ["contactName", "contactEmail"]; // This array holds the keys in the json data  
     var jsonRecordsData = this.contactList;  
     let csvIterativeData;  
     let csvSeperator;  
     let newLineCharacter;  
     csvSeperator = ",";  
     newLineCharacter = "\n";  
     csvIterativeData = "";  
     csvIterativeData += columnHeader.join(csvSeperator);  
     csvIterativeData += newLineCharacter;  
     for (let i = 0; i < jsonRecordsData.length; i++) {  
       let counter = 0;  
       for (let iteratorObj in jsonKeys) {  
         let dataKey = jsonKeys[iteratorObj];  
         if (counter > 0) {  csvIterativeData += csvSeperator;  }  
         if (  jsonRecordsData[i][dataKey] !== null &&  
           jsonRecordsData[i][dataKey] !== undefined  
         ) {  csvIterativeData += '"' + jsonRecordsData[i][dataKey] + '"';  
         } else {  csvIterativeData += '""';  
         }  
         counter++;  
       }  
       csvIterativeData += newLineCharacter;  
     }  
     console.log("csvIterativeData", csvIterativeData);  
     this.hrefdata = "data:text/csv;charset=utf-8," + encodeURI(csvIterativeData);  
   }  
   
  generatePdf(){
        this.boolShowSpinner = true;
        var detail = JSON.stringify(this.contactList);
         console.log('detail>>>>',detail);
       // console.log('detail>>>>',JSON.stringify(detail));
        downloadPDF({details : detail})
        .then(response => {
            console.log('response',response);
            var strFile = "data:application/pdf;base64,"+response;          
            console.log('strFile>>>>>',strFile);
            window.download(strFile, "sample.pdf", "application/pdf");

        }).catch(error => {
            console.log('Error: ' +error.body.message);
        });
    }
    renderedCallback() {
        loadScript(this, downloadjs)
        .then(() => console.log('Loaded download.js'))
        .catch(error => console.log(error));
    }        

 }