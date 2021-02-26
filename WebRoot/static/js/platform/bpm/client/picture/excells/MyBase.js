/**
 * MyBase
 */
function MyBase(id, tagName) {
	this.id = id;// ID,流程的ID为流程的KEY
	this.tagName = tagName;
	this.forkJoinArr = [];
};
/****************初始化、组装xml入口***************************/
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 * @param rootXml
 */
MyBase.prototype.initLoad = function(xmlValue, rootXml) {
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	rootXml.appendChild(this.createMxCell());// 创建mxCell
	_myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
MyBase.prototype.getCell = function() {
	return _editor.graph.getModel().getCell(this.id);
};
/**
 * 解析字符串G，连线重写了该方法
 * 
 * @returns {object}
 */
MyBase.prototype.getmxCellG = function() {
	var arr = this.g.split(",");
	var result = {};
	result.x = arr[0];
	result.y = arr[1];
	result.width = arr[2];
	result.height = arr[3];
	return result;
};
/**
 * 构建mxCell,连线子类改写了该方法，流程不需要该方法
 */
MyBase.prototype.createMxCell = function() {
	var mxCellG = this.getmxCellG();
	var mxCell = ComUtils.createElement("mxCell");
	var mxGeometry = ComUtils.createElement("mxGeometry");
	mxCell.setAttribute("id", this.id);
	mxCell.setAttribute("value", $.trim(this.alias));
	mxCell.setAttribute("style", this.style);
	mxCell.setAttribute("tagName", this.tagName);
	mxCell.setAttribute("vertex", "1");
	mxCell.setAttribute("parent", "1");

	mxGeometry.setAttribute("x", mxCellG.x);
	mxGeometry.setAttribute("y", mxCellG.y);
	mxGeometry.setAttribute("width", mxCellG.width);
	mxGeometry.setAttribute("height", mxCellG.height);
	mxGeometry.setAttribute("as", "geometry");

	mxCell.appendChild(mxGeometry);
	return mxCell;
};

/**
 * 从tagNodeXml中取出指定attrName的值
 * 
 * @param tagNodeXml
 * @param attrName
 */
MyBase.prototype.getAttr = function(tagNodeXml, attrName) {
	return $.trim(tagNodeXml.getAttribute(attrName));
};
MyBase.prototype.addForkJoin = function(forkJoinId) {
	this.forkJoinArr.push(forkJoinId);
};
MyBase.prototype.hasForkJoin = function() {
	return this.forkJoinArr.length > 0 ? true : false;
};

