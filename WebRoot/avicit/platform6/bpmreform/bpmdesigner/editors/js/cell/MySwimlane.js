/**
 * swimlane extends MyBase
 */
function MySwimlane(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "swimlane");
	this.swimlaneType = "";
};
MySwimlane.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MySwimlane.prototype.init = function() {
	if(this.designerEditor.isSwimlane1(this.getCell())){
		this.swimlaneType = "swimlane1";
		this.designerEditor.swimlane1 ++;
	}else{
		this.swimlaneType = "swimlane2";
		this.designerEditor.swimlane2 ++;
	}
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getSwimlane();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MySwimlane.prototype.initLoad = function(xmlValue, rootXml) {
	if(this.designerEditor.isSwimlane1(xmlValue)){
		this.swimlaneType = "swimlane1";
		this.designerEditor.swimlane1 ++;
	}else{
		this.swimlaneType = "swimlane2";
		this.designerEditor.swimlane2 ++;
	}
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setSwimlane(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MySwimlane.prototype.getOtherAttr = function(node) {
	node.setAttribute("cellType", this.swimlaneType);
};
/**
 * 销毁dom对象
 */
MySwimlane.prototype.remove = function() {
	if(this.swimlaneType == "swimlane1"){
		this.designerEditor.swimlane1 --;
	}else if(this.swimlaneType = "swimlane2"){
		this.designerEditor.swimlane2 --;
	}
	$("#" + this.id).remove();
};