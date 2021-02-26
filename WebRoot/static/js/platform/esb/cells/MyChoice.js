/**
 * MyChoice extends MyBase
 */
function MyChoice(id) {
	MyBase.call(this, id, "choice", "CHOICE");
};
MyChoice.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyChoice.prototype.init = function() {
	this.initBase();
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyChoice.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	
	//还原属性域和_myCellMap
	var cells = _editor.graph.model.getChildren(this.getCell());
	myAction.addCells(cells);
	//还原属性值
	var $templet = $("#" + this.id).find("#expression").children().first();
	var _self = this;
	$(xmlValue).children().each(function(i, n){
		$(n).children().each(function(i, m){
			var id = $(m).attr("doc:description");
			_myCellMap.get(id).initLoad($(m));
		});
		var id = $(n).children().first().attr("doc:description");
		var text = $(n).children().first().attr("doc:name");
		var expression = $(n).attr("expression");
		var tag = $(n).get(0).tagName;
		if(tag == "otherwise"){
			_self.addExp($templet, id, text, true, "");
		}else{
			_self.addExp($templet, id, text, false, expression);
		}
	});
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyChoice.prototype.getOtherAttr = function(node) {
	var _self = this;
	var defaultNode = null;
	$.each(this.linkedList.head.getNext(), function(i, id){
		var $m = $("#" + _self.id).find("#exp" + id);
		var $default = $m.find('input[type="checkbox"]').prop('checked');
		if($default){
			defaultNode = ComUtils.createElement("otherwise");
			_self.circle([id], defaultNode);
		}else{
			var when = ComUtils.createElement("when");
			when.setAttribute("expression", $.trim($m.find('.prop_txt').val()));
			_self.circle([id], when);
			node.appendChild(when);
		}
	});
	if($.notNull(defaultNode)){
		node.appendChild(defaultNode);
	}
};
MyChoice.prototype.afterShowProp = function(){
	var _self = this;
	this.linkedList.clear();
	var cells = _editor.graph.model.getChildren(this.getCell());
	if($.notNull(cells)){
		$.each(cells, function(i, cell){
			if (cell.edge) {
				_self.linkedList.add(cell.source.id, cell.target.id);
			}else if(cell.vertex){
				if(cell.edges == null || cell.edges.length == 0){
					_self.linkedList.add("head", cell.id);
				}
			}
		});
	}
	
	$("#" + this.id).find("#expression").children().slice(1).addClass("removeLazy");
	var $templet = $("#" + _self.id).find("#expression").children().first();
	$.each(this.linkedList.head.getNext(), function(i, n){
		var $m = $("#" + _self.id).find("#exp" + n);
		var text = _editor.graph.getModel().getCell(n).value;
		if($m.length == 0){
			_self.addExp($templet, n, text, false, "");
		}else{
			$m.removeClass("removeLazy");
			$m.children().last().text(text);
		}
	});
	$("#" + this.id).find(".removeLazy").remove();
};
/**
 * 内部方法
 */
MyChoice.prototype.addExp = function($templet, id, text, check, expression) {
	var temp = $templet.clone(true, true);
	temp.attr("id", "exp" + id);
	temp.find(".prop_txt").val($.trim(expression));
	temp.children().last().text(text);
	if(check){
		temp.find(".prop_txt").attr('disabled', true);
		temp.find('input[type="checkbox"]').attr('checked', true);
	}
	temp.appendTo($("#" + this.id).find("#expression"));
	temp.show();
};