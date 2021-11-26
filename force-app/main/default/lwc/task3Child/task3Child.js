import { LightningElement, track, wire,api } from 'lwc';
 import getContactsofAccount from '@salesforce/apex/getRecordDataController.getContactsofAccount';
export default class conatactListItem extends LightningElement {
   
    @api stroutput;
    @track records;
    @track errorMsg;    
   
    @wire (getContactsofAccount, {accId:'$strOutput'})
      wireConRecord({error,data}){
          console.log('accountId',this.strOutput);
          console.log('data',data);
        if(data){
          this.records = data;     
          this.errorMsg = undefined;    
        }else{         
          this.errorMsg = error;
          this.records = undefined;
        }
      }
 
    handleChangeAction(event){
      this.accountId = event.detail;
      window.console.log('accountId ' + this.accountId);
    }
}