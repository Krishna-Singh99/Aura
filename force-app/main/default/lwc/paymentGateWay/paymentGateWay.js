import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import payment from '@salesforce/apex/IntegrateWithAuthorizeNet.IntegrateWithAuthorizeNet';
import countrycc from '@salesforce/apex/CountryPickList.fetchCountryfields';
export default class PaymentGateWay extends LightningElement {

value = 'Select';
bank = 'Select';
countryName = [{}];
get options() {
  return [
    { label: 'MasterCard', value: 'MasterCard' },
    { label: 'Credit', value: 'Credit' },
    { label: 'Debit', value: 'Debit' },
    { label: 'American Express', value: 'American Express' },
    { label: 'Visa', value: 'Visa' },
  ];
}
get country() {
  return [
    { label: 'India', value: 'India' },
    { label: 'USA', value: 'USA' },
    { label: 'Russia', value: 'Russia' },
    { label: 'China', value: 'China' },
    { label: 'Japan', value: 'Japan' },
  ];
}
get banks() {
  return [
    { label: 'Allahabad', value: 'Allahabad' },
    { label: 'SBI', value: 'SBI' },
    { label: 'IOB', value: 'IOB' },
    { label: 'Kotak', value: 'Kotak' },
    { label: 'HDFC', value: 'HDFC' },
    { label: 'ICICI', value: 'ICICI' },
  ];
}
get bankNames() {
  return [
    { label:this.countryName.label, value:this.countryName.value},
  ];
}
setCountryName = '';
cardNumber = '';
expirationDate = '';
cardCode = '';
status = false;
name = '';
email = '';
paymentMethod = false;
paymentBank = false;
address1 = '';
address2 = '';
city = '';
state = '';
zipCode = '';
paymentCountry = false;
bankName = '';

handleChange(event) {
  this.value = event.detail.value;
  if (this.value) {
    this.paymentMethod = true;
  }
}
handlebank(event) {
  this.value = event.detail.value;
  if (this.value) {
    this.paymentBank = true;
  }
}
handlecountry(event) {
  this.setCountryName = event.detail.value;
  console.log(' this.countryName.label>>>'+ this.countryName.Axis_Bank);
  if (this.setCountryName) {
    this.paymentCountry = true;
    this.onCountrySelect();
  }
}
Cardnumber(event) {
  this.cardNumber = event.target.value;
  console.log('cardNumber', this.cardNumber);
}
Expdate(event) {
  
  let expirationDateFOPrmated = event.target.value;
  let expirationDateForrmated = expirationDateFOPrmated.split('-');
  this.expirationDate = expirationDateForrmated[0]+'-'+expirationDateForrmated[1];
  console.log('expirationDate', this.expirationDate);
  console.log('expirationDateFOPrmated', expirationDateForrmated);

}
CardCode(event) {
  this.cardCode = event.target.value;
  console.log('cardCode', this.cardCode);
}
Name(event) {
  this.name = event.target.value;
}

Email(event) {
  this.email = event.target.value;
}
Address1(event) {
  this.address1 = event.target.value;
}
Address2(event) {
  this.address2 = event.target.value;
}
City(event) {
  this.city = event.target.value;
}
State(event) {
  this.state = event.target.value;
}
ZipCode(event) {
  this.zipCode = event.target.value;
}
check_Zip(){
  var regex = /^\d{5}$/;
  if(regex.test(this.zipCode) == false){
    const transactionSuccess = new ShowToastEvent({
      title: 'Error',
      message: 'Invalid zipcode', mode: 'sticky',
      variant: 'error',
    });
    this.dispatchEvent(transactionSuccess);
  }
  zipCode.focus();
  return false;
  }

onSubmit() {
  
  payment({
    cardNumber: this.cardNumber,
    expirationDate: this.expirationDate,
    cardCode: this.cardCode,
  }).then(result => {

    if (result) {
      this.status = result;
      console.log(this.status);
      this.showToast();
    }
    else{
      const transactionSuccess = new ShowToastEvent({
        title: 'Error',
        message: 'Transaction Failed', mode: 'sticky',
        variant: 'error',
      });
      this.dispatchEvent(transactionSuccess);
    }
  })
    .catch(error => {
      this.result = undefined;
      console.log('this.status line 115', this.result);
    });
}
showToast() {
  const event = new ShowToastEvent({
      title: 'Success',
      message: 'Transaction successfull',
      variant: 'success',
      mode: 'sticky'
  });
  this.dispatchEvent(event);
}

onCountrySelect() {
  
countrycc({
  countryName:this.setCountryName,
}).then(result => {
      this.countryName =  result;
  if (result) {
    this.status = result;
    console.log(this.status);
  }

})
  .catch(error => {
    this.result = undefined;
    console.log('this.status line 115', this.result);
  });
}
}