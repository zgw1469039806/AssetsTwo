/*
//  aop({options});
//  By: adamchow2326@yahoo.com.au
//  Version: 1.0
//  Simple aspect oriented programming module
//  support Aspect before, after and around
//  usage:
        aop({
            context: myObject,      // scope context of the target function.
            target: "test",         // target function name
            before: function() {    // before function will be run before the target function
                console.log("aop before");
            },
            after: function() {     // after function will be run after the target function
                console.log("aop after");
            },
            around: function() {    // around function will be run before and after the target function
                console.log("aop around");
            }
        });
*/
var aop = (function() {
    var options = {},
        context = window,
        oFn,
        oFns = [],
        oFnArg,
        oFnArgs = [],
        targets = [],
        targetFn,
        targetFnSelector,
        targetFnSelectors = [],
        beforeFn,
        afterFn,
        aroundFn,
        cloneFn = function(Fn) {
            if (typeof Fn === "function") {
                return eval('[' +Fn.toString()+ ']')[0];
            }
            return null;
        },
        checkContext = function() {
            if (options.context) {
                context = options.context;
            }
            targets = options.target.split(",");
            for (var i=0,l=targets.length;i<l;i++){
	            if (typeof context[(targets[i]).name] === "function") {
	                targetFnSelector = (targets[i]).name;
	                targetFn = context[targetFnSelector];
	            }
	            else if (typeof context[targets[i]] === "function") {
	                targetFnSelector = targets[i];
	                targetFn = context[targetFnSelector];
	            }
	            if (targetFn) {
	                oFn = cloneFn(targetFn);
	                oFns[i] = oFn;
	                oFnArg = new Array(targetFn.length);
	                oFnArgs[i] = oFnArg;
	                targetFnSelectors[i] = targetFnSelector;
	            //    return true;
	            }
	            else {
	                return false;
	            }
            }
            return true;
        },
        run = function() {
        	for (var j=0,k=targetFnSelectors.length;j<k;j++){
        		var nowFnSelector = targetFnSelectors[j];
        		(function(ofn,ocontent){
        			ocontent[nowFnSelector] = function(oFnArgs) {
	                if (aroundFn){
	                    aroundFn.apply(this, arguments);
	                }
	                if (beforeFn){
	                    beforeFn.apply(this, arguments); // 'this' is context
	                }
	                ofn.apply(this, arguments);
	                setTimeout(function () {
		              　　　　　		if (afterFn){
		                    afterFn.apply(this, arguments); // 'this' is context
		                }
		                if (aroundFn){
		                    aroundFn.apply(this, arguments);
		                }
	              　　　　		}, 1000);
	               
	            };
        		})(oFns[j],context);
        	}
        };
    
    return function(opt){
        if (opt && typeof opt === "object" && !opt.length) {
            options = opt;
            if (options.target && checkContext()) {
                if (options.before && typeof options.before === "function") {
                    beforeFn = options.before;
                }
                if (options.after && typeof options.after === "function") {
                    afterFn = options.after;
                }
                if (options.around && typeof options.after === "function") {
                    aroundFn = options.around;
                }
                run();
            }
        }
    };
})();