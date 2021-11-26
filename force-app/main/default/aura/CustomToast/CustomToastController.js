({
    customToastFired: function (c, e) 
        {
            // console.log('Custom_ToastFired');
            var toastInput = e.getParam('toastInput');
            var message = e.getParam('message');
            var timeOut=3000;
            // console.log('toastInput>>>',toastInput);
            // console.log('message>>>',message);
            if(toastInput && message) 
            {
                c.set('v.toastInput',toastInput);
                c.set('v.message',message);
                window.setTimeout(
                $A.getCallback(function() 
                {
                    c.set('v.toastInput',null);
                    c.set('v.message',null);
                }), timeOut
                );
            }
            e.stopPropagation();
        },
})