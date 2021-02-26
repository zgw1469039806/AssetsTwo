function guid() {
	return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
		return v.toString(16);
	});
}
(function($) {
	$.fn.ipt = function(foo) {
		var self = this;
		var str = window.navigator.userAgent.toLowerCase();
		if (str.indexOf('msie') !== -1) {
			if (str.indexOf('msie 9.0') !== -1) {
				self.on('change', function() {
					foo && foo.call(this);
					return this;
				});
			} else {
				// propertychange
				// //IE的propertychange总是在初始化时就执行一次，无法解决，IE只允许change吧
				self.on('change', function() {
					foo && foo.call(this);
					return this;
				});
			}
		} else {
			self.on('input', function() {
				foo && foo.call(this);
				return this;
			});
		}
	};
	$.extend({
		arr2Obj : function(arr, fieldArr) {
			var o = {};
			$.each(arr, function(i, n) {
				eval("o." + fieldArr[i] + "='" + n + "';");
			});
			return o;
		},
		notNull : function() {
			for (var i = 0; i < arguments.length; i++) {
				var obj = arguments[i];
				if (typeof obj == "undefined" || obj == null) {
					return false;
				}
				if (typeof obj == "string" && $.trim(obj) == "") {
					return false;
				}
			}
			return true;
		}
	});
})(jQuery);
/*
 * MAP对象，实现MAP功能
 * 
 * 接口： size() 获取MAP元素个数 isEmpty() 判断MAP是否为空 clear() 删除MAP所有元素 put(key, value)
 * 向MAP中增加元素（key, value) remove(key) 删除指定KEY的元素，成功返回True，失败返回False get(key)
 * 获取指定KEY的元素值VALUE，失败返回NULL element(index)
 * 获取指定索引的元素（使用element.key，element.value获取KEY和VALUE），失败返回NULL containsKey(key)
 * 判断MAP中是否含有指定KEY的元素 containsValue(value) 判断MAP中是否含有指定VALUE的元素 values()
 * 获取MAP中所有VALUE的数组（ARRAY） keys() 获取MAP中所有KEY的数组（ARRAY）
 * 
 * 例子： var map = new Map();
 * 
 * map.put("key", "value"); var val = map.get("key") ……
 * 
 */
