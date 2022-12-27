import { LightningElement, wire, api, track } from 'lwc';
import getUserInfoThroughDB from '@salesforce/apex/Salesforce_Integration_With_LinkedIn.getUserInfoThroughDB';
import getaccessToken from '@salesforce/apex/Salesforce_Integration_With_LinkedIn.getAccessToken';
//import { CurrentPageReference } from 'lightning/navigation';

export default class LinkedIn_Integration extends LightningElement {
  showspinner = false;
  showAuthorizeTab = true;
  hreflink = '';
  urlcode = '';
  datavisible = false;
  isvisible = true;
  doArticlePost = false;
  @track sfdcBaseURL;
  codelink = '';
  codelinkfoeart = ''
  state = '';
  profile_detail = {
    Firstname: "",
    LastName: "",
    ProfileUrl: "",
    Prefered_Language: "",
    Id: "",
  }
  authorizeVisible = false;
  doPost = false;
  dohelp = false;

  connectedCallback() {
    let clientid = '86mkovck9p2jgg';
    let redirect_uri = 'https://cloudanalogy-64d-dev-ed.lightning.force.com/c/Calling_LWC_LinkedIn.app';
    this.hreflink = 'https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=' + clientid + '&redirect_uri=' + redirect_uri + '&state=foobar&scope=r_liteprofile%20r_emailaddress%20w_member_social';
  getUserInfoThroughDB().then(result => {
            if(result != '' && result !=null && typeof result != undefined){
              let jsonParse = JSON.parse(result);
              if (jsonParse !== null && typeof jsonParse !== undefined && jsonParse !== '') {
            this.profile_detail.Firstname = jsonParse.firstName.localized.en_US;
            this.profile_detail.LastName = jsonParse.lastName.localized.en_US;
            this.profile_detail.ProfileUrl = jsonParse.profilePicture["displayImage~"].elements[3].identifiers[0].identifier;
            this.profile_detail.Prefered_Language = jsonParse.firstName.preferredLocale.language;
            this.profile_detail.Id = jsonParse.id;
          }
           this.showAuthorizeTab = false;
           this.doArticlePost = false;
          this.isvisible = false;
          this.datavisible = true;
          this.dohelp = false;
            this.error = undefined;
            }
         
        })
        .catch(error => {
            this.error = error;
            this.contacts = undefined;
        });
  }
  home() {
    this.isvisible = true;
    this.doArticlePost = false;
    this.authorizeVisible = false;
    this.dohelp = false;
    this.datavisible = false;
      this.doPost = false;
  }
  authorize() {
    this.authorizeVisible = true;
    this.doPost = false;
    // console.log('this.authorizeVisible 12344',this.authorizeVisible);
    this.isvisible = false;
    // console.log('this.isvisible 12344',this.isvisible);
    // let clientid = '86mkovck9p2jgg';
    // let redirect_uri = 'https://cloudanalogy-64d-dev-ed.lightning.force.com/c/Calling_LWC_LinkedIn.app';
    // this.hreflink = 'https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=' + clientid + '&redirect_uri=' + redirect_uri + '&state=foobar&scope=r_liteprofile%20r_emailaddress%20w_member_social';

    this.sfdcBaseURL = window.location.href;
    let code = '';
    let state = '';
      
    if (this.sfdcBaseURL !== null && typeof this.sfdcBaseURL !== undefined && this.sfdcBaseURL !== '') {
      code = this.sfdcBaseURL.split('code=');
      //   console.log(' code : ', code);
    }
    if (code !== null && typeof code !== undefined && code !== '' && code.length >= 2) {
      state = code[1].split('&state=');
    }
    // console.log(' state : ', state);
    if (state !== null && typeof state !== undefined && state !== '') {
      this.codelink = state;
      this.codelinkfoeart = state;
      getaccessToken({ 'code': state }).then(result => {
        if (result !== '400' && result !== '500' && result !== 400 && result !== null && typeof result !== undefined) {
          // let resultdata = JSON.stringify(result);
          let jsonParse = JSON.parse(result);
          if (jsonParse !== null && typeof jsonParse !== undefined && jsonParse !== '') {
            this.profile_detail.Firstname = jsonParse.firstName.localized.en_US;
            this.profile_detail.LastName = jsonParse.lastName.localized.en_US;
            this.profile_detail.ProfileUrl = jsonParse.profilePicture["displayImage~"].elements[1].identifiers[0].identifier;
            this.profile_detail.Prefered_Language = jsonParse.firstName.preferredLocale.language;
            this.profile_detail.Id = jsonParse.id;
          }
          this.showspinner = true;
          this.doArticlePost = false;
          this.showAuthorizeTab = false;
          this.dohelp = false;
          this.isvisible = false;
          this.datavisible = true;
          setTimeout(() => {
            this.showspinner = false;
          }, 3000);

        }
        else {
          console.log('not authorized : ');
        }
      });
    }
  }

  personalData() {
    this.showAuthorizeTab = false;
    this.isvisible = false;
    this.datavisible = true;
    this.doPost = false;
    this.doArticlePost = false;
    this.dohelp = false;
  }
  handlepost() {
    this.isvisible = false;
    this.authorizeVisible = false;
    this.datavisible = false;
    this.doPost = true;
    this.doArticlePost = false;
    this.dohelp = false;
  }
  handlearticlepost () {
    this.doArticlePost = true;
     this.isvisible = false;
    this.authorizeVisible = false;
    this.datavisible = false;
    this.doPost = false;
    this.dohelp = false;
  }
  handlehelp(){
    console.log('inside help');
      this.doArticlePost = false;
     this.isvisible = false;
    this.authorizeVisible = false;
    this.datavisible = false;
    this.doPost = false;
    this.dohelp = true;
  }
}