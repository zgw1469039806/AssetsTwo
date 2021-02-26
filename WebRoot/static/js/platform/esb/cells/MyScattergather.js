/**
 * MyScattergather extends MyBase
 */
function MyScattergather(id) {
	MyBase.call(this, id, "scattergather", "PARALLEL PROCESS");
};
MyScattergather.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyScattergather.prototype.init = function() {
	this.initBase();
	this.tagName = "scatter-gather";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyScattergather.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	
	//还原属性域和_myCellMap
	var cells = _editor.graph.model.getChildren(this.getCell());
	myAction.addCells(cells);
	//还原属性值
	var _self = this;
	$(xmlValue).children().each(function(i, n){
		if($(n).get(0).tagName == "processor-chain"){
			$(n).children().each(function(i, m){
				var id = $(m).attr("doc:description");
				_myCellMap.get(id).initLoad($(m));
			});
		}else{
			var id = $(n).attr("doc:description");
			_myCellMap.get(id).initLoad($(n));
		}
	});
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyScattergather.prototype.getOtherAttr = function(node) {
	var _self = this;
	$.each(this.linkedList.head.getNext(), function(i, id){
		var arr = _self.linkedList.map.get(id).getNext();
		if(arr.length > 0){
			var chain = ComUtils.createElement("processor-chain");
			_self.circle([id], chain);
			node.appendChild(chain);
		}else{
			var baseNode = _myCellMap.get(id);
			var childNode = baseNode.getXmlDoc();
			node.appendChild(childNode);
		}
	});
};