function Map() {
	this.elements = new Array();

	// 获取MAP元素个数
	this.size = function() {
		return this.elements.length;
	};

	// 判断MAP是否为空
	this.isEmpty = function() {
		return (this.elements.length < 1);
	};

	// 删除MAP所有元素
	this.clear = function() {
		this.elements = new Array();
	};

	// 向MAP中增加元素（key, value)
	this.put = function(_key, _value) {
		this.elements.push({
			key : _key,
			value : _value
		});
	};

	// 删除指定KEY的元素，成功返回True，失败返回False
	this.remove = function(_key) {
		var bln = false;
		try {
			for (var i = 0; i < this.elements.length; i++) {
				if (this.elements[i].key == _key) {
					this.elements.splice(i, 1);
					return true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 获取指定KEY的元素值VALUE，失败返回NULL
	this.get = function(_key) {
		try {
			for (var i = 0; i < this.elements.length; i++) {
				if (this.elements[i].key == _key) {
					return this.elements[i].value;
				}
			}
		} catch (e) {
			return null;
		}
	};

	// 获取指定索引的元素（使用element.key，element.value获取KEY和VALUE），失败返回NULL
	this.element = function(_index) {
		if (_index < 0 || _index >= this.elements.length) {
			return null;
		}
		return this.elements[_index];
	};

	// 判断MAP中是否含有指定KEY的元素
	this.containsKey = function(_key) {
		var bln = false;
		try {
			for (var i = 0; i < this.elements.length; i++) {
				if (this.elements[i].key == _key) {
					bln = true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 判断MAP中是否含有指定VALUE的元素
	this.containsValue = function(_value) {
		var bln = false;
		try {
			for (var i = 0; i < this.elements.length; i++) {
				if (this.elements[i].value == _value) {
					bln = true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 获取MAP中所有VALUE的数组（ARRAY）
	this.values = function() {
		var arr = new Array();
		for (var i = 0; i < this.elements.length; i++) {
			arr.push(this.elements[i].value);
		}
		return arr;
	};

	// 获取MAP中所有KEY的数组（ARRAY）
	this.keys = function() {
		var arr = new Array();
		for (var i = 0; i < this.elements.length; i++) {
			arr.push(this.elements[i].key);
		}
		return arr;
	};
};
function LinkedList(){
	this.add = function(head, next){
		if(this.map.containsKey(head)){
			this.map.get(head).addNext(next);
		}else{
			var node = new LinkedNode(head);
			node.addHead("head");
			node.addNext(next);
			this.map.put(head, node);
			this.head.addNext(head);
		}
		
		if(this.map.containsKey(next)){
			var oldHead = this.map.get(next).getHead();
			if(oldHead.contains("head")){
				this.map.get(next).removeHead("head");
				this.head.removeNext(next);
			}
			this.map.get(next).addHead(head);
		}else{
			var node = new LinkedNode(next);
			node.addHead(head);
			this.map.put(next, node);
		}
	};
	this.map = new Map();
	this.head = new LinkedNode("head");
	this.constructor = function(){
		this.map.put("head", this.head);
	};
	this.clear = function(){
		this.map.clear();
		this.head.head.clear();
		this.head.next.clear();
		this.map.put("head", this.head);
	};
};
function LinkedNode(){
	this.head = new Array();
	this.next = new Array();
	this.id = null;
	this.constructor = function(id){
		this.id = id;
	};
	this.addHead = function(value){
		this.head.push(value);
	};
	this.addNext = function(value){
		this.next.push(value);
	};
	this.getHead = function(){
		return this.head;
	};
	this.getNext = function(){
		return this.next;
	};
	this.removeHead = function(value){
		this.head.remove(value);
	};
	this.removeNext = function(value){
		this.next.remove(value);
	};
};
var easyHelp = {
	IS_IE: navigator.userAgent.indexOf('MSIE') >= 0,
	IS_IE8: navigator.userAgent.indexOf('MSIE 8') >= 0,
	showResultMsg : function(r, successMsg, successBack) {
		if ($.notNull(r.error)) {
			this.showMsg(r.error);
		} else {
			if($.notNull(successMsg)){
				this.showMsg(successMsg);
			}
			if(typeof(successBack) == "function"){
				successBack();
			}
		}
	},
	showMsg : function(msg) {
		$.messager.show({
			title : '提示',
			msg : msg
		});
	}
};

$.extend($.fn.tabs.methods, {
	getTabById : function(jq, id) {
		var tabs = $.data(jq[0], 'tabs').tabs;
		for (var i = 0; i < tabs.length; i++) {
			var tab = tabs[i];
			if (tab.panel('options').id == id) {
				return tab;
			}
		}
		return null;
	},
	selectById : function(jq, id) {
		return jq
				.each(function() {
					var state = $.data(this, 'tabs');
					var opts = state.options;
					var tabs = state.tabs;
					var selectHis = state.selectHis;
					if (tabs.length == 0) {
						return;
					}
					var panel = $(this).tabs('getTabById', id); // get the panel
																// to be
																// activated
					if (!panel) {
						return
					}
					var selected = $(this).tabs('getSelected');
					if (selected) {
						if (panel[0] == selected[0]) {
							return
						}
						$(this).tabs('unselect',
								$(this).tabs('getTabIndex', selected));
						if (!selected.panel('options').closed) {
							return
						}
					}
					panel.panel('open');
					var title = panel.panel('options').title; // the panel
																// title
					selectHis.push(title); // push select history
					var tab = panel.panel('options').tab; // get the tab
															// object
					tab.addClass('tabs-selected');
					// scroll the tab to center position if required.
					var wrap = $(this).find('>div.tabs-header>div.tabs-wrap');
					var left = tab.position().left;
					var right = left + tab.outerWidth();
					if (left < 0 || right > wrap.width()) {
						var deltaX = left - (wrap.width() - tab.width()) / 2;
						$(this).tabs('scrollBy', deltaX);
					} else {
						$(this).tabs('scrollBy', 0);
					}
					$(this).tabs('resize');
					opts.onSelect.call(this, title, $(this).tabs('getTabIndex',
							panel));
				});
	},
	existsById : function(jq, id) {
		return $(jq[0]).tabs('getTabById', id) != null;
	}
});
/**
 * 返回此数组中是否包含指定的项。 此方法采用了 Microsoft Ajax Library 中的实现。
 * 
 * @param p_item
 *            指定项
 * @return
 */
Array.prototype.contains = function(p_item) {
	return this.indexOf(p_item) != -1
}
/**
 * 将指定的项从此数组中移除，并返回被移除的项。 此方法采用了 Microsoft Ajax Library 中的实现。
 * 
 * @param p_item
 *            指定项
 * @return
 */
Array.prototype.remove = function(p_item) {
	return this.removeAt(this.indexOf(p_item));
}
/**
 * 将指定位置上的项从此数组中移除，并返回被移除的项 此方法采用了 Microsoft Ajax Library 中的实现。
 * 
 * @param p_index
 *            指定项的位置，从 0 开始计数。
 * @return
 */
Array.prototype.removeAt = function(p_index) {
	if (p_index >= 0 && p_index < this.length) {
		this.splice(p_index, 1);
	} else {
		return false;
	}
}
/**
 * 清楚数组中所有的项。此方法采用了 Microsoft Ajax Library 中的实现。
 */
Array.prototype.clear = function() {
	if (this.length > 0) {
		this.splice(0, this.length);
	}
}
/**
 * 返回此数组中第一次出现指定项的位置，从 0 开始计数 此方法采用了 Microsoft Ajax Library 中的实现。
 * 
 * @param p_item
 *            指定项
 * @return
 */
Array.prototype.indexOf = function(p_item) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] == p_item) {
			return i;
		}
	}
	return -1;
}
/**
 * 区别于replace方法，全部替换匹配的子串（replace是正则替换）
 */
String.prototype.replaceAll = function(AFindText, ARepText) {
	var raRegExp = new RegExp(AFindText.replace(
			/([\(\)\[\]\{\}\^\$\+\-\*\?\.\"\'\|\/\\])/g, "\\$1"), "ig");
	return this.replace(raRegExp, ARepText);
}
String.prototype.isEn = function() {
	if($.notNull(this)){
		var reg = /^\w+$/gi;
		return reg.test(this);
	}
	return true;
}