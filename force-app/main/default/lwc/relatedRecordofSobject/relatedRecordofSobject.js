import { LightningElement, api, wire } from 'lwc';
import { getRecord  } from 'lightning/uiRecordApi';
// const FIELDS = [
//     'Contact.AccountId',
// ];

const FIELDS1 = [
    'Contact.Name',
    'Contact.Account.Name',
 
 
];

export default class WireGetRecordDynamicContact extends LightningElement {
   accid;
  isVisible=false;
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields:FIELDS1  })
    contact;
   
    get accName() {  
         console.log(this.contact,'<<<<contact');
         if(this.contact.data.fields.Account.value.id){
             this.isVisible = true;
           this.accid =  this.contact.data.fields.Account.value.id;
         }
        
     
              
        console.log( this.accid,'<<<< this.accid');
    }
    
}