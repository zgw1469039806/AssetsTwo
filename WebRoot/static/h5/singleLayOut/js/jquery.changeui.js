function doChangeSkin(g, f) {
    var c = "static/css/platform/themes/";
    switchHref(g, c, f);
    c = "static/css/custom/themes/";
    switchHref(g, c, f);
    var c = "static/js/platform/component/jQuery/jquery-easyui-1.3.5/themes/";
    switchHref(g, c, f);
    var h = f.document.getElementsByTagName("iframe");
    for (var b = 0; b < h.length; b++) {
        var a = h[b].contentWindow;
        if (a) {
            try { doChangeSkin(g, a) } catch (d) {}
        }
    }
}

function switchHref(j, b, f) {
    var h = f.$('link[rel="stylesheet"]');
    for (var c = 0; c < h.length; c++) {
        var a = $(h[c]).attr("href");
        if (a && a.indexOf(b) != -1) {
            var e = a.indexOf(b) + b.length;
            var d = a.indexOf("/", e);
            if (d != -1) {
                var g = a.substring(0, e) + j + a.substring(d);
                $(h[c]).attr("href", g)
            }
        }
    }
}

(function($) {
	function getcookie(name) {
		var cookie_start = document.cookie.indexOf(name);
		var cookie_end = document.cookie.indexOf(";", cookie_start);
		return cookie_start == -1 ? '' : unescape(document.cookie.substring(cookie_start + name.length + 1, (cookie_end > cookie_start ? cookie_end : document.cookie.length)));
	}

	function setcookie(cookieName, cookieValue, seconds, path, domain, secure) {
		var expires = new Date();
		expires.setTime(expires.getTime() + seconds);
		expires = seconds ? expires.toGMTString() : 0;
		document.cookie = escape(cookieName) + '=' + escape(cookieValue) + ('; expires=' + expires) + '; path=' + (path ? path : '/') + (domain ? '; domain=' + domain : '') + (secure ? '; secure' : '');
	}

	$.fn.changeui = function(opt) {
		var option = $.extend({
			linkDom: '',
			url: '',
			cookieUiName:'uiname'
		}, opt),
			$linkDom = "";

		// 获取样式链接节点
		if (!option.linkDom) {
			$linkDom = $('<link rel="stylesheet" href="" type="text/css"/>');
			$("body").append($linkDom);
		} else {
			if (option.linkDom instanceof jQuery) {
				$linkDom = optoin.linkDom;
			} else if (typeof(option.linkDom) == "string") {
				$linkDom = $(option.linkDom);
			}
			if (!$linkDom.length) return console.error(option.linkDom + "定义不正确,未能找到节点");
		}

		//更换css文件
		function changeCss(uiName){
			if (uiName.indexOf('.css') < 0) {
				uiName += '.css';
			}
			$linkDom.attr('href', option.url + uiName);
		}

		// 回填cookie中的样式
		var cookieUi = getcookie(option.cookieUiName);
		if(cookieUi){
			this.val(cookieUi);
			changeCss(cookieUi);
		}

		// 选择时切换主题
		this.on('change', function() {
			var uiName = $(this).val();
			changeCss(uiName);
			// 保存样式cookie
			setcookie(option.cookieUiName,uiName);
		});

	};
})(jQuery);