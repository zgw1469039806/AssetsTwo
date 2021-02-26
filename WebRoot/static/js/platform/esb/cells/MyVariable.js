/**
 * MyVariable extends MyBase
 */
function MyVariable(id) {
	MyBase.call(this, id, "variable", "VARIALBLE");
};
MyVariable.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyVariable.prototype.init = function() {
	this.initBase();
	this.tagName = "set-variable";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyVariable.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	this.tagName = xmlValue.get(0).tagName;
	if(this.tagName == "remove-variable"){
		$("#" + this.id).find("#remove-variable").attr("checked", true);
		$("#" + this.id).find("#remove-variable").next().trigger('click');
	}
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomValByAttr("bian_liang_ming_cheng", xmlValue, "variableName");
	this.setDomValByAttr("bian_liang_zhi", xmlValue, "value");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyVariable.prototype.getOtherAttr = function(node) {
	this.setXmlAttrByVal("variableName", "bian_liang_ming_cheng", node);
	if(this.tagName == "set-variable"){
		this.setXmlAttrByVal("value", "bian_liang_zhi", node);
	}
};
MyVariable.prototype.endpointChanged = function(value) {
	this.tagName = value;
};