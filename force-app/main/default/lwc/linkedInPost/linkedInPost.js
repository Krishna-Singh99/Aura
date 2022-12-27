import { LightningElement, api, track, wire } from 'lwc';
import doPost from '@salesforce/apex/Salesforce_Integration_With_LinkedIn.postUCG';
import deleteUserInfoThroughDB from '@salesforce/apex/Salesforce_Integration_With_LinkedIn.deleteUserInfoThroughDB';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class LinkedInPost extends LightningElement {
    inputText;
    @api code='';
    sticky = false;
  timeout = 3000;
    handleinput(event) {
        this.inputText = event.target.value;  
        console.log(' this.inputText : ', this.inputText);
}
handlepost(){
    console.log('indide button');
     console.log(' this.inputText : ', this.inputText);
     console.log('OUTPUT : ',typeof this.code);
     let codevalue = JSON.stringify(this.code[0]);
     console.log('codevalue : ',codevalue);
 if (this.inputText !== null && this.inputText !== '' && typeof this.inputText !== undefined && this.code !== null && this.code !== '' && typeof this.code !== undefined) {
            doPost({ 'code': JSON.stringify(this.code[0]), 'text':  this.inputText}).then(result => {
                if(result === 201){
                     this.showSuccess();
                }
                console.log('result : ',result);
            });
        }
        else
        {
            this.showWarning();
           deleteUserInfoThroughDB().then(result =>{
           console.log('result',result);
           window.location.reload();
           });
        }
}

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
      .showToast("error", "This is an Error Message.");
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