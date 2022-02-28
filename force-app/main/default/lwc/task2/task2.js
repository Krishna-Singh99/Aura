import { LightningElement,track,wire } from 'lwc';
import My_Resource from '@salesforce/resourceUrl/img';
import { refreshApex } from '@salesforce/apex';
import getAccounts from '@salesforce/apex/getRecordDataController.getAccounts';
import getLimitedAccounts from '@salesforce/apex/getRecordDataController.getLimitedAccounts';
import getContacts from '@salesforce/apex/getRecordDataController.getContacts';
import getOpportunity from '@salesforce/apex/getOpportunityRecordControlller.getOpportunity';
export default class task2 extends LightningElement {
logo = My_Resource + '/img/handshake.jpg';

value = 'All';

get options() {
return [    
    { label: '5', value: '5' },
    { label: '10', value: '10' },
    { label: '20', value: '20' },
        { label: '30', value: '30' },
];
}

handleChange(event) {
this.pageSize =  parseInt(event.detail.value);
  if( this.eventTargetAccount == 'Account'){
this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
this.page=1;
  }else
  if( this.eventTargetAccount == 'Contact'){
this.totalPage = Math.ceil(this.totalRecountCount1 / this.pageSize);
this.page=1;
this.value = 'All';
  }else
  if( this.eventTargetAccount == 'Opportunity'){
this.totalPage = Math.ceil(this.totalRecountCount2 / this.pageSize);
this.page=1;
  }
this.displayRecordPerPage(this.page); 

    
//this.items = this.items.slice(0,this.pageSize);
console.log('value',this.value);
}



columns = [
{ label: 'id', fieldName: 'Id' },
{ label: 'Name', fieldName: 'Name'},
{ label: 'Active', fieldName: 'Active__c'}

];

oppColumns = [
{ label: 'id', fieldName: 'Id' },
{ label: 'StageName', fieldName: 'StageName'}

];
conColumns = [
{ label: 'id', fieldName: 'Id' },
{ label: 'LastName', fieldName: 'LastName'}

];
eventTargetAccount;
isButton = false;
dataTableVisible = false;
currentDataColumn;
isVisible = true;
isBlog = false;
page = 1;
combBox = false;
totalRecords=0;
column;
    startingRecord = 1; 
endingRecord = 0; 
pageSize = this.value; 
totalPage=0;
items = [];
items1 = [];
items2 = [];
totalRecountCount = 0;
totalRecountCount1 = 0;
totalRecountCount2 = 0;

connectedCallback(){
getAccounts()
.then(result => {
this.totalRecords = result.length;
if (result) {
this.items =  result;
        this.totalRecountCount = result.length; //here it is 23
        this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
        //  console.log('this.totalPage',this.totalPage);
        result= this.items.slice(0,this.pageSize);           
        //  console.log(' this.datastore', result);
        this.endingRecord = this.pageSize;
        this.column = columns;

        this.error = undefined;
    } else if (error) {
        this.error = error;
        result = undefined;
    
}
this.error = undefined;
}).catch(error => {
this.error = error;
this.datastore = undefined;
});


getContacts()
.then(result => {
this.totalRecords = result.length;
if (result) {
this.items1 =  result;
        this.totalRecountCount1 = result.length; 
        this.totalPage = Math.ceil(this.totalRecountCount1 / this.pageSize);
        //  console.log('this.totalPage',this.totalPage);
        result= this.items1.slice(0,this.pageSize);           
        //  console.log(' this.datastore', result);
        this.endingRecord = this.pageSize;
        this.error = undefined;
    } else if (error) {
        this.error = error;
        result = undefined;
    
}
this.error = undefined;
}).catch(error => {
this.error = error;
this.items1 = undefined;
});
getOpportunity()
.then(result => {
this.totalRecords = result.length;
if (result) {
this.items2 =  result;
        this.totalRecountCount2 = result.length; 
        this.totalPage = Math.ceil(this.totalRecountCount2 / this.pageSize);
        //  console.log('this.totalPage',this.totalPage);
        result= this.items2.slice(0,this.pageSize);           
        //  console.log(' this.datastore', result);
        this.endingRecord = this.pageSize;
        this.error = undefined;
    } else if (error) {
        this.error = error;
        result = undefined;
    
}
this.error = undefined;
}).catch(error => {
this.error = error;
this.items2 = undefined;
});

}   
        


datatable(event){
console.log(event.currentTarget.dataset.value);
this.eventTargetAccount = event.currentTarget.dataset.value;
this.homePageVisible = false;
    this.combBox = true;
    this.dataTableVisible = true;
if(event.currentTarget.dataset.value == 'Account'){
    this.currentDataColumn = this.columns;
        this.finalData = this.items;
        
          this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
    this.isButton = true;
    this.isVisible = false;
this.isBlog = false;
        
    }else  if(event.currentTarget.dataset.value  == 'Contact'){
            this.currentDataColumn = this.conColumns;
        this.finalData = this.items1;
        this.totalPage = Math.ceil(this.totalRecountCount1 / this.pageSize);
        this.isVisible = false;
        this.value = 'All';
            this.isButton = true;
    this.isBlog = false;
  
    }else if(event.currentTarget.dataset.value == 'Opportunity'){
        this.currentDataColumn = this.oppColumns;
        this.finalData = this.items2;
         this.totalPage = Math.ceil(this.totalRecountCount2 / this.pageSize);
            this.isBlog = false;
            this.isButton = true;
    this.isVisible = false;   
    }
}

home(){
this.dataTableVisible = false;
this.combBox = false;
    this.isButton = false;
this.finalData  = null;
    this.isBlog = false;
this.isVisible = true;
}

blogs(){
this.dataTableVisible = false;
this.combBox = false;
    this.isButton = false;
this.finalData  = null;
this.isVisible = false;
this.isBlog = true;
}

previousHandler() {
    if (this.page > 1) {
        this.page = this.page - 1; 
        this.displayRecordPerPage(this.page);
    }
}
    nextHandler() {
    if((this.page<this.totalPage) && this.page !== this.totalPage){
        this.page = this.page + 1; //increase page by 1
        this.displayRecordPerPage(this.page);            
    }             
}


displayRecordPerPage(page){
    this.startingRecord = ((page -1) * this.pageSize) ;
    this.endingRecord = (this.pageSize * page);
    this.endingRecord = (this.endingRecord > this.totalRecountCount) 
                        ? this.totalRecountCount : this.endingRecord; 
                        //   this.accountList=null;
                        console.log(this.eventTargetAccount);  
                        if( this.eventTargetAccount == 'Account'){

                        this.finalData = this.items.slice(this.startingRecord, this.endingRecord);
                        }else                  
                        if( this.eventTargetAccount == 'Contact'){
                        this.finalData = this.items1.slice(this.startingRecord, this.endingRecord);
                        }    
                        else                  
                        if( this.eventTargetAccount == 'Opportunity'){
                        this.finalData = this.items2.slice(this.startingRecord, this.endingRecord);
                        }    
                    
    this.startingRecord = this.startingRecord + 1;
}       
refreshData() {
    return refreshApex(this.accountList);

}

}