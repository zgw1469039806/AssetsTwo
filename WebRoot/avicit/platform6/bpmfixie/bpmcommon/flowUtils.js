//判断是IE，重写window.open方法
var _IS_IE = navigator.userAgent.indexOf('MSIE') >= 0;
if(_IS_IE){
	window.open = function(url, name){
		var a = document.createElement("a");
		a.href = url;
		a.target = name;
		document.body.appendChild(a);
		a.click();
		document.body.removeChild(a);
	};
}
/**
 * 流程通用工具类
 */
var flowUtils = {
	graphPath : "avicit/platform6/bpmfixie/bpmbusiness/include/flowGraph.jsp",
	/**
	 * 根路径
	 */
	baseurl : null,
	/**
	 * 判断非空
	 * 
	 * @returns {Boolean}
	 */
	notNull : function() {
		for (var i = 0; i < arguments.length; i++) {
			var obj = arguments[i];
			if (typeof obj == "undefined" || obj == null || (typeof obj == "string" && obj == "undefined")) {
				return false;
			}
			if (typeof obj == "string" && $.trim(obj) == "") {
				return false;
			}
		}
		return true;
	},
	/**
	 * 引入JS文件
	 * 
	 * @param src
	 */
	include : function(src) {
		document.write('<script src="' + src + '"></script>');
	},
	/**
	 * 错误提示
	 * 
	 * @param message
	 */
	error : function(message, callback) {
		layer.alert(message, {icon: 7 ,title: "提示",closeBtn: 0,area: ['400px', '']}, callback);
	},
	/**
	 * 警告提示
	 * 
	 * @param message
	 */
	warning : function(message) {
		layer.msg(message, {
			icon : 7
		});
	},
	/**
	 * 成功提示
	 * 
	 * @param message
	 */
	success : function(message, func, shade) {
		var time = 3000;
		if (typeof (shade) != 'undefined') {
			shade = 0.3;
			time = 1500;
		}
		layer.msg(message, {
			icon : 1,
			shade : shade,
			time : time
		}, func);
	},
	/**
	 * 询问对话框
	 * 
	 * @param message
	 * @param callback
	 */
	confirm : function(message, callback) {
		layer.confirm(message, {
			icon : 3,
			title : '提示',
			area: ['400px', ''],
			closeBtn : 0
		}, function(index) {
			callback();
			layer.close(index);
		});
	},
	/**
	 * xmlDocument
	 */
	doc : null,
	/**
	 * 创建空的xmlDocument
	 * 
	 * @returns
	 */
	createXmlDocument : function() {
		var doc = null;
		if (document.implementation && document.implementation.createDocument) {
			doc = document.implementation.createDocument('', '', null);
		} else if (window.ActiveXObject) {
			doc = new ActiveXObject('Microsoft.XMLDOM');
		}
		return doc;
	},
	/**
	 * 构建xml元素
	 * 
	 * @param value
	 * @returns
	 */
	createElement : function(value) {
		if (this.doc == null) {
			this.doc = this.createXmlDocument();
		}
		return this.doc.createElement(value);
	},
	/**
	 * 构建xmltext元素
	 * 
	 * @param value
	 * @returns
	 */
	createTextNode : function(value) {
		if (this.doc == null) {
			this.doc = this.createXmlDocument();
		}
		return this.doc.createTextNode($.trim(value));
	},
	/**
	 * 构建guid add by hangchao.you 20170516
	 * 
	 * @returns
	 */
	guid : function() {
		return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
			var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
			return v.toString(16);
		});
	},
	/**
	 * 打开窗口，以下三个方法是关联的，可能有兼容性问题，有待测试和解决
	 * 
	 * @param url
	 * @param name
	 * @param callback
	 */
	open : function(url, name, callback) {
		if (!flowUtils.notNull(name)) {
			name = "";
		}
		if (flowUtils.notNull(url)) {
			url = flowUtils.baseurl + url;
			name = name.replace(/[^_0-9a-zA-Z\u4e00-\u9fa5]/g,'');
			window.open(url, name);
			if (flowUtils.notNull(callback)) {
				callback();
			}
		}
	},
	openOnDialog : function(url, name, callback) {
		/*if (!flowUtils.notNull(name)) {
			name = "";
		}
		if (flowUtils.notNull(url)) {
			url = flowUtils.baseurl + url;
			name = name.replace(/[^_0-9a-zA-Z\u4e00-\u9fa5]/g,'');
			var dialog = top.layer.open({
				type : 2,
				title: name,
				area : [ "800px", "450px" ],
				content : url,
				end : function(){
					flowUtils.refreshCurrentBack();
				}
			});
			top.layer.full(dialog);
			if (flowUtils.notNull(callback)) {
				callback();
			}
		}*/
		flowUtils.open(url, name, callback);
	},
	/**
	 * 关闭当前窗口
	 */
	closeWindow : function() {
		if (window.opener == null) {
			document.title = "页面已过期";
			location.replace("about:blank");
		} else {
			window.close();
		}
	},
	closeWindowOnDialog : function() {
		/*top.layer.closeAll();*/
		flowUtils.closeWindow();
	},
	/**
	 * 刷新父页面，bpm_operator_refresh
	 */
	refreshBack : function() {
		if (window.opener && !window.opener.closed) {
			if (flowUtils.notNull(window.opener.bpm_operator_refresh)) {
				window.opener.bpm_operator_refresh();
			}
		}
	},
	/**
	 * 刷新当前页面
	 */
	refreshCurrentBack : function() {
		if (typeof bpm_operator_refresh != 'undefined' && flowUtils.notNull(bpm_operator_refresh)) {
			bpm_operator_refresh();
		}
	},
	/**
	 * 打开待办统一处理
	 */
	executeTask : function(entryId, executionId, taskId, formId, url, title, taskType) {
		if (url == null || url == '') {
			return;
		}
		if (taskType == '1') {
			$.ajax({
				type : "POST",
				data : {
					dbid : taskId,
					entryId : entryId,
					doTask : "false"//是否是快速办理
				},
				url : "platform/bpm/business/finishreader",
				dataType : "JSON",
				success : function(msg) {
					if(msg.result == true || msg.result == "true"){
						flowUtils.refreshCurrentBack();
					}
				}
			});
		}
		var proxyPage = "N"; //是否做页面代理
		if (url.indexOf("proxyPage=Y") != -1) {//是否做页面代理
			proxyPage = "Y";
		}
		if (proxyPage != "Y") { //不明确指定用代理页面的，则通通跳转到自己页面
			if (url.indexOf("?") > 0) {
				url += "&entryId=" + entryId;
			} else {
				url += "?entryId=" + entryId;
			}
			url += "&id=" + formId;
			url += "&executionId=" + executionId;
			if (url.indexOf("taskId=") == -1) {
				url += "&taskId=" + taskId;
			}
			url += "&title=" + encodeURI(title);
			flowUtils.openOnDialog(url, title);
		} else {
			var redirectPath = "avicit/platform6/bpmreform/bpmbusiness/approve/ProcessApprove.jsp";
			redirectPath += "?id=" + formId;
			redirectPath += "&entryId=" + entryId;
			redirectPath += "&executionId=" + executionId;
			redirectPath += "&taskId=" + taskId;
			redirectPath += "&title=" + encodeURI(title);
			if (url.indexOf("?") > 0) {
				url += "&entryId=" + entryId;
				url += "&id=" + formId;
				url += "&executionId=" + executionId;
				if (url.indexOf("taskId=") == -1) {
					url += "&taskId=" + taskId;
				}
			} else {
				url += "?entryId=" + entryId;
				url += "&id=" + formId;
				url += "&executionId=" + executionId;
				if (url.indexOf("taskId=") == -1) {
					url += "&taskId=" + taskId;
				}
			}
			redirectPath += "&url=" + encodeURI(url);
			flowUtils.openOnDialog(redirectPath, title);
		}
	},
	quickDoTask : function(entryId, executionId, taskId, formId, url, title, taskType) {
		if (taskType == '1') {
			flowUtils.confirm("确定已阅吗？", function(){
				avicAjax.ajax({
					type : "POST",
					data : {
						dbid : taskId,
						entryId : entryId,
						doTask : "true"//是否是快速办理
					},
					url : "platform/bpm/business/finishreader",
					dataType : "JSON",
					success : function(msg) {
						if (flowUtils.notNull(msg.error)) {
							flowUtils.error(msg.error);
						} else {
							flowUtils.success("操作成功！", function() {
								flowUtils.refreshCurrentBack();
							}, true);
						}
					}
				});
			});
		}else{
			new FlowButtons().dosubmit(entryId, executionId, taskId, formId);
		}
	},
	detailOnceFlg : false,
	/**
	 * 统一的从列表打开表单的方法
	 * @param id
	 */
	detail : function(id) {
		if(flowUtils.detailOnceFlg){
			return;
		}
		flowUtils.detailOnceFlg = true;
		$.ajax({
			type : "POST",
			data : {
				id : id,
				manager : "0"
			},
			url : "platform/bpm/business/getProcessDetailParameter",
			dataType : "JSON",
			success : function(msg) {
				flowUtils.detailOnceFlg = false;
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					if(msg.result.length == 0){
						flowUtils.warning("没有查询到可用的任务链接，可能是数据错误，请联系管理员解决");
					}else if(msg.result.length == 1){
						var n = msg.result[0];
						flowUtils.executeTask(n.processInstance, n.executionId, n.dbid, n.businessId, n.formResourceName, n.taskTitle, n.taskType);
					}else{
						var html = '<div style="margin-left:10px;margin-right:10px;"><table class="table">';
						html += '<thead>';
						html += '<tr>';
						html += '<td width="40%">任务名称</td>';
						html += '<td width="10%">任务类型</td>';
						html += '<td width="15%">节点</td>';
						html += '<td width="15%">发送人</td>';
						html += '<td width="20%">接收时间</td>';
						html += '</tr>';
						html += '</thead>';
						html += '<tbody>';
						$.each(msg.result, function(i, n) {
							html += '<tr>';
							html += '<td>';
							html += '<a href="javascript:void(0);" onclick="flowUtils.executeTask(\''+n.processInstance+'\',\''+n.executionId+'\',\''+n.dbid+'\',\''+n.businessId+'\',\''+n.formResourceName+'\',\''+n.taskTitle+'\',\''+n.taskType+'\');flowUtils.closeDetailDialog();">';
							html += n.taskTitle;
							html += '</a>';
							html += '</td>';
							html += '<td>';
							html += n.userIdentity;
							html += '</td>';
							html += '<td>';
							html += n.taskName;
							html += '</td>';
							html += '<td>';
							html += n.taskSendUser;
							html += '</td>';
							html += '<td>';
							html += n.cTime;
							html += '</td>';
							html += '</tr>';
						});
						html += '</tbody>';
						html += '</table></div>';
						
						flowUtils.detailDialog = layer.open({
							type : 1,
							title : "选择要打开的任务",
							area : [ "700px", "400px" ],
							content : html,
							end : function() {
								flowUtils.detailDialog = null;
							}
						});
					}
				}
			}
		});
	},
	/**
	 * 管理员修改页面数据
	 * @param id
	 */
	detailByManager : function(id) {
		$.ajax({
			type : "POST",
			data : {
				id : id,
				manager : "1"
			},
			url : "platform/bpm/business/getProcessDetailParameter",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					if(msg.result.length == 0){
						flowUtils.warning("没有查询到可用的任务链接，可能是数据错误，请联系管理员解决");
					}else if(msg.result.length == 1){
						var n = msg.result[0];
						flowUtils.executeTask(n.processInstance, "1", "1", n.businessId, n.formResourceName, n.taskTitle, "2");
					}
				}
			}
		});
	},
	closeDetailDialog : function(){
		if(flowUtils.detailDialog != null){
			layer.close(flowUtils.detailDialog);
			flowUtils.detailDialog = null;
		}
	},
	/**
	 * 批量办理
	 * @param entryIds
	 * @param executionIds
	 * @param taskIds
	 */
	doBatchHandle : function(entryIds, executionIds, taskIds){
		if(flowUtils.notNull(entryIds, executionIds, taskIds)){
			flowUtils.confirm("确定批量操作吗？提示：只有符合批量办理前提条件的才会被办理成功", function(){
				avicAjax.ajax({
					type : "POST",
					data : {
						entryIds : entryIds,
						executionIds : executionIds,
						taskIds : taskIds
					},
					url : "platform/bpm/batchhandle/doBatchHandle",
					dataType : "JSON",
					success : function(msg) {
						flowUtils.getBatchHandleInfo();
					}
				});
			});
		}
	},
	/**
	 * 批量已阅
	 * @param entryIds
	 * @param executionIds
	 * @param taskIds
	 */
	doBatchRead : function(entryIds, executionIds, taskIds){
		if(flowUtils.notNull(entryIds, executionIds, taskIds)){
			flowUtils.confirm("确定批量操作吗？", function(){
				avicAjax.ajax({
					type : "POST",
					data : {
						entryIds : entryIds,
						executionIds : executionIds,
						taskIds : taskIds
					},
					url : "platform/bpm/batchhandle/doBatchRead",
					dataType : "JSON",
					success : function(msg) {
						flowUtils.getBatchHandleInfo();
					}
				});
			});
		}
	},
	/**
	 * 批量处理回调
	 */
	getBatchHandleInfo : function(initMessage){
		$.ajax({
			type : "POST",
			data : {},
			url : "platform/bpm/batchhandle/getBatchHandleInfo",
			dataType : "JSON",
			success : function(msg) {
				if(flowUtils.notNull(msg.result)){
					var total = msg.result[0];
					var success = msg.result[1];
					var error = msg.result[2];
					if(Number(total) <= Number(success) + Number(error)){
						$.messager.progress('close');
						flowUtils.success("操作完成！共提交了" + total + "条，成功" + success + "条，失败" + error + "条");
						flowUtils.refreshCurrentBack();
					}else{
						if(!initMessage){
							$.messager.progress({
								text:"正在进行批量操作..."
							});
						}
				        setTimeout(function() {
				            //更新进度
				        	flowUtils.getBatchHandleInfo(true);
				        }, 1000);
					}
				}
			}
		});
		
	},
	/**
	 * @description 得到URL中的参数
	 * @param Name
	 *            参数名
	 * @param url
	 *            url,取当前页面的url时可以忽略该参数
	 * @return url中的参数值
	 */
	getUrlQuery : function(Name, url) {
		var query;
		if (arguments.length > 1)
			query = url.substr(url.indexOf('?') + 1);
		else
			query = window.location.search.substr(1);
		var reg = new RegExp("(^|&)" + Name + "=([^&]*)(&|$)");
		var r = query.match(reg);
		if (r != null)
			// return (r[2]);
			return decodeURI(r[2]);
		return null;
	},
	getValueOfObject : function(o, name, def_v) {
		if (o == null || o == undefined) {
			return null;
		}

		var t = eval("o." + name);

		if (undefined != t) {
			return t;
		} else {
			return def_v;
		}
	},
	clone : function(obj, shallow) {
		shallow = (shallow != null) ? shallow : false;
		var clone = null;
		if (obj != null && typeof (obj.constructor) == 'function') {
			clone = new obj.constructor();
			for ( var i in obj) {
				if (!shallow && typeof (obj[i]) == 'object') {
					clone[i] = flowUtils.clone(obj[i]);
				} else {
					clone[i] = obj[i];
				}
			}
		}
		return clone;
	}
};
/** ***************扩展****************** */
/**
 * 交换数组中两项的位置 此方法采用了 Microsoft Ajax Library 中的实现。
 * 
 * @param p_item1
 *            指定项1
 * @param p_item2
 *            指定项2
 * @return
 */
