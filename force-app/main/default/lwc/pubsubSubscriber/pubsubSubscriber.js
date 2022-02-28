import { LightningElement,track } from 'lwc';
import pubsub from 'c/publisher'; 
export default class PubsubSubscriber extends LightningElement {

   @track message;
    connectedCallback(){
        this.regiser();
    }
    regiser(){
        window.console.log('event registered ');
        pubsub.register('simplevt', this.handleEvent.bind(this));
    }
    handleEvent(messageFromEvt){
        window.console.log('event handled ', JSON.stringify(messageFromEvt));
        this.message = messageFromEvt ? JSON.stringify(messageFromEvt, null, '\t') : 'no message payload';
    }
}