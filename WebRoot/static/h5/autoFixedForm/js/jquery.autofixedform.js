(function($) {
	(function (window) {
	    var last = +new Date();
	    var delay = 100; // 监听延迟

	    // 监听队列
	    var stack = [];

	    function callback() {
	        var now = +new Date();
	        if (now - last > delay) {
	            for (var i = 0; i < stack.length; i++) {
	                stack[i]();
	            }
	            last = now;
	        }
	    }

	    // 注册到全局的公用方法
	    var onDomChange = function (fn, newdelay) {
	        if (newdelay) delay = newdelay;
	        stack.push(fn);
	    };

	    // 无奈的兼容性方案
	    function naive() {

	        var last = document.getElementsByTagName('*');
	        var lastlen = last.length;
	        var timer = setTimeout(function check() {

	            // 获取document当前状态
	            var current = document.getElementsByTagName('*');
	            var len = current.length;

	            // 如果长度明显不同
	            if (len != lastlen) {
	                // 确保循环提前完成
	                last = [];
	            }

	            // 检查元素是否就绪
	            for (var i = 0; i < len; i++) {
	                if (current[i] !== last[i]) {
	                    callback();
	                    last = current;
	                    lastlen = len;
	                    break;
	                }
	            }

	            // 轮询- -
	            setTimeout(check, delay);

	        }, delay);
	    }

	    //
	    //  检查对变动事件的支持
	    //

	    var support = {};

	    var el = document.documentElement;
	    var remain = 3;

	    // 测试的回调
	    function decide() {
	        if (support.DOMNodeInserted) {
	            window.addEventListener("DOMContentLoaded", function () {
	                if (support.DOMSubtreeModified) { // for FF 3+, Chrome
	                    el.addEventListener('DOMSubtreeModified', callback, false);
	                } else { // for FF 2, Safari, Opera 9.6+
	                    el.addEventListener('DOMNodeInserted', callback, false);
	                    el.addEventListener('DOMNodeRemoved', callback, false);
	                }
	            }, false);
	        } else if (document.onpropertychange) { // for IE 5.5+
	            document.onpropertychange = callback;
	        } else { // 退回
	            naive();
	        }
	    }

	    // 检查特定事件
	    function test(event) {
	        el.addEventListener(event, function fn() {
	            support[event] = true;
	            el.removeEventListener(event, fn, false);
	            if (--remain === 0) decide();
	        }, false);
	    }

	    // 附加测试
	    if (window.addEventListener) {
	        test('DOMSubtreeModified');
	        test('DOMNodeInserted');
	        test('DOMNodeRemoved');
	    } else {
	        decide();
	    }

	    // 虚拟测试
	    var dummy = document.createElement("div");
	    el.appendChild(dummy);
	    el.removeChild(dummy);

	    // 对外暴露API
	    window.onDomChange = onDomChange;
	})(window);

	$.fn.autofixedform = function(opt) {
		var option = $.extend({
			name:'.fixed-form',//[jQuery选择器语法]需要格式化的表单的class，默认.fixed-form
			minWidth:200,//表格最小宽度，默认200
		}, opt),$this=this;

		//初始化方法
		function init(){
			var fwidth = $this.width();
			// 重新计算元素权重
			function formatFw(arr){
				var resultArr = [];
				function main(arr){
					function diffset(arr,round){
						for(var j = 0;j<round;j++){
							if(j+1 <= arr.length){
								if(arr[j+1]){
									arr[j+1] = arr[0];
								}else{
									continue;
								}
							}
						}
						var cutarr = arr.splice(0,arr[0]);
						for(var v in cutarr){
							resultArr.push(cutarr[v]);
						}
						return arr;
					}
					for(var i = 0;i<arr.length;i++){
						if((arr[i]-1)%arr[i]){
							return main(diffset(arr,(arr[i]-1)%arr[i]));
						}else{
							resultArr.push(arr.shift());
							return main(arr);
						}
					}
					return resultArr;
				}
				return main(arr);
			}
			var fwArr = [];//获取dom里预设的权重
			$this.find(option.name).each(function(i,v){
				var fw = $(this).data('fw');
				fwArr.push(fw);
			});
			var editArr = formatFw(fwArr);//获取格式化后的权重
			$this.find(option.name).each(function(i,v){
				$(this).data('fw',editArr[i]);
				var setWidth = fwidth*(1/editArr[i])-4;
				if(setWidth <= option.minWidth) setWidth = option.minWidth;
				$(this).css('width',setWidth);
			});
		}

		init();//初始化

		onDomChange(function(){
			init();//有元素被删除时再次初始化
		});

		// 页面缩放时重新初始化
		function formatDom(win,doc){
			window.onresize = init;
		}

		formatDom(window,document);
	};
})(jQuery);