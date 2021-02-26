/**
 * end extends MyBase
 */
function MyEnd(id) {
	MyBase.call(this, id, "end");
	this.style = "image;image=static/js/platform/designer/images/48/end_event_terminate.png;";
};
MyEnd.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyEnd.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + _countUtils.getEnd();
	this.labelChanged("结束");
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyEnd.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	_countUtils.setEnd(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	this.createRemarkDom(xmlValue);
	this.createEventDom(xmlValue, "qian_zhi_shi_jian", "start");//event
	this.createEventDom(xmlValue, "hou_zhi_shi_jian", "end");//event
	//首先解析人员信息
	this.createActorsDom(xmlValue);
	//文档权限
	this.createWDQXDom(xmlValue);
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell());// 创建mxCell
	_myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	
	
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyEnd.prototype.getOtherAttr = function(node) {
	this.createEventXml(node, "qian_zhi_shi_jian", "start");
	this.createEventXml(node, "hou_zhi_shi_jian", "end");
	
	//文档权限
	var docRights = ComUtils.createElement("docRights");
	this.createWDQXXml(docRights, "wordRead", "查看正文", node);
	this.createWDQXXml(docRights, "wordPrint", "打印正文", node);
	if(docRights.childNodes.length > 0){
		node.appendChild(docRights);
	}
	this.createRemarkXml(node);//备注
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MyEnd.prototype.getItem = function() {
	return [ {
		id : "jbxx_" + this.id,
		text : "基本信息",
		selected : true,
		icon : "grid.gif"
	}, {
		id : "wdqx_" + this.id,
		text : "文档权限",
		icon : "grid.gif"
	}, {
		id : "qzsj_" + this.id,
		text : "前置事件",
		icon : "grid.gif"
	}, {
		id : "hzsj_" + this.id,
		text : "后置事件",
		icon : "grid.gif"
	}, {
		id : "bzxx_" + this.id,
		text : "备注",
		icon : "grid.gif"
	}];
};