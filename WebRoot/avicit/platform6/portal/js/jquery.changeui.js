(function($) {
	// 读cookie
	function getcookie(name) {
		var cookie_start = document.cookie.indexOf(name);
		var cookie_end = document.cookie.indexOf(";", cookie_start);
		return cookie_start == -1 ? '' : unescape(document.cookie.substring(cookie_start + name.length + 1, (cookie_end > cookie_start ? cookie_end : document.cookie.length)));
	}

	// 写cookie
	function setcookie(cookieName, cookieValue, seconds, path, domain, secure) {
		var expires = new Date();
		expires.setTime(expires.getTime() + seconds);
		expires = seconds ? expires.toGMTString() : 0;
		document.cookie = escape(cookieName) + '=' + escape(cookieValue) + ('; expires=' + expires) + '; path=' + (path ? path : '/') + (domain ? '; domain=' + domain : '') + (secure ? '; secure' : '');
	}

	$.fn.changeui = function(opt) {
		var option = $.extend({
			linkDom: '',//样式文件所在的link标签,可以是可以是字符串[#id,.class]，也可以是jQuery对象，为空则新加link标签
			url: '',//样式文件资源地址
			childDom:'',
			cookieUiName:'uiname',//记录选择皮肤的cookie名,默认uiname
			backFill:false//是否回填样式,默认不回填，因为回填工作最好后端完成
		}, opt),
			$linkDom = "";

		function getTargetDom(dom){
			var $linkDom = "";
			if (!dom) {
				return console.error("未定义节点，无法执行换肤");
			} else {
				$linkDom = $(dom);
				if (!$linkDom.length) return console.error(dom + "定义不正确,未能找到节点");
			}

			return $linkDom;
		}

		//更换css文件
		function changeCss(uiName){
			var cssDom = getTargetDom(option.linkDom);
			if (uiName.indexOf('.css') < 0) {
				uiName += '.css';
			}
			if(!cssDom) return;
			cssDom.attr('href', option.url + uiName);
			// 保存样式cookie
			setcookie(option.cookieUiName,uiName);

			if(option.childDom){
				$(option.childDom).find('iframe').each(function(){
					var iCssDom = getTargetDom($(this).contents().find(option.linkDom));
					iCssDom.attr('href', option.url + uiName);
				});
			}
		}

		// 回填cookie中的样式
		var cookieUi = getcookie(option.cookieUiName);
		if(cookieUi && option.backFill){
			this.val(cookieUi);
			changeCss(cookieUi);
		}

		// 选择时切换主题
		if(this.is('select') === true){
			this.on('change', function() {
				var uiName = $(this).val();
				changeCss(uiName);
			});
		}else{
			this.on('click',function(){
				var uiName = $(this).data('uisrc');
				if(!uiName) return console.error('uiName参数错误');
				changeCss(uiName);
			});
		}
	};
})(jQuery);