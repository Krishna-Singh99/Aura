import { LightningElement,track,api,wire } from 'lwc';
import AWS_Request from '@salesforce/apex/AWS_Request.awsRequestforbody';
export default class filesDetails extends LightningElement {
   @track details = [];
  connectedCallback(){
   
    AWS_Request()
    .then(result => {
      console.log('result',JSON.parse(result));
        this.details = JSON.parse(result);
        console.log();
        this.error = undefined;
    })
    .catch(error => {
        this.error = error;
        console.log('error',error);
        this.contacts = undefined;
    });
}    
}