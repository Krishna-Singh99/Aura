import { LightningElement,track } from 'lwc';
import getpaymentlink from '@salesforce/apex/SalesforceIntegrationwithRazor.createPaymentLink';
export default class ContactForm extends LightningElement {
 emailvalue ="username@example.com";
    mobilevalue= "000-000-0000";
    namevalue= "john";
    amountvalue= 100;
    contact = {};
    isactive = false;
     amount=0;
          name='';
         contacts=0;
          email='';
    /* 
    *   This method is used to check if all the input fields 
    *   that we need to validate are valid or not. We're also going
    *   to populate our contact object so that it can be sent to apex
    *   in order to save the details in salesforce
    */
    isInputValid() {
        let isValid = true;
      
        let inputFields = this.template.querySelectorAll('.validate');
        console.log('inputFields>>>',inputFields);
        inputFields.forEach(inputField => {
            this.contact[inputField.name] = inputField.value;
            // if( this.contact[inputField.name]=='Amount'){
            //  console.log('inside iffffffffff')
            //  amount=inputField.value;
            // }
            // else
            //  if( this.contact[inputField.name]=='Name'){
            //  name=inputField.value;
            // }
            // else
            //  if( this.contact[inputField.name]=='Contact'){
            //  contacts=inputField.value;
            // }
            // else
            //  if( this.contact[inputField.name]=='Email'){
            //  email=inputField.value;
            // }
            
        });

        return isValid;
    }
     handleAmountChange(event){
        this.amountvalue = event.detail.value;
        console.log('amountval>>>>', this.amountvalue);
    } 
handleEmailChange(event){
        this.emailvalue = event.detail.value;
        console.log('emailval>>>>',this.emailvalue);
    } 

    handleMobileChange(event){
        this.mobilevalue = event.detail.value;
         console.log('this.mobilevaluel>>>>',this.mobilevalue);
    } 
    
   
    handleNameChange(event){
        this.namevalue = event.detail.value;
         console.log('this.namevalue',this.namevalue);
    } 
    createContact(event) {
        // if(this.isInputValid()) {
        //     console.log(this.contact);
        // }
      //  console.log('what>>>>',this.amount, this.contacts, this.email, this.name);
      console.log(event.target.value);
        this.amount=event.target.value;
        this.contacts=event.target.value;
        this.email=event.target.value;
        this.name=event.target.value;
         getpaymentlink({amount:this.amountvalue,contact:this.mobilevalue,email:this.emailvalue,name:this.namevalue})
            .then((result) => {
                window.open(result,"_blank");
               console.log('result>>>>',result);
            });
    }
   
    //  connectedCallback(){
    //        console.log('this.contact>>>>',this.contact);
    //      if(this.isactive){
    //     getpaymentlink({str:this.contact})
    //         .then((result) => {
    //             this.isButtonDisabled = result;
    //         })
    //         .catch(error => {
    //             const event = new ShowToastEvent({
    //                 variant: 'error',
    //                 title: 'Error when checking if default data was created',
    //                 message: 'Error received: code' + error.errorCode + ', message: ' + error.body.message
    //             });
    //             this.dispatchEvent(event);
    //         });
    // }
    //  }
}