Array.prototype.swap = function(p_item1, p_item2) {
	var index1 = this.indexOf(p_item1);
	var index2 = this.indexOf(p_item2);

	this[index1] = p_item2;
	this[index2] = p_item1;
};

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
};

/**
 * 返回此数组中是否包含指定的项。 此方法采用了 Microsoft Ajax Library 中的实现。
 * 
 * @param p_item
 *            指定项
 * @return
 */
Array.prototype.contains = function(p_item) {
	return this.indexOf(p_item) != -1
};

/**
 * 向此数组中添加指定的项，并返回此新增项。 此方法采用了 Microsoft Ajax Library 中的实现。
 * 
 * @param p_item
 *            指定项
 * @return
 */
Array.prototype.add = function(p_item) {
	return this.push(p_item);
};

/**
 * 在此数组中指定的位置插入项，并返回此新增项。 此方法采用了 Microsoft Ajax Library 中的实现。
 * 
 * @param p_item
 *            指定项
 * @return
 */
Array.prototype.insert = function(p_startIndex, p_item) {
	return this.splice(p_startIndex, 0, p_item);
};

/**
 * 将指定的项从此数组中移除，并返回被移除的项。 此方法采用了 Microsoft Ajax Library 中的实现。
 * 
 * @param p_item
 *            指定项
 * @return
 */
