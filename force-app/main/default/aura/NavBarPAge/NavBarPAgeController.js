({
    doInit : function(component, event, helper) {
    var name = [];
        name.push('Suman');
        name.push('Sekhar');
        component.set('v.acclist',name);
},
	show : function(component, event, helper) {
    var cmpTarget = component.find('divId');
    $A.util.addClass(cmpTarget, 'divShow');
}
})