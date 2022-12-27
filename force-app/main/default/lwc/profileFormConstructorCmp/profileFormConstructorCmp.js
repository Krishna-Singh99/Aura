import { LightningElement } from 'lwc';
//import spinner from '@salesforce/resourceUrl/Spinner';
//import campaignnames from '@salesforce/resourceUrl/Cient_Facing_Images';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import jQuery from '@salesforce/resourceUrl/FormJS';

//import profilefornData from '@salesforce/apex/ProfileFormConstructorCtrl.ininitializeSelectedFieldsMap';
export default class ProfileFormConstructorCmp extends LightningElement {
// spinner = spinner + '/spinner.gif';
// campaignname = campaignnames + '/apply-header.jpg';
fieldLabel;
//    editQuestion() {
//    // var fieldLabelcopy = $('.fieldLabel').val();
//     this.fieldLabel = this.querySelector('fieldLabel');
//     var isRequiredEmpty = false;

//     if (fieldLabel == null || fieldLabel.length <= 0) {
//         isRequiredEmpty = true;
//         $('.fieldLabel').addClass('requiredEmpty');
//     } else if (fieldLabel.length <= 0) {
//         isRequiredEmpty = true;
//         $('.fieldLabel').addClass('requiredEmpty');
//     } else {
//         $('.fieldLabel').removeClass('requiredEmpty');
//     }

//     if (! isRequiredEmpty) {
//         updateQuestion(updateFieldName);
//     } 
// }

renderedCallback(){
loadScript(this, jQuery)
.then(() => {
    console.log('JQuery loaded.');
})
.catch(error=>{
    console.log('Failed to load the JQuery : ' +error);
});
}

slideIt(event){
$(this.template.querySelector('.fieldLabel')).slideToggle("slow");
}

slideRight(event){
$(this.template.querySelector('.innerDiv')).animate({left: '275px'});
}
 updateFieldName;
 newFieldPicklistOptions = [];
    initModal() {
$('#myModal').on('hidden.bs.modal', function () {
    $(this.template.querySelector('.objectType')).val('');
    $(this.template.querySelector('.objectTypeView')).text('');
    $(this.template.querySelector('.inputFieldNameView')).text('');
    $(this.template.querySelector('.fieldType')).val('');
    $(this.template.querySelector('.fieldType')).find('option').remove();
    $(this.template.querySelector('.fieldLabel')).val('');
    $(this.template.querySelector('.fieldOptions')).val('');
    $(this.template.querySelector('.fieldOptions')).find('option').remove();
    $(this.template.querySelector('.requiredCheckbox')).prop('checked', false);
    $(this.template.querySelector('.privateCheckbox')).prop('checked', false);
    $(this.template.querySelector('.objectType')).removeClass('requiredEmpty');
    $(this.template.querySelector('.fieldType')).removeClass('requiredEmpty');
    $(this.template.querySelector('.fieldLabel')).removeClass('requiredEmpty');
    $(this.template.querySelector('.inputObjectContainer')).show();
    $(this.template.querySelector('.inputObjectViewContainer')).hide();
    $(this.template.querySelector('.inputFieldNameViewContainer')).hide();
    $(this.template.querySelector('.fieldTypeContainer')).show();
});
}


sortablePanels() {
    $(this.template.querySelector((".fieldColumns"))).sortable({
        connectWith: ".fieldColumns",
        cursor: "move",
        items: 'div[id!=nosort]',
        receive : function(e,ui) {
            // updateFieldElement(this, ui.item);
        },
        stop : function(e,ui) {
            sortColumnOrders();
        },
        beforeStop : function(ev, ui) {
            if (($(ui.placeholder).parent().attr('class').indexOf('registrationField') > -1 && $(ui.item).find('.fieldObject').val() == 'Lead') || ($(ui.placeholder).parent().attr('class').indexOf('leadField') > -1 && $(ui.item).find('.fieldObject').val() == 'Registration_Form__c')) {
                $(this).sortable('cancel');
            }
        }
    }).disableSelection();

    $(".sectionsContainer").sortable({
        connectWith: ".sectionsContainer",
        cursor: "move",
        stop : function(e,ui) {
            sortColumnOrders();
        }
    }).disableSelection();
}
}