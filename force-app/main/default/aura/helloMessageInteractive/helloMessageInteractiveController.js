({
	handlerClick : function(component, event, helper) {
		let hndlebtn = event.getSource();
        let btnmsg = hndlebtn.get("v.label");
        let msg = component.set("v.message",btnmsg);
	}
})