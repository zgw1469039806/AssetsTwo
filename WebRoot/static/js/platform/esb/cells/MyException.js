/**
 * MyException extends MyBase
 */
function MyException(id) {
	MyBase.call(this, id, "exception", "CATCH EXCEPTION");
};
MyException.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyException.prototype.init = function() {
	this.initBase();
	this.tagName = "catch-exception-strategy";
	if(this.parentId == "1"){
		_isException = 1;
	}
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyException.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomValByAttr("zhi_xing_tiao_jian", xmlValue, "when");
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
MyException.prototype.getOtherAttr = function(node) {
	//属性信息
	this.setXmlAttrByVal("when", "zhi_xing_tiao_jian", node);
	this.circle(this.linkedList.head.getNext(), node);
};
/**
 * 销毁dom对象
 */
MyException.prototype.remove = function() {
	$("#" + this.id).remove();
	if(this.parentId == "1"){
		_isException = 0;
	}
};