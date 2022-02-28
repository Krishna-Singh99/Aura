import { LightningElement,api } from 'lwc'; 
import getAccounts from '@salesforce/apex/getRecordDataController.getAccounts';
export default class RecordIdInLWC extends LightningElement {
     @api accountList;
    columns = [
          { label: 'Name', fieldName: 'Name' },
          { label: 'Id', fieldName: 'Id'},
          { label: 'Phone', fieldName: 'Phone'},
          { label: 'isActive', fieldName: 'Active__c'},
      ];
    accountData;
    connectedCallback() {
        getAccounts().then((result) => {
            this.accountData = result;
        }).catch((err) => {
            
        });
    }
    selectedAccId=[];
  handleAccountClick(event) {

        this.selectedAccId = event.detail.selectedRows[0];
        let accountId = this.selectedAccId['Id'];
        console.log('selectedAccId',this.selectedAccId['Id']);
 
        const passEvent = new CustomEvent('accountselection', {
            detail:{recordId:accountId} 
        });
       this.dispatchEvent(passEvent);
    }
    handleRowAction(event) {
        const row = event.detail.row;
        console.log('row',this.row);
    }
}