Array.prototype.remove = function(p_item) {
	return this.removeAt(this.indexOf(p_item));
};

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
};

/**
 * 清楚数组中所有的项。此方法采用了 Microsoft Ajax Library 中的实现。
 */
Array.prototype.clear = function() {
	if (this.length > 0) {
		this.splice(0, this.length);
	}
};

/**
 * 创建与此数组相同的 Array 类的实例。
 */
Array.prototype.clone = function() {
	return this.slice(0, this.length);
};
/**
 * 直接返回一个包含2个元素的数组，一个是删除重复项的新数组，一个是所有的重复项的数组
 * 
 * @return {}
 */
Array.prototype.distinct = function() {
	var ret = [], resultArr = [], returnArr = [];
	var a = {};
	for (var i = 0; i < this.length; i++) {
		if (typeof a[this[i]] == "undefined") {
			a[this[i]] = false; // 数组中只有一项
		} else {
			a[this[i]] = true; // 数组中有重复的项
		}
	}
	for ( var i in a) {
		resultArr[resultArr.length] = i;
		if (a[i]) {
			returnArr[returnArr.length] = i;
		}
	}
	ret[0] = resultArr;// 没有重复项的数组
	ret[1] = returnArr;// 包含的所有重复项
	return ret;
};
/**
 * 指定将此数组序列化时，使用的类型别名。默认为“string[]”。
 */
