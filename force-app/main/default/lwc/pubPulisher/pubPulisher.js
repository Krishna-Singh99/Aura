import { LightningElement } from 'lwc';
import pubsub from 'c/publisher'; 
export default class PubsubPublisher extends LightningElement {

    handleClick(){
        window.console.log('Event Firing..... ');
        let msg = {
            "message" : 'Hello Krishna'
        }
        pubsub.fire('simplevt', msg );
        window.console.log('Event Fired ');
    }
}