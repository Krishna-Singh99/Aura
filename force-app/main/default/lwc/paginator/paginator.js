import { LightningElement } from 'lwc';

export default class Paginator extends LightningElement {
    previousHandler() {
        this.dispatchEvent(new CustomEvent('previous'));
    }
 showSuccessNotification() {
        const evt = new ShowToastEvent({
            title: "Success",
            message: "This is sample success message",
            variant: "success",
        });
    }
    nextHandler() {
         this.showSuccessNotification();
        this.dispatchEvent(new CustomEvent('next'));
       
    }
}