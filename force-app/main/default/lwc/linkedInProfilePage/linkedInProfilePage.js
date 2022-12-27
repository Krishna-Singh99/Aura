import { LightningElement,api,track } from 'lwc';
export default class LinkedInProfilePage extends LightningElement {
@api userinfomap;
filteredDta;
jsonParse;

connectedCallback() {
    if(this.userinfomap !==null && typeof this.userinfomap !== undefined && this.userinfomap !== ''){
    this.filteredDta = JSON.stringify(this.userinfomap);
    this.jsonParse = JSON.parse(this.filteredDta);
    }
   
}

}