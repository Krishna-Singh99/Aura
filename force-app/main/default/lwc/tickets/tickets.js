import { LightningElement, api, wire } from 'lwc';
//import fetchRecords from '@salesforce/apex/CMT_TicketController.fetchRecords';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import CASE_OBJECT from '@salesforce/schema/Case';

export default class CmpCreateTicket extends LightningElement {
    @api objectName;
    @api fieldName;
    @api recordType;
    @api label;
    @api iconName;
    @api placeholder;
    data;
    subject = '';
    caseRecordTypeId;
    searchList = [];
    description = '';
    searchString;
    message = false;
    selectedRecord;
    recordsList;
    showPill = false;
    showSpinner = false;
    showDropdown = false;

    connectedCallback() {
     //   this.fetchData();
   }

    /* *************************************************************************************
    *Description
       This wire method is used to get the CASE RecordTypeId based on Record Type Name
    /* ************************************************************************************* */

    @wire(getObjectInfo, { objectApiName: CASE_OBJECT })
    wiredRecordType({ error, data }) {
        if (data) {
            const recordTypeList = data.recordTypeInfos;
            this.caseRecordTypeId = Object.keys(recordTypeList).find(element => recordTypeList[element].name === 'Link Failure');
        } else if (error) {
            this.error = error;
        }
    }

    /* *************************************************************************************
    *Description
       This method is used to fetch the data from the Apex Controller
    /* ************************************************************************************* */

   fetchData() {
        this.showSpinner = true;
        this.recordsList = [];
        fetchRecords({
            objectName: this.objectName,
            fieldName: this.fieldName,
            recordType: this.recordType
        })
            .then(result => {
                if (result && result.length > 0) {
                    console.log('result>>', result);
                    this.data = result;
                }
                this.showSpinner = false;
            }).catch(error => {
                this.error = error;
                this.showSpinner = false;
            })
    }
     
    /* *************************************************************************************
        *Description
        This method for searching the records based on the FieldName values
    /* ************************************************************************************* */

    searchRecords(event) {
        this.message = false;
        this.searchString = (event.target.value).toLowerCase().trim();
        let recordList = [];
        if (this.searchString) {
            this.data.forEach(element => {
                if (element[this.fieldName] && element[this.fieldName].toLowerCase().startsWith(this.searchString)) {
                    if (!recordList.includes(element)) {
                        recordList.push({
                            label: element[this.fieldName],
                            value: element.Id
                        });
                        this.searchList = recordList;
                        this.showDropdown = true;
                    }
                }
            });
        } else {
            this.showDropdown = false;
        }
        if (recordList.length <= 0) {
            this.message = true;
        }
    }

    /* *************************************************************************************
    *Description
       This method is used to select the record and convert it into the pill
    /* ************************************************************************************* */

    selectItem(event) {
        if (event.currentTarget.dataset.key) {
            let index = this.searchList.findIndex(x => x.value === event.currentTarget.dataset.key);
            if (index !== -1) {
                this.selectedRecord = this.searchList[index];
                this.showDropdown = false;
                this.showPill = true;
            }
        }
    }

    blurEvent() {
        this.showDropdown = false;
    }

    /* *************************************************************************************
    *Description
       This method is used to deselect the selected record
    /* ************************************************************************************* */

    removeItem() {
        this.showPill = false;
        this.value = '';
        this.selectedRecord = '';
        this.searchString = '';
    }

    /* *************************************************************************************
    *Description
       This method works on onClick functionality of Input lookup field and display random records
    /* ************************************************************************************* */

    showRecords() {
        if (this.data) {
            this.message = false;
            this.data.forEach(element => {
                this.searchList.push({
                    label: element[this.fieldName],
                    value: element.Id
                });
            });
            this.showDropdown = true;
        }
    }

    /* *************************************************************************************
    *Description
       This method is used to create Case records
    /* ************************************************************************************* */

    handleCreateTicket() {
        this.subject = 'Hello';
        const fields = {
            Description: this.description,
            AssetId: this.selectedRecord.value,
            RecordTypeId: this.caseRecordTypeId,
            Subject: this.subject
        };
        const recordInput = { apiName: CASE_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'New Ticket has been created',
                        variant: 'success',
                    }),
                );
                this.description = '';
                this.subject = '';
                this.showPill = false;
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error while creating Ticket',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }

    handleTextChange(event) {
        this.subject = event.target.value;
        console.log('inside handleTextChange');
        this.handleCreateTicket();
    }

    /* *************************************************************************************
    *Description
       This method is used to store the description value
    /* ************************************************************************************* */

    handleChange(event) {
        this.description = event.target.value;
    }
}