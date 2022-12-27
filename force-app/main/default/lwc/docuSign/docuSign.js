import { LightningElement,api,wire } from 'lwc';
import { loadStyle,loadScript  } from 'lightning/platformResourceLoader';
import styles from '@salesforce/resourceUrl/docuhomecss';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import javascript from '@salesforce/resourceUrl/docuuploadJs';

export default class FadingText extends LightningElement {
    cloud = false;
    home = true;
     @api code='';
    sticky = false;
  timeout = 3000;
    image = false;
    fileName='';
    source= {};
    reader;
    docx =false;
    showLoadedFile = false;
    blobURL;
    controls = document.querySelector('.controls');

    play = document.querySelector('.play');
    stop = document.querySelector('.stop');
    rwd = document.querySelector('.rwd');
    fwd = document.querySelector('.fwd');

    timerWrapper = document.querySelector('.timer');
    timer = document.querySelector('.timer span');
    timerBar = document.querySelector('.timer div');

  connectedCallback() {
    loadStyle(this, styles);
   
    setTimeout(() => {
        this.home = false;
      this.cloud=true;
    }, 5000);
  }
  renderedCallback() {
    loadScript(this,javascript)
    .then(() => console.log('Loaded sayHello'))
    .catch(error => console.log('error>>>>',error));
}

    handleUploadFinished(event){ 
      console.log('OUTPUT : ',event);
  //  console.log(event.target.files);
    if(event.target.files.length > 0) {
        this.uploadedFile = event.target.files;
        this.fileName = event.target.files[0].name;
        this.source = event.target.files[0];
        console.log('this.source ',event.target.files[0]);
        if(this.fileName !==null && this.fileName !== '' && (this.fileName.includes('.jpg') ||  this.fileName.includes('png')  || this.fileName.includes('txt'))){
            this.showLoadedFile = true;
            this.image = true;
            this.pdf = false;
            this.pdf = false;
             let reader = new FileReader();
          reader.onloadend = () => {
    // convert file to base64 String
    console.log('reader : ',reader);
    this.reader = reader.result;
    const base64String = reader.result.replace('data:', '').replace(/^.+,/, '');
    console.log('base64String : ',base64String);
     localStorage.setItem('reader', base64String);

//  if (base64String !== null && base64String !== '' && typeof base64String !== undefined && this.code !== null && this.code !== '' && typeof this.code !== undefined) {
//             doPost({ 'code': JSON.stringify(this.code[0]), 'text': this.base64String}).then(result => {
//            if(result === 201){
//                      this.showSuccess();
//                 }
//                 console.log('result : ',result);
//             });
//         }
//         else
//         {
//          //   this.showError();
//          console.log('Error : ');
//         }
  }
       //  localStorage.setItem("image", reader.result);
         
          reader.readAsDataURL(this.source);
        }
        else if(this.fileName !==null && this.fileName !== '' && (this.fileName.includes('.mp4') || this.fileName.includes('docx') ||  this.fileName.includes('.mkv') || this.fileName.includes('.webm') || this.fileName.includes('.pdf'))){ 
            this.showLoadedFile = true;
            this.image = false;
              if(this.fileName.includes('pdf')){
              this.pdf = true;
              this.docx = false;
              this.image = false;
             }else       
             if(this.fileName.includes('docx')){
              this.docx = true;
              this.pdf = false;
              this.image = false;
             }           
}
        }
    } 

submit(event){
    console.log("Before everything");
    if(this.uploadedFile.size > this.MAX_FILE_SIZE){
        console.log("File size too large");
    }
    console.log("Before fileReader");
    this.fileReader= new FileReader();
    console.log(this.fileReader);
    this.fileReader.onloadend = (() => {
        this.fileContents = this.fileReader.result;
        console.log(this.fileContents);
        let base64 = 'base64,';
        this.content = this.fileContents.indexOf(base64) + base64.length;
        this.fileContents = this.fileContents.substring(this.content);
        console.log("Save To File");
        // call the uploadProcess method 
        this.saveToFile();
    });

    this.fileReader.readAsDataURL(this.file);
}

// saveToFile() {
//     console.log("In save to file");
//     saveFile({ idParent: this.recordId, strFileName: this.file.name, base64Data: encodeURIComponent(this.fileContents)})
//     .then(result => {
//         console.log('result ====> ' +result);
//         // refreshing the datatable
//         this.getRelatedFiles();

//         this.fileName = this.fileName + ' - Uploaded Successfully';
//         this.UploadFile = 'File Uploaded Successfully';
//         this.isTrue = true;
//         this.showLoadingSpinner = false;

//         // Showing Success message after file insert
//         this.dispatchEvent(
//             new ShowToastEvent({
//                 title: 'Success!!',
//                 message: this.file.name + ' - Uploaded Successfully!!!',
//                 variant: 'success',
//             }),
//         );

//     })
//     .catch(error => {
//         // Showing errors if any while inserting the files
//         console.log(error);
//         this.dispatchEvent(
//             new ShowToastEvent({
//                 title: 'Error while uploading File',
//                 message: error.message,
//                 variant: 'error',
//             }),
//         );
//     });
// } 

showToast() {
        const event = new ShowToastEvent({
            title: 'Get Help',
            message:
                'You aren`t authorized to post',
        });
        this.dispatchEvent(event);
    }
showError() {
    this.template
      .querySelector("c-custom-toast-notification")
      .showToast("error", "Something went wron.....");
  }
  showWarning() {
    this.template
      .querySelector("c-custom-toast-notification")
      .showToast("warning", "You are not authorized");
  }
  showSuccess() {
    this.template
      .querySelector("c-custom-toast-notification")
      .showToast("success", "Post Has been posted successfully");
  }
  showInfo() {
    this.template
      .querySelector("c-custom-toast-notification")
      .showToast("info", "This is a Info Message.");
  }
  }