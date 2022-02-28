import { LightningElement, track, wire,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 import getContactsofAccount from '@salesforce/apex/getRecordDataController.getContactsofAccount';
export default class conatactListItem extends LightningElement {
   
    @api stroutput;
    records=[];
   errorMsg;
   
    columns = [
      { label: 'Id', fieldName: 'accountId'},
      { label: 'FirstName', fieldName: 'FirstName' },
          { label: 'LastName', fieldName: 'LastName' },
          { label: 'AccountName', fieldName: 'accountName' },
      ];
    @wire (getContactsofAccount, {accId:'$stroutput'})
    wrapperList({error,data}){
        console.log('acc',this.stroutput);
        if(data){
          if(data.length>0){
            this.records = data;
            console.log( this.records);
            console.log('accountIdname',this.records);
            console.log('data',data);
          }
          else{
            const errorToast = new CustomEvent('handlecustomtoast');
          this.dispatchEvent(errorToast);
          }      
        }else{ 
          this.errorMsg = error;
          this.records = undefined;
        }
      }

}