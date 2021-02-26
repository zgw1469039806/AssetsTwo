/**
 * MyBase
 */
function MyBase(id, tagName, alias) {
	this.id = id;// ID
	this.tagName = tagName;
	this.alias = alias;
	this.cell;// 对应mxCell,通过getCell()获取
	this.parentId;
	this.linkedList = new LinkedList();
};
/****************初始化、组装xml入口***************************/
/**
 * 初始化属性信息，新增mxCell时触发，子类重写
 */
MyBase.prototype.init = function() {
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyBase.prototype.initLoad = function(xmlValue) {
};
/**
 * 基础初始化功能，复制对应dom到相应区域内
 */
MyBase.prototype.initBase = function() {
	var temp = $("#" + this.tagName).clone(true, true);
	temp.attr("id", this.id);
	temp.appendTo($("#prop"));//属性区域
	$("#" + this.id).hide();
	$("#" + this.id).find(".prop_cont").hide();
	//this.labelChanged(this.alias);
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
};
/**
 * 组装esbXML,流程子类改写了该方法
 * 
 * @returns
 */
MyBase.prototype.getXmlDoc = function() {
	this.cell = this.getCell();// 重写获取cell,后续操作直接拿this.cell
	var node = ComUtils.createElement(this.tagName);
	this.putAttr("doc:description", this.id, node);
	this.putAttr("doc:name", this.alias, node);
	this.getOtherAttr(node);
	return node;
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyBase.prototype.getOtherAttr = function(node) {
};
/************页签相关*****************/
/**
 * 点击mxCell时，显示对应的属性
 */
MyBase.prototype.showProp = function() {
	$(".prop_wrap").hide();
	$("#" + this.id).show();
	
	var item = this.getItem();
	if (item.length == 0) {
		item = [ {
			text : "通用"
		} ];
	}
	
	var opts = $('#item').tabs('options');
	var bc = opts.onSelect;
	opts.onSelect = function() {};
	
	var tabs = $('#item').tabs('tabs');
	$.each(tabs, function(i, n){
		$('#item').tabs('close', 0);
	});
	
	$.each(item, function(i, n){
		$("#item").tabs("add",{
			title: n.text,
			selected: false
		});
	});
	
	$("#item").tabs("select", 0);
	this.selectProp(0);
	
	opts.onSelect = bc;
	
	this.afterShowProp();
};
MyBase.prototype.afterShowProp = function(){
};
/**
 * 自定义属性内容条目，子类可以重写
 * 
 * @returns {Array}
 */
MyBase.prototype.getItem = function() {
	return [];
};
/**
 * 属性分项点击事件后显示对应区域
 * 
 * @param index
 */
MyBase.prototype.selectProp = function(index) {
	$("#" + this.id).find(".prop_cont").hide();
	$("#" + this.id).children().eq(index).show();
};
/********************方法*****************************/
/**
 * 销毁dom对象
 */
MyBase.prototype.remove = function() {
	$("#" + this.id).remove();
};
/**
 * 监听name改变事件，流程子类改写了该方法
 * 
 * @param value
 */
MyBase.prototype.labelChanged = function(value) {
	this.alias = value;
	_editor.graph.labelChanged(this.getCell(), value);
};
/**
 * 类型 inbound-endpoint outbound-endpoint 
 * @param value
 */
MyBase.prototype.endpointChanged = function(value) {
};
/**
 * 获取当前对应的mxCell
 * 
 * @returns
 */
MyBase.prototype.getCell = function() {
	return _editor.graph.getModel().getCell(this.id);
};
/**********整理一下其他基本方法****************************/
/**
 * 往tagNodeXml中添加对应key-value,value进行空值判断
 * 
 * @param attrName
 * @param attrValue
 * @param tagNodeXml
 */
MyBase.prototype.putAttr = function(attrName, attrValue, tagNodeXml) {
	if($.notNull(attrValue)){
		tagNodeXml.setAttribute(attrName, attrValue);
	}
};
/**
 * 从tagNodeXml中取出指定attrName的值
 * 
 * @param tagNodeXml
 * @param attrName
 */
MyBase.prototype.getAttr = function(tagNodeXml, attrName) {
//	return $.trim(tagNodeXml.getAttribute(attrName));
	return $.trim(tagNodeXml.attr(attrName));
};
/*********************setxml********************************/
/**
 * 设置xml的attr,取值为dom的value
 * @param attrName
 * @param domId
 * @param tagNodeXml
 */
MyBase.prototype.setXmlAttrByVal = function(attrName, domId, tagNodeXml) {
	var dit = $("#" + this.id).find("#" + domId);
	if(dit.hasClass("required")){
		if(!$.notNull(dit.val())){
			_required = true;
			dit.addClass("requiredInput");
		}
	}
	this.putAttr(attrName, dit.val(), tagNodeXml);
};
/**
 * 组装spring:property
 * @param attrName
 * @param domId
 * @param tagNodeXml
 */
MyBase.prototype.setXmlPropertyByVal = function(tagName, name, domId, node) {
	var value = $("#" + this.id).find("#" + domId).val();
	if($.notNull(value)){
		var property = ComUtils.createElement(tagName);
		property.setAttribute("name", name);
		property.setAttribute("value", value);
		node.appendChild(property);
	}
};
/**
 * 设置xml的attr,取值为dom对象(check radio)
 * @param attrName
 * @param domName
 * @param tagNodeXml
 */
MyBase.prototype.setXmlAttrByCheck = function(attrName, domName, tagNodeXml) {
	this.putAttr(attrName, $("#" + this.id).find("input[name='" + domName + "']:checked").val(), tagNodeXml);
};
/**
 * 设置xml的attr,取值为dom对象(prop)
 * @param attrName
 * @param domId
 * @param domProp
 * @param tagNodeXml
 */
MyBase.prototype.setXmlAttrByProp = function(attrName, domId, domProp, tagNodeXml) {
	this.putAttr(attrName, $("#" + this.id).find("#" + domId).attr(domProp), tagNodeXml);
};
/************************setDom******************************/
/**
 * 设置dom对象的value,取值为xml的attr
 * @param domId
 * @param tagNodeXml
 * @param attrName
 */
MyBase.prototype.setDomValByAttr = function(domId, tagNodeXml, attrName) {
	$("#" + this.id).find("#" + domId).val(this.getAttr(tagNodeXml, attrName));
};
/**
 * 设置dom对象(check radio),取值为xml的attr
 * @param domId
 * @param tagNodeXml
 * @param attrName
 * @param domValue
 */
MyBase.prototype.setDomCheckByAttr = function(domId, tagNodeXml, attrName, domValue) {
	var attrValue = this.getAttr(tagNodeXml, attrName);
	if(attrValue == domValue){
		$("#" + this.id).find("#" + domId).attr("checked", true);
		$("#" + this.id).find("#" + domId).trigger('click');
	}
};
/**
 * 设置dom对象(自定义属性),取值为xml的attr
 * @param domId
 * @param tagNodeXml
 * @param attrName
 * @param domProp
 */
MyBase.prototype.setDomPropByAttr = function(domId, tagNodeXml, attrName, domProp) {
	var attrValue = this.getAttr(tagNodeXml, attrName);
	if($.notNull(attrValue)){
		$("#" + this.id).find("#" + domId).attr(domProp, attrValue);
	}
};
/***************************************************/
MyBase.prototype.circle = function(list, parentXml) {
	var _self = this;
	$.each(list, function(i, id){
		var baseNode = _myCellMap.get(id);
		var node = baseNode.getXmlDoc();
		parentXml.appendChild(node);
		_self.circle(_self.linkedList.map.get(id).getNext(), parentXml);
	});
};
/**
 * 格式化
 */
MyBase.prototype.formatGraph = function(){
	var _self = this;
	this.cell = this.getCell();
	var top = 25;
	$.each(this.linkedList.head.getNext(), function(i, id){
		var cellArr = [];
		_self.roundFormat([id], _formatW/2, cellArr);
		var height = 0;
		$.each(cellArr, function(j, cell){
			var cellHeight = Number(cell.getGeometry().height);
			if(height < cellHeight){
				height = cellHeight;
			}
		});
		_self.cell.getGeometry().height = top + height + 20;
		var cellTop = top + (height - Number(cellArr[0].getGeometry().height))/2;
		_editor.graph.moveCells([cellArr[0]], 0, cellTop - Number(cellArr[0].getGeometry().y));
		_editor.graph.alignCells("middle", cellArr);
		top = top + 20 + height;
	});
};
MyBase.prototype.roundFormat = function(nextArr, left, cellArr){
	var _self = this;
	$.each(nextArr, function(i, id){
		var cellNode = _editor.graph.getModel().getCell(id);
		if(myAction.isSwim(cellNode.tagName)){
			_myCellMap.get(id).formatGraph();
		}
		var right = left + Number(cellNode.getGeometry().width);
		if(right + _formatW/2 > Number(_self.cell.getGeometry().width)){
			_self.cell.getGeometry().width = right + _formatW/2;
		}
		_editor.graph.moveCells([cellNode], left - Number(cellNode.getGeometry().x), 0);
		cellArr.push(cellNode);
		_self.roundFormat(_self.linkedList.map.get(id).getNext(), right + _formatW, cellArr);
	});
};