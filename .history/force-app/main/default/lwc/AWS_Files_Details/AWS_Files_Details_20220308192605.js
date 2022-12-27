import { LightningElement,track,api,wire } from 'lwc';
import AWS_Request from '@salesforce/apex/AWS_Request.awsRequestforbody';
export default class filesDetails extends LightningElement {
   @track details = [];
  connectedCallback(){
   
    AWS_Request()
    .then(result => {
      console.log('result',result);
        this.details = result;
        this.error = undefined;
    })
    .catch(error => {
        this.error = error;
        this.contacts = undefined;
    });
}    
}