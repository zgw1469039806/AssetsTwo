/**
 * transition extends MyBase
 */
function MyTransition(id) {
	MyBase.call(this, id, "transition");
};
MyTransition.prototype = new MyBase();
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyTransition.prototype.initLoad = function(xmlValue, rootXml, tagId) {
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");

	this.edgeStyle = $.trim(xmlValue.getAttribute("edgeStyle"));

	rootXml.appendChild(this.createMxCell(tagId));// 创建mxCell
};
/**
 * 重写解析位置G的方法
 * 
 * @returns {String}
 */
MyTransition.prototype.getG = function() {
	return "-5,-22";
};
/**
 * 解析字符串G，连线重写了该方法
 * 
 * @returns {object}
 */
MyTransition.prototype.getmxCellG = function() {
	var arr = this.g.split(",");
	if(arr.length == 4){
		var result = {};
		result.x = arr[0];
		result.y = arr[1];
		return result;
	}else{
		return null;
	}
};
/**
 * 构建mxCell
 */
MyTransition.prototype.createMxCell = function(tagId) {
	var targetName = this.name.split(" ")[1];
	var mxCell = ComUtils.createElement("mxCell");
	var mxGeometry = ComUtils.createElement("mxGeometry");
	mxCell.setAttribute("id", this.id);
	mxCell.setAttribute("value", "");
	mxCell.setAttribute("edge", "1");
	mxCell.setAttribute("parent", "1");
	mxCell.setAttribute("source", tagId);
	
	var targetNode =  _myLoadMap.get(targetName);
	if(targetNode.tagName == "fork" || targetNode.tagName == "join" || targetNode.tagName == "foreach"){
		_myCellMap.get(tagId).addForkJoin(targetNode.id);
	}
	
	mxCell.setAttribute("target", targetNode.id);

	
	mxGeometry.setAttribute("relative", "1");
	mxGeometry.setAttribute("as", "geometry");

	//扩展，如果记录了连线位置，则给point
	var mxCellG = this.getmxCellG();
	if($.notNull(mxCellG)){
		var mxArray=ComUtils.createElement("Array");
		mxArray.setAttribute("as", "points");
		var mxPoint = ComUtils.createElement("mxPoint");
		mxPoint.setAttribute("x", mxCellG.x);
		mxPoint.setAttribute("y", mxCellG.y);
		mxArray.appendChild(mxPoint);
		mxGeometry.appendChild(mxArray);
	}
	
	mxCell.appendChild(mxGeometry);

	if($.notNull(this.edgeStyle)){
		mxCell.setAttribute("style", "edgeStyle=" + this.edgeStyle);
	}

	return mxCell;
};
