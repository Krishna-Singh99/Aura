import { LightningElement, track, wire,api } from 'lwc';
 import getOpportunityofAccount from '@salesforce/apex/getRecordDataController.getOpportunityofAccount';
export default class conatactListItem extends LightningElement {
   
    @api stroutput;
    @track accId;
    records;
   errorMsg;    
   
    columns = [
      { label: 'Id', fieldName: 'OpportunityId'},
      { label: 'Name', fieldName: 'Name' },
          { label: 'Stagename', fieldName: 'Stagename' },
          { label: 'AccountId', fieldName: 'AccountName' }, 
          
      ];
    @wire (getOpportunityofAccount, {accId:'$stroutput'})
    wrapperList({error,data}){
        if(data){
          if(data.length>0){
            this.records = data;     
            console.log( this.records);
            this.errorMsg = undefined;    
          }else{
            const errorToast = new CustomEvent('handleopportunitytoast');
          this.dispatchEvent(errorToast);
          }
         
        }else{         
          this.errorMsg = error;
          this.records = undefined;
        }
      }
      selectedoppId=[];
    int=0;
       handleOpportunityClick(event) {
      
        this.selectedoppId = event.detail.selectedRows[this.int];
        this.int += 1;
        console.log('selectedOppID>>>>',this.selectedoppId['Id']);
        this.accId = this.selectedoppId['Id'];
        console.log('accId>>>', this.accId);
        this.showChild = true;

    }
}