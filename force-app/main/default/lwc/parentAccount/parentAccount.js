import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/getRecordDataController.getAccounts';
export default class RecordIdInLWC extends LightningElement {

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Id', fieldName: 'Id' },
        { label: 'Phone', fieldName: 'Phone' },
        { label: 'isActive', fieldName: 'Active__c' },
    ];
     Ids=[];
    isContactVisible = false;
    isOpportunity = false;
    accountData;
    @track accId;
    showChild = false;
    connectedCallback() {
        getAccounts().then((result) => {
            this.accountData = result;
        }).catch((err) => {

        });
    }
    selectedAccId ;
    handleAccountClick(event) {

        this.selectedAccId = event.detail.selectedRows;
       
        console.log('selectedAccID>>>>', this.selectedAccId);
        // this.accId = this.selectedAccId['Id'];
        // console.log('accId>>>', this.accId);
        // this.showChild = true;
    }
    handleClick(event) {
        
        if (this.selectedAccId) {
            if(this.selectedAccId.length>0){
                // this.isContactVisible = false;
                console.log('id>>>',event.target.name);
                this.Ids = [];
                this.selectedAccId.forEach(element => {
                    this.Ids.push(element.Id);
                }
                );
                console.log("ids : ",this.Ids);
            }else{
                console.log('Inside Toast');
              const evt = new ShowToastEvent({
                title: 'Warning',
                message: 'Please Select Id First',
                variant: 'warning',
                mode: 'dismissable'
              });
              this.dispatchEvent(evt);
            }
           
            if(event.target.name=='Contact' ){
                this.isContactVisible = true;
                this.isOpportunity = false;
            }else if(event.target.name=='Opportunity'){
                this.isOpportunity = true;
                this.isContactVisible = false;
            }else if(event.target.name=='Both'){
                this.isOpportunity = true;
                this.isContactVisible = true;
            }
            
        }else{
            console.log('Inside Toast');
          const evt = new ShowToastEvent({
            title: 'Warning',
            message: 'Please Select Id First',
            variant: 'warning',
            mode: 'dismissable'
          });
          this.dispatchEvent(evt);
        }
    }
    handleEventToast(event){
        console.log('Inside Toast');
          const evt = new ShowToastEvent({
            title: 'Warning',
            message: 'No related Records',
            variant: 'warning',
            mode: 'dismissable'
          });
          this.dispatchEvent(evt);
    }
       
    
    handleRefresh(event) {
        eval("$A.get('e.force:refreshView').fire();");
    }

}