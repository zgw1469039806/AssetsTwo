/**
 * text extends MyBase
 */
function MyText(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "text");
};
MyText.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyText.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getText();
	this.labelChanged("添加文本");
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyText.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setText(this.resolve());// 设置自增长数字
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
MyText.prototype.getOtherAttr = function(node) {
};
MyText.prototype.afterShowProp = function() {
	var cell = this.getCell();
	var color = this.designerEditor.getStyleValue('fontColor', cell);
	if(color){
		$('#' + this.id).find('#textColor').val(color);
	}
	var size = this.designerEditor.getStyleValue('fontSize', cell);
	if(size){
		$('#' + this.id).find('#textSize').val(size + "");
	}
};
