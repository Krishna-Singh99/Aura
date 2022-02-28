import { LightningElement,wire,track } from 'lwc';
import getAccountList from '@salesforce/apex/AccountController.getAccountList';

export default class LwcParent extends LightningElement {
    @track selectedAccountId;
    @wire(getAccountList) accountList;  
    onAccountSelection(event){
        this.selectedAccountId = event.detail.recordId;
    }
}