Array.prototype._c = "Array";
/**
 * 字符串扩展 trim方法，删掉两边空格
 */
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
};
/**
 * 字符串扩展 trim方法，删掉两边空格
 */
String.prototype.Trim = String.prototype.trim;
/**
 * 字符串扩展 ltrim方法，删掉左边空格
 */
String.prototype.ltrim = function() {
	return this.replace(/(^\s*)/g, "");
};
/**
 * 超出指定长度，用省略号代替
 * 
 * @param maxLength
 *            长度上限
 * @return 结果
 */
String.prototype.ellipse = function(maxLength) {
	if (this.length > maxLength) {
		return this.substr(0, maxLength - 3) + "...";
	}
	return this;
};
/**
 * 格式化，替换变量值，类似于java中的String.forma("%s",str)
 * 
 * @param 替换值
 * @return 结果
 */
String.prototype.format = function() {
	var s = this;
	for (var i = 0; i < arguments.length; i++) {
		s = s.replaceAll("{" + i + "}", arguments[i]);
	}
	return s;
};
/**
 * 字符串扩展 ltrim方法，删掉左边空格
 */
String.prototype.Ltrim = String.prototype.ltrim;
/**
 * 字符串扩展 rtrim方法，删掉右边空格
 */
String.prototype.rtrim = function() {
	return this.replace(/(\s*$)/g, "");
};
/**
 * 字符串扩展 rtrim方法，删掉右边空格
 */
String.prototype.Rtrim = String.prototype.rtrim;
/**
 * 区别于replace方法，全部替换匹配的子串（replace是正则替换）
 */
String.prototype.replaceAll = function(AFindText, ARepText) {
	var raRegExp = new RegExp(AFindText.replace(/([\(\)\[\]\{\}\^\$\+\-\*\?\.\"\'\|\/\\])/g, "\\$1"), "ig");
	return this.replace(raRegExp, ARepText);
};
String.prototype.endsWith = function(p_string) {
	return this.substring(this.length - p_string.length) == p_string;
};
String.prototype.startsWith = function(p_string) {
	return this.substring(0, p_string.length) == p_string;
};
/* 将一位数字格式化成两位,如: 9 to 09 */
String.prototype.fmtWithZero = function(isFmtWithZero) {
	if (isFmtWithZero)
		return (this < 10 ? "0" + this : this);
	else
		return this;
};
String.prototype.fmtWithZeroD = function(isFmtWithZero) {
	if (isFmtWithZero)
		return (this < 10 ? "00" + this : (this < 100 ? "0" + this : this));
	else
		return this;
};

/**
 * 解析字符串成为日期类型，格式为yyyy-MM-dd HH-mm-ss
 */
Date.parse = function(p_text) {
	try {
		var p_text = p_text.trim().replaceAll("日", "");
		var p_text = p_text.trim().replaceAll("秒", "");
		if (!p_text)
			return null;
		var year = p_text.substring(0, 4) * 1;
		var month = p_text.substring(5, 7) * 1 - 1;
		var day = p_text.substring(8, 10) * 1;
		var hour = p_text.substring(11, 13) * 1;
		var min = p_text.substring(14, 16) * 1;
		var sec = p_text.substring(17, 19) * 1;
		var ms = ("0." + p_text.substring(20)) * 1000;
		return new Date(year, month, day, hour, min, sec, ms);
	} catch (e) {
		return null;
	}
};

/**
 * 日期增加天数
 * 
 * @param diffDay
 *            整型，要增加的天数
 */
Date.prototype.addDay = function(diffDay) {
	var day = this.getDate();
	this.setDate(day + diffDay);
	return this;
};
/**
 * 日期增加月份
 * 
 * @param diffMonth
 *            整型，要增加的月数
 */
Date.prototype.addMonth = function(diffMonth) {
	var month = this.getMonth();
	this.setMonth(month + diffMonth);
	return this;
};
/**
 * 日期增加年份
 * 
 * @param diffYear
 *            整型，要增加的年数
 */
Date.prototype.addYear = function(diffYear) {
	var year = this.getYear();
	this.setYear(year + diffYear);
	return this;
};
// 根据当前日期所在年和周数返回周一的日期
Date.prototype.RtnMonByWeekNum = function(weekNum) {
	if (typeof (weekNum) != "number")
		throw new Error(-1, "RtnByWeekNum(weekNum)的参数是数字类型.");
	var date = new Date(this.getFullYear(), 0, 1);
	var week = date.getDay();
	week = (week == 0 ? 7 : week);
	return date.dateAfter(weekNum * 7 - week - 6 + 7, 1);
};

// 根据当前日期所在年和周数返回周日的日期
Date.prototype.RtnSunByWeekNum = function(weekNum) {
	if (typeof (weekNum) != "number")
		throw new Error(-1, "RtnByWeekNum(weekNum)的参数是数字类型.");
	var date = new Date(this.getFullYear(), 0, 1);
	var week = date.getDay();
	week = (week == 0 ? 7 : week);
	return date.dateAfter(weekNum * 7 - week - 0 + 7, 1);
};
/*
 * 功能 : 返回与某日期相距N天(N个24小时)的日期 参数 : num number类型 可以为正负整数或者浮点数,默认为1; type 0(秒) or
 * 1(天),默认为秒 返回 : 新的PowerDate类型
 */
Date.prototype.dateAfter = function(num, type) {
	num = (num == null ? 1 : num);
	if (typeof (num) != "number")
		throw new Error(-1, "dateAfterDays(num,type)的num参数为数值类型.");
	type = (type == null ? 0 : type);
	var arr = [ 1000, 86400000 ];
	var dd = this.valueOf();
	dd += num * arr[type];
	return new Date(dd);
};
/*
 * 功能:根据输入表达式返回日期字符串 参数:dateFmt:字符串,由以下结构组成
 * yy:长写年,YY:短写年mm:数字月,MM:英文月,dd:日,hh:时, mi:分,ss秒,ms:毫秒,we:汉字星期,WE:英文星期.
 * isFmtWithZero : 是否用0进行格式化,true or false
 */
Date.prototype.parseString = function(dateFmt, isFmtWithZero) {
	dateFmt = (dateFmt == null ? "yy-mm-dd" : dateFmt);
	isFmtWithZero = (isFmtWithZero == null ? true : isFmtWithZero);
	if (typeof (dateFmt) != "string")
		throw (new Error(-1, 'parseString()方法需要字符串类型参数!'));
	var weekArr = [ [ "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" ], [ "SUN", "MON", "TUR", "WED", "THU", "FRI", "SAT" ] ];
	var monthArr = [ "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" ];
	var str = dateFmt;
	str = str.replace(/yy/g, this.getFullYear());
	str = str.replace(/YY/g, this.getYear());
	str = str.replace(/mm/g, (this.getMonth() + 1).toString().fmtWithZero(isFmtWithZero));
	str = str.replace(/MM/g, monthArr[this.getMonth()]);
	str = str.replace(/dd/g, this.getDate().toString().fmtWithZero(isFmtWithZero));
	str = str.replace(/hh/g, this.getHours().toString().fmtWithZero(isFmtWithZero));
	str = str.replace(/mi/g, this.getMinutes().toString().fmtWithZero(isFmtWithZero));
	str = str.replace(/ss/g, this.getSeconds().toString().fmtWithZero(isFmtWithZero));
	str = str.replace(/ms/g, this.getMilliseconds().toString().fmtWithZeroD(isFmtWithZero));
	str = str.replace(/we/g, weekArr[0][this.getDay()]);
	str = str.replace(/WE/g, weekArr[1][this.getDay()]);
	return str;
};
Date.prototype.format = function(format) {
	if (format == null || format == "")
		format = "yyyy-MM-dd HH:mm:ss";
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"H+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	// millisecond
	}
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
	return format;
};

Boolean.parse = function(p_text) {
	if (typeof (p_text) == "boolean") {
		return p_text;
	}
	t = p_text.toLowerCase();
	return (t == "true") || (t == "1");
};
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
}
/**
 * 模拟ajax导出 无弹出框,post提交无参数限制
 * 
 * @param iframeId
 * @param formId
 * @param headData
 */
function FlowDownLoad4URL(iframeId, formId, headData, actionUrl) {
	// 设置是否显示遮罩Iframe
	if (typeof (iframeId) !== 'string' && iframeId.trim() !== '') {
		throw new Error("iframeId不能为空！");
	}

	// 设置是否显示遮罩Iframe
	if (typeof (formId) !== 'string' && formId.trim() !== '') {
		throw new Error("formId不能为空！");
	}
	this.iframeName = "_iframe_" + iframeId;
	this.formName = "_form_" + formId;
	this.doc = document;// 全局对象，提高效率
	this.createDom.call(this, headData, actionUrl);
};
FlowDownLoad4URL.prototype.downLoad = function() {
	this.doc.getElementById(this.formName).submit();
};
FlowDownLoad4URL.prototype.createDom = function(headData, url) {
	// 先销毁对象，再创建
	if (jQuery("#" + this.iframeName).length > 0) {
		jQuery("#" + this.iframeName).remove();

	}

	// 先销毁对象，再创建
	if (jQuery("#" + this.formName).length > 0) {
		jQuery("#" + this.formName).remove();
	}
	if (jQuery("#" + this.iframeName).length == 0) {
		var exportIframe = this.doc.createElement("iframe");
		exportIframe.id = this.iframeName;
		exportIframe.name = this.iframeName;
		exportIframe.style.display = 'none';
		this.doc.body.appendChild(exportIframe);
		// 创建form
		var exportForm = this.doc.createElement("form");
		exportForm.method = 'post';

		exportForm.action = url;
		exportForm.name = this.formName;
		exportForm.id = this.formName;
		exportForm.target = this.iframeName;
		this.doc.body.appendChild(exportForm);
		if (headData && typeof (headData) === 'object') {
			for ( var key in headData) {
				var headInput = this.doc.createElement("input");
				headInput.setAttribute("name", key);
				headInput.setAttribute("type", "text");
				if (typeof (headData[key]) == 'string') {
					headInput.setAttribute("value", headData[key]);
				} else {
					var jsonStr = JSON.stringify(headData[key]);
					headInput.setAttribute("value", jsonStr);
				}
				exportForm.appendChild(headInput);
			}
		}
	}
};
//初始化
$(function() {
	if (typeof _bpm_baseurl != 'undefined' && flowUtils.notNull(_bpm_baseurl)) {
		flowUtils.baseurl = _bpm_baseurl;
	}else{
		$.ajax({
			type : "POST",
			url : "platform/bpm/business/getBaseUrl",
			dataType : "text",
			success : function(url) {
				flowUtils.baseurl = url;
			}
		});
	}
});