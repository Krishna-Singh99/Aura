import { LightningElement, track, wire,api } from 'lwc';
 import getProductofAccount from '@salesforce/apex/getRecordDataController.getProductofAccount';
export default class conatactListItem extends LightningElement {
   
    @api stroutput;
    records;
   errorMsg;    
   
    columns = [
          { label: 'Product2Id', fieldName: 'Product2Id' },
      { label: 'Id', fieldName: 'Id'},
      { label: 'Quantity', fieldName: 'Quantity' },
          { label: 'TotalPrice', fieldName: 'TotalPrice' },
           { label: 'UnitPrice', fieldName: 'UnitPrice' },
         
         
          
      ];
    @wire (getProductofAccount, {oppId:'$stroutput'})
      wireConRecord({error,data}){
        if(data){
            console.log('accountId',this.stroutput);
          console.log('data',data);
          this.records = data;     
          console.log( this.records);
          this.errorMsg = undefined;    
        }else{         
          this.errorMsg = error;
          this.records = undefined;
        }
      }
}