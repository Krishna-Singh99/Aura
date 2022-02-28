import { LightningElement } from 'lwc';
import My_Resource from '@salesforce/resourceUrl/img';
import { NavigationMixin } from 'lightning/navigation';
export default class LightForEye extends LightningElement {
logo = My_Resource + '/img/eye2.jpg';
nextgen = My_Resource + '/img/nextgen.jpg';
glass2 = My_Resource + '/img/glass2.jpg';
glass1 = My_Resource + '/img/glass1.jpg';
glass3 = My_Resource + '/img/glass3.jpg';
glass4 = My_Resource + '/img/glass4.jpg';
glass6 = My_Resource + '/img/glass6.jpg';
glass5 = My_Resource + '/img/glass5.jpg';
glass7 = My_Resource + '/img/glass7.jpg';
glass8 = My_Resource + '/img/glasses.jpg';
premium1 = My_Resource + '/img/premium1.jpg';
premium2 = My_Resource + '/img/premium2.jpg';
premium3 = My_Resource + '/img/premium3.jpg';
premium4 = My_Resource + '/img/premium4.jpg';
stylish1 = My_Resource + '/img/stylish1.png';
stylish2 = My_Resource + '/img/stylish2.jpg';
stylish3 = My_Resource + '/img/stylish3.jpg';
stylish4 = My_Resource + '/img/glass7.jpg';

isEyeglasses = true;
isSunglasses = false;
isPremium = false;
isDiscover = false;
eye = false;

Eyeglasses(){
   this.isEyeglasses = true;
   this.isDiscover = false;
   this.isSunglasses = false;
   this.isPremium = false;
   console.log('Eyeglasses');
   }

   Sunglasses(){
   this.isDiscover = false;
   this.isEyeglasses = false;
   this.isPremium = false;
   this.isSunglasses = true;
   console.log('Sunglasses');
   }

   Premium(){
      this.isPremium = true;
      this.isDiscover = false;
         this.isEyeglasses = false;
         this.isSunglasses = false;
      console.log('Premium');
      }

      Discover(){
         this.isDiscover = true;
         this.isEyeglasses = false;
         this.isSunglasses = false;
         this.isPremium = false;
         console.log('Discover');
         }

mouseout(){
   this.isEyeglasses = false;
   this.isDiscover = false;
   this.isPremium = false;
   this.isSunglasses = false;
   console.log('mouseout');
   }
   EyeglassesPage (){
     this.eye = true;
     this.isEyeglasses = false;
   this.isDiscover = false;
   this.isPremium = false;
   this.isSunglasses = false;
   }
   
handleNavigation() {
   console.log('hello');
   this[NavigationMixin.Navigate]({
    type: 'standard__component',
    attributes: {
        componentName: 'c__SignIn'
    },
    state: {
      c__orderId: "test"
  }
});
}

}