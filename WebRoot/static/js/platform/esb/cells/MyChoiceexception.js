/**
 * MyChoiceexception extends MyBase
 */
function MyChoiceexception(id) {
	MyBase.call(this, id, "choiceexception", "CHOICE EXCEPTION");
};
MyChoiceexception.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyChoiceexception.prototype.init = function() {
	this.initBase();
	this.tagName = "choice-exception-strategy";
	if(this.parentId == "1"){
		_isException = 1;
	}
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyChoiceexception.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//还原属性域和_myCellMap
	var cells = _editor.graph.model.getChildren(this.getCell());
	myAction.addCells(cells);
	//还原属性值
	$(xmlValue).children().each(function(i, n){
		var id = $(n).attr("doc:description");
		_myCellMap.get(id).initLoad($(n));
	});
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyChoiceexception.prototype.getOtherAttr = function(node) {
	$.each(this.linkedList.head.getNext(), function(i, id){
		var baseNode = _myCellMap.get(id);
		var childNode = baseNode.getXmlDoc();
		node.appendChild(childNode);
	});
};
/**
 * 销毁dom对象
 */
MyChoiceexception.prototype.remove = function() {
	$("#" + this.id).remove();
	if(this.parentId == "1"){
		_isException = 0;
	}
};