({
    
    showObject : function(component, event, helper) {
        try{
            let action = component.get("c.sObjectHasFieldSet");
            action.setCallback(this, function(response) {
                let state = response.getState();
                if (state === "SUCCESS") {           
                    let allValues = response.getReturnValue();
                    if(allValues){
                        component.set("v.options", allValues);
                    }
                    
                }                    
                else {
                    console.log("Unknown Error");
                }
            });
            $A.enqueueAction(action);
        }catch(error){
            console.log(error);
            
        }
    },
    
    
    
    fieldSet : function(component, event, helper) {
        try{
            let empty=[];
            component.set('v.edit',false);
            component.set('v.Option3',empty);
            let ObjectName = component.get("v.selectedValue");
            console.log(ObjectName);
            let action1 = component.get("c.fieldSetSelected");
            if(action1){
                action1.setParams({
                    "objName": ObjectName 
                }); 
                action1.setCallback(this, function(actionResult) {
                    console.log('data>>>>>>>>>>>>>>   ' + JSON.stringify(actionResult.getReturnValue()));
                    component.set('v.options2', actionResult.getReturnValue());
                });
            }
            
            console.log(action1);
            $A.enqueueAction(action1);
        }catch(error){
            console.log(error);
        }
    },
    setField : function(component, event, helper) {
        
        try{
            
                console.log('inside else');
                let ObjectName = component.get("v.selectedValue");
            console.log(ObjectName);
            let fieldsetname = component.get("v.options2v");
            console.log(fieldsetname);
            let action2 = component.get("c.FieldSetName");
            action2.setParams({
                "ObjectName": ObjectName,
                "fieldSetName" : fieldsetname
            }); 
            action2.setCallback(this, function(actionResult) {
                let check = true;
                let check2 = false;              
                
                var state = actionResult.getState();
                if (state === "SUCCESS") {           
                    
                    component.set("v.edit", check);
                }      
                else {
                    component.set("v.edit", check2);
                }
                console.log('option3>>>>',actionResult.getReturnValue());
                component.set('v.Option3', actionResult.getReturnValue());
               if($A.util.isUndefinedOrNull(component.get('v.Option4')) || $A.util.isEmpty(component.get('v.Option4'))){
                   component.set('v.Option4', actionResult.getReturnValue());    
                    console.log('Inside option4');                }
            });
            $A.enqueueAction(action2);
            
            
        }catch(error){
            console.log(error);
            
        }
    },
 
    onsaveHelper : function(c, e, h) {
        try{
            let ObjectName = c.get("v.selectedValue");
            let data = c.get('v.Option3');
            console.log(data);
            if(data){ 
                let finalData = [];
                data.forEach(e => {
                    finalData.push(e);
                });
                    console.log('final data >>>>',finalData);    
                    var jsonFrmt = JSON.stringify(finalData);
                    console.log('>>>>>>',jsonFrmt );
                }
                }catch(error){
                    console.log(error);
                    
                    
                }
                    let fieldData=c.get("v.Option3");
                    console.log(fieldData);
                    //console.log('>'+JSON.stringify(fieldData));
                    console.log('len>>>'+fieldData.length);
                    let jsonData = {};
                    let inputErrorCount = 0;
                    let pattern=/^[a-zA-Z]+ [a-zA-Z]+$/;
                    fieldData.forEach(function(column) 
                    {
                    let columnName = column.fieldName;
                    jsonData[columnName] = column.value;
                    console.log('column.isInputError>>>'+column.isInputError);
                    if(column.isInputError){
                    inputErrorCount++;
                }
                });
                    console.log('inputErrorCount>>>'+inputErrorCount);
                    
                    if(inputErrorCount == 0){
                    for(var i=0;i<fieldData.length;++i){
                    let fieldName=fieldData[i].fieldAPIName;
                    let fieldvalue=fieldData[i].wrapperfld;
                    let fieldrequired=fieldData[i].isDBRequired;
                     console.log('inside required' + fieldvalue.length);
                    if(fieldrequired == true && fieldvalue == ''){
                    // console.log('inside required');
                    document.getElementById("userErr").className = "Error";
                    document.getElementById("cls-btn").className = "cross-btn";
                    c.set('v.Error', 'Requierd field is Missing');
                    c.set('v.crossIcon', 'X');
                    this.toastClose(c, e, h);
                    return;
                } else

                    if((fieldName == 'Phone' || fieldName == 'MobilePhone') && (fieldvalue.length !=10) && fieldvalue != ''){
                    document.getElementById("userErr").className = "Error";
                    document.getElementById("cls-btn").className = "cross-btn";
                    c.set('v.Error', 'Incorrect phone number');
                    c.set('v.crossIcon', 'X');
                    this.toastClose(c, e, h);
                    return;
                
                }
                    
                    
                    else{
                    //converting data in json form
                    jsonData[fieldName]=fieldvalue;
                    
                }
                    
                    //  else{
                    //  jsonData[fieldName]=fieldvalue;
                    //  }
                    
                }
                    
                    let ObjectName = c.get("v.selectedValue");
                    let action = c.get("c.updateData");
                    console.log(JSON.stringify(jsonData));
                    action.setParams({ 
                    "objectData" : JSON.stringify(jsonData),
                    "objname" : ObjectName
                    
                }); 
                action.setCallback(this, function(response) {
                    let state = response.getState();
                    if (state === "SUCCESS") {           
                        document.getElementById("userErr").className = "Success";
                        document.getElementById("cls-btn").className = "cross-btn";
                        c.set('v.Error', 'Record has been inserted successfully');
                        c.set('v.crossIcon', 'X');
                        // h.showToast(c, e, h);
                    }                    
                    else {
                        console.log("Unknown Error");
                    }
                });
                $A.enqueueAction(action);
            }
            
        },
            showToast : function(component, event, helper) {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    mode: 'sticky',
                    type: 'success',
                    "message": "The record has been updated successfully."
                });
                
                toastEvent.fire();
            },
                onCancelHelper : function(component, event, helper) {
                    // location.reload();  
                    var cancel = true;
                    var canceldata = component.get('v.Option3');
                    canceldata.forEach(event => {
                        event.wrapperfld = '';
                                               
                    }); 
                        
                    component.set('v.Option3',canceldata);
                    
                },
                    toastClose: function (c, e, h) {
                        window.setTimeout(
                            $A.getCallback(function () {
                                c.set('v.Error', '');
                                c.set('v.crossIcon', '');
                                document.getElementById("userErr").className = "";
                                document.getElementById("cls-btn").className = "";
                                
                                
                                
                            }), 4000
                        );
                    },
                        forceToastClose: function (c, e, h) {
                            c.set('v.Error', '');
                            c.set('v.crossIcon', '');
                            document.getElementById("userErr").className = "";
                            document.getElementById("cls-btn").className = "";
                            
                        }
        
        
    });