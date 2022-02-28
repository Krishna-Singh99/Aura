import { LightningElement, track, wire} from 'lwc';
import getOpportunity from '@salesforce/apex/getOpportunityRecordControlller.getOpportunity';
export default class GetOppportunityDisplaydata extends LightningElement {
  columns = [
    { label: 'id', fieldName: 'Id' },
    { label: 'StageName', fieldName: 'StageName'},
    
];
 opportunityList;
@wire (getOpportunity) wiredOpportunity({data,error}){
  if (data) {
       this.opportunityList = data;
  console.log(data); 
  } else if (error) {
  console.log(error);
  }
}
}