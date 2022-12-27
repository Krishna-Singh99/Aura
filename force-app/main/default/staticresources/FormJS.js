<script>
        var updateFieldName;
        var newFieldPicklistOptions = [];
        function initModal() {
            $('#myModal').on('hidden.bs.modal', function () {
                $('.objectType').val('');
                $('.objectTypeView').text('');
                $('.inputFieldNameView').text('');
                $('.fieldType').val('');
                $('.fieldType').find('option').remove();
                $('.fieldLabel').val('');
                $('.fieldOptions').val('');
                $('.fieldOptions').find('option').remove();
                $('.requiredCheckbox').prop('checked', false);
                $('.privateCheckbox').prop('checked', false);
                $('.objectType').removeClass('requiredEmpty');
                $('.fieldType').removeClass('requiredEmpty');
                $('.fieldLabel').removeClass('requiredEmpty');
                $('.inputObjectContainer').show();
                $('.inputObjectViewContainer').hide();
                $('.inputFieldNameViewContainer').hide();
                $('.fieldTypeContainer').show();
            });
        }

        function sortablePanels() {
            $(".fieldColumns").sortable({
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

        function setColumnNumber(column, item) {
            if ($(column).attr('class').indexOf('leftFieldColumn') > -1) {
                $(item).find('.fieldColumn').val(1);
            }
            if ($(column).attr('class').indexOf('centerFieldColumn') > -1) {
                $(item).find('.fieldColumn').val(2);
            }
            if ($(column).attr('class').indexOf('rightFieldColumn') > -1) {
                $(item).find('.fieldColumn').val(3);
            }
        }

        function sortColumnOrders() {
            var sections = $('.sectionRegion');
            for (var i = 0; i < sections.length; i++){
                $(sections[i]).find('.sectionPosition').val(i + 1);
                var leftColumnFields = $(sections[i]).find('.fieldsTable').find('.leftFieldColumn').find('.fieldContainer');
                var centerColumnFields = $(sections[i]).find('.fieldsTable').find('.centerFieldColumn').find('.fieldContainer');
                var rightColumnFields = $(sections[i]).find('.fieldsTable').find('.rightFieldColumn').find('.fieldContainer');
                sortColumn(leftColumnFields, i, 1);
                sortColumn(centerColumnFields, i, 2);
                sortColumn(rightColumnFields, i, 3);
            }
        }

        function sortColumn(fields, sectionPosition, fieldColumn) {
            for (var i = 0; i < fields.length; i++){
                $(fields[i]).find('.fieldColumn').val(fieldColumn);
                $(fields[i]).find('.fieldColumnOrder').val(i + 1);
                $(fields[i]).find('.formSectionPosition').val(sectionPosition + 1);
            }
        }

        function editQuestion() {
            var fieldLabel = $('.fieldLabel').val();
            var isRequiredEmpty = false;

            if (fieldLabel == null || fieldLabel.length <= 0) {
                isRequiredEmpty = true;
                $('.fieldLabel').addClass('requiredEmpty');
            } else if (fieldLabel.length <= 0) {
                isRequiredEmpty = true;
                $('.fieldLabel').addClass('requiredEmpty');
            } else {
                $('.fieldLabel').removeClass('requiredEmpty');
            }

            if (! isRequiredEmpty) {
                updateQuestion(updateFieldName);
            } 
        }

        function addNewQuestion() {
            var isRequiredEmpty = checkRequiredFields();
            if (! isRequiredEmpty) {
                addQuestion();
            } 
        }

        function hideModal() {
            $('#myModal').modal('hide');
            $('.modal-backdrop').hide();
        }

        function openNewModal(formSectionPosition, fieldColumn) {
            $('.objectType').val('');
            $('.newSFField').hide();
            $('.newFormSectionPosition').val(formSectionPosition);
            $('.newFieldColumn').val(fieldColumn);
            $('.editBtn').hide();
            $('.addNewBtn').show();
            $('#myModal').modal('show');
            $('.modal-backdrop').show();
            $('.inputObjectViewContainer').hide();
            $('.inputFieldNameViewContainer').hide();
            $('.myModal-title').text('ADD NEW FIELD');
            updatePicklistOptions();
        }

        function openEditModal(fieldObject, fieldType, fieldLabel, fieldColumn, fieldColumnOrder, formSectionPosition, fieldRequired, fieldPrivate, picklistOptions, newFieldPicklistOptions) {
            $('#myModal').modal('show');
            $('.modal-backdrop').show();
            $('.editBtn').show();
            $('.addNewBtn').hide();
            $('.myModal-title').text('EDIT FIELD');
            $('.newSFField').hide();
            $('.inputObjectContainer').hide();
            $('.inputObjectViewContainer').show();
            $('.inputFieldNameViewContainer').show();
            $('.fieldTypeContainer').hide();            

            updateFieldName = fieldType;
            $('.objectType').val(fieldObject);
            $('.fieldType').val(fieldType);
            $('.fieldLabel').val(fieldLabel);
            $('.objectTypeView').text('');
            $('.inputFieldNameView').text('');

            $('.newFormSectionPosition').val(formSectionPosition);
            $('.newFieldColumn').val(fieldColumn);
            $('.newFieldColumnOrder').val(fieldColumnOrder);
            $('.requiredCheckbox').prop('checked', fieldRequired);
            $('.privateCheckbox').prop('checked', fieldPrivate);

            editQstn(fieldType);
        }

        function changeSFFieldLink(objectNameField) {
            var objectName = $(objectNameField).val();
            if (objectName == 'Lead') {
                $('.newSFField').attr('href', '/one/one.app?source=aloha#/setup/object/Lead/FieldsAndRelationships/page?address=%2Fp%2Fsetup%2Ffield%2FNewCustomFieldStageManager%3Fentity%3DLead');
            } else if (objectName == 'Registration_Form__c') {
                $('.newSFField').attr('href', '/one/one.app?source=aloha#/setup/object/01I7A0000009IdY/FieldsAndRelationships/page?address=%2Fp%2Fsetup%2Ffield%2FNewCustomFieldStageManager%3Fentity%3D01I7A0000009IdY%26retURL%3D%252Fsetup%252Fobject%252F01I7A0000009IdY%252Fall%252FFieldsAndRelationships&a:t=1507905565478');
            } else if (objectName == 'Profile_Form__c') {
                $('.newSFField').attr('href', '/one/one.app?source=aloha#/setup/object/01I7A0000009K7e/FieldsAndRelationships/page?address=%2Fp%2Fsetup%2Ffield%2FNewCustomFieldStageManager%3Fentity%3D01I7A0000009K7e%26retURL%3D%252Fsetup%252FObjectManager%252F01I7A0000009K7e%252FFieldsAndRelationships%252Fview');
            } else if (objectName == 'Contact') {
                $('.newSFField').attr('href', '/one/one.app?source=aloha#/setup/object/Contact/FieldsAndRelationships/page?address=%2Fp%2Fsetup%2Ffield%2FNewCustomFieldStageManager%3Fentity%3DContact');
            } else if (objectName == 'Account') {
                $('.newSFField').attr('href', '/one/one.app?source=aloha#/setup/object/Account/FieldsAndRelationships/page?address=%2Fp%2Fsetup%2Ffield%2FNewCustomFieldStageManager%3Fentity%3DAccount');
            }
            
            $('.newSFField').show();
        }

        function checkRequiredFields() {
            var isRequiredEmpty = false;
            var objectType = $('.objectType').val();
            var fieldType = $('.fieldType').val();
            var fieldLabel = $('.fieldLabel').val();

            if (objectType == null) {
                isRequiredEmpty = true;
                $('.objectType').addClass('requiredEmpty');
            } else if (objectType.length <= 0) {
                isRequiredEmpty = true;
                $('.objectType').addClass('requiredEmpty');
            } else {
                $('.objectType').removeClass('requiredEmpty');
            }

            if (fieldType == null || fieldType.length <= 0) {
                isRequiredEmpty = true;
                $('.fieldType').addClass('requiredEmpty');
            } else if (fieldType.length <= 0) {
                isRequiredEmpty = true;
                $('.fieldType').addClass('requiredEmpty');
            } else {
                $('.fieldType').removeClass('requiredEmpty');
            }

            if (fieldLabel == null || fieldLabel.length <= 0) {
                isRequiredEmpty = true;
                $('.fieldLabel').addClass('requiredEmpty');
            } else if (fieldLabel.length <= 0) {
                isRequiredEmpty = true;
                $('.fieldLabel').addClass('requiredEmpty');
            } else {
                $('.fieldLabel').removeClass('requiredEmpty');
            }

            return isRequiredEmpty;
        }

        function updateNewFieldLabel() {
            $('.fieldLabel').val($('.fieldType option:selected').text());
        }

        function updatePicklistOptions() {
            var newFieldPicklistOptionsSize = $('.fieldOptions').find('option').size();
            if (newFieldPicklistOptionsSize > 0) {
                $('.newFieldPicklistOptionsContainer').show();
                var values=[];
                $('.fieldOptions option').each(function() {
                    values.push($(this).val());
                });
                $.each(values, function(i,e){
                    $(".fieldOptions option[value='" + e + "']").prop("selected", true);
                });
            } else {
                $('.newFieldPicklistOptionsContainer').hide();
            }
        }

        function updateEditPicklistOptions() {
            var newFieldPicklistOptionsSize = $('.fieldOptions').find('option').size();
            if (newFieldPicklistOptionsSize > 0) {
                $('.newFieldPicklistOptionsContainer').show();
            } else {
                $('.newFieldPicklistOptionsContainer').hide();
            }
        }

        function showCloneTemplateModal() {
            $('#cloneTemplateModal').modal('show');
            $('.modal-backdrop').show();
        }
        function hideCloneTemplateModal() {
            $('#cloneTemplateModal').modal('hide');
            $('.modal-backdrop').hide();
        }

        
    </script>