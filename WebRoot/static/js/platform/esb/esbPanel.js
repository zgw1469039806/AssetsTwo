var _editor;// _editor
var _myCurCellId;// 当前对象ID
var _myCellMap;// 对象Map集合
var _myConnector;//myConnector,连接器配置信息等
var _linkedList;//主页面的连线信息
var _isException = 0;//是否已经有异常类了，0没有，1已经有
var _formatW = 50;
var _required = false;
$(function(){
	$.messager.defaults.ok = "确定";
	$.messager.defaults.cancel = "取消";
	// 初始化
	_myCellMap = new Map();
	_linkedList = new LinkedList();
	_myConnector = new MyConnector();
	_myConnector.init();//初始化连接器配置等信息的下拉框数据
	// 重写mxClient弹出框样式
	mxUtils.alert = function(message) {
		easyHelp.showMsg(message);
	};
	//属性
	$("#item").tabs({
		fit : true,
		border : false,
		tabPosition: "top",
		onSelect : function(title,index){
			_myCellMap.get(_myCurCellId).selectProp(index);
		}
	});
	//mxgraph
	_editor = new mxApplication(_configPath + "config/myEditor.xml");
	mxEvent.disableContextMenu(document.body);// 禁用右键菜单
	_editor.graph.allowDanglingEdges = false;// 禁止连线没有目标
//	_editor.graph.setCellsResizable(false);// 禁止改变元素大小
	_editor.graph.setAllowLoops(false);// 禁止连线的目标和源是同一元素
	_editor.graph.setMultigraph(false);// 禁止重复连接
	_editor.graph.htmlLabels = true;// isHtmlLabel
	mxGraphHandler.prototype.guidesEnabled = true;// 允许对齐线
	_editor.graph.setCellsDisconnectable(false);// 允许新的连接，但不允许现有的连接被改变成简化的
	_editor.graph.resizeContainer = true;//允许改变容器大小
//	mxSwimlane.prototype.imageSize = 23;
	
	//禁止组件区域双击时选中文字
	$('#toolbar_base').get(0).onselectstart=function(){return false;}
	//禁止组件区域双击时选中文字
	$('#toolbar_senior').get(0).onselectstart=function(){return false;}
	
	$("#mxToolbar").accordion("select", 0);
	//toolbar_base
	var baseToolbar = new mxDefaultToolbar($('#toolbar_base').get(0), _editor);
	baseToolbar.addMode("connect", "static/js/platform/esb/images/48/flow_sequence.png", "connect");
	baseToolbar.addPrototype("HTTP", "static/js/platform/esb/images/48/http.png", _editor.templates["http"].clone());
	baseToolbar.addPrototype("FILE", "static/js/platform/esb/images/48/file_cell.png", _editor.templates["file"].clone());
	baseToolbar.addPrototype("FTP", "static/js/platform/esb/images/48/ftp_cell.png", _editor.templates["ftp"].clone());
	baseToolbar.addPrototype("SFTP", "static/js/platform/esb/images/48/sftp.png", _editor.templates["sftp"].clone());
	baseToolbar.addPrototype("SMTP", "static/js/platform/esb/images/48/smtp_cell.png", _editor.templates["smtp"].clone());
	baseToolbar.addPrototype("TCP", "static/js/platform/esb/images/48/tcp.png", _editor.templates["tcp"].clone());
	baseToolbar.addPrototype("DATABASE", "static/js/platform/esb/images/48/database.png", _editor.templates["database"].clone());
	baseToolbar.addPrototype("LOGGER", "static/js/platform/esb/images/48/logger.png", _editor.templates["logger"].clone());
	baseToolbar.addPrototype("SET PAYLOAD", "static/js/platform/esb/images/48/setpayload.png", _editor.templates["setpayload"].clone());
	baseToolbar.addPrototype("OBJ2JSON", "static/js/platform/esb/images/48/obj2json.png", _editor.templates["obj2json"].clone());
	baseToolbar.addPrototype("OBJ2XML", "static/js/platform/esb/images/48/obj2xml.png", _editor.templates["obj2xml"].clone());
	//baseToolbar.addPrototype("XML2OBJ", "static/js/platform/esb/images/48/xml2obj.png", _editor.templates["xml2obj"].clone());
	//baseToolbar.addPrototype("JSON2OBJ", "static/js/platform/esb/images/48/json2obj.png", _editor.templates["json2obj"].clone());
	baseToolbar.addPrototype("JAVA TRANSFORMER", "static/js/platform/esb/images/48/custtrans.png", _editor.templates["custtrans"].clone());

	$("#mxToolbar").accordion("select", 1);
	//toolbar_senior
	var seniorToolbar = new mxDefaultToolbar($('#toolbar_senior').get(0), _editor);
	seniorToolbar.addMode("connect", "static/js/platform/esb/images/48/flow_sequence.png", "connect");
	seniorToolbar.addPrototype("VARIALBLE", "static/js/platform/esb/images/48/variable.png", _editor.templates["variable"].clone());
	seniorToolbar.addPrototype("FLOW REFERENCE", "static/js/platform/esb/images/48/flowref.png", _editor.templates["flowref"].clone());
	seniorToolbar.addPrototype("JAVA", "static/js/platform/esb/images/48/cust.png", _editor.templates["cust"].clone());
	seniorToolbar.addPrototype("CHOICE", "static/js/platform/esb/images/48/choice.png", _editor.templates["choice"].clone());
	//seniorToolbar.addPrototype("PARALLEL PROCESS", "static/js/platform/esb/images/48/scattergather.png", _editor.templates["scattergather"].clone());
	seniorToolbar.addPrototype("CATCH EXCEPTION", "static/js/platform/esb/images/48/exception.png", _editor.templates["exception"].clone());
	seniorToolbar.addPrototype("CHOICE EXCEPTION", "static/js/platform/esb/images/48/choiceexception.png", _editor.templates["choiceexception"].clone());
	
	$("#mxToolbar").accordion("select", 0);
	
	$('#toolbar_base').children().first().hide();
	$('#toolbar_senior').children().first().hide();
	// 为面板添加单击事件，包括点击空白和点击元素的处理
	_editor.graph.addListener(mxEvent.CLICK, function(sender, evt) {
		//获取焦点，监听键盘事件
		window.focus();
		// 因为添加事件后会执行点击事件，或者取消点击后等问题，所以延迟处理选中节点
		setTimeout(function() {
			myAction.showSelectedCell();
		}, 100);
	});
	// 添加cell后监听
	_editor.graph.addListener(mxEvent.CELLS_ADDED, function(sender, evt) {
		var cells = evt.getProperty('cells');
		myAction.addCells(cells);
	});
	// 删除cell监听
	_editor.graph.addListener(mxEvent.REMOVE_CELLS, function(sender, evt) {
		var cells = evt.getProperty('cells');
		myAction.removeCells(cells);
	});
	
	//键盘事件
	var keyHandler = new mxKeyHandler(_editor.graph);
	//删除 delete
	keyHandler.bindKey(46, function() {
		_editor.graph.removeCells();
	});
	//全选 alt+a
	keyHandler.bindControlKey(65, function() {
		_editor.graph.selectAll();
		myAction.showSelectedCell();
	});
	// 上下左右移动 上下左右键
	keyHandler.bindKey(38, function() {
		var cells = _editor.graph.getSelectionCells();
		if($.notNull(cells)){
			_editor.graph.moveCells(cells, 0, -1)
		}
	});
	keyHandler.bindKey(40, function() {
		var cells = _editor.graph.getSelectionCells();
		if($.notNull(cells)){
			_editor.graph.moveCells(cells, 0, 1)
		}
	});
	keyHandler.bindKey(37, function() {
		var cells = _editor.graph.getSelectionCells();
		if($.notNull(cells)){
			_editor.graph.moveCells(cells, -1, 0)
		}
	});
	keyHandler.bindKey(39, function() {
		var cells = _editor.graph.getSelectionCells();
		if($.notNull(cells)){
			_editor.graph.moveCells(cells, 1, 0)
		}
	});
	//上下左右对齐 shift+上下左右键
	keyHandler.bindShiftKey(38, function() {
		_editor.graph.alignCells("top");
	});
	keyHandler.bindShiftKey(40, function() {
		_editor.graph.alignCells("bottom");
	});
	keyHandler.bindShiftKey(37, function() {
		_editor.graph.alignCells("left");
	});
	keyHandler.bindShiftKey(39, function() {
		_editor.graph.alignCells("right");
	});
	//格式化 shift+F
	keyHandler.bindShiftKey(70, function() {
		myAction.formatGraph();
	});
	//设置间距，默认是50，_formatW shift+D
	keyHandler.bindShiftKey(68, function() {
		$.messager.prompt('设置格式化间距', '现数值是'+_formatW+',请输入新数值:', function(r) {
			if($.notNull(r)){
				if(!isNaN(r)){
					_formatW = Number(r);
					easyHelp.showMsg("设置成功！");
				}else{
					easyHelp.showMsg("无法转成数字，设置失败！");
				}
			}
		});
	});
	//选中组件文字时选中组件
	$(".mxToolbarModeDiv span").on("click", function(){
		$(this).prev().trigger("click");
	});
	$(".mxToolbarModeDiv").css("cursor", "pointer");
	
	//graph大小设置
	_editor.graph.minimumContainerSize = {width : $("#graph").parent().width() - 50, height : $("#graph").parent().height() - 50};
	_editor.graph.sizeDidChange();
	
	//执行初始化，默认选择空白
	_myCurCellId = _flowKey;
	var myFlow = new MyFlow(_flowKey);
	myFlow.init();
	_myCellMap.put(_flowKey, myFlow);
	myFlow.showProp();
	
	$.ajax({
		type : "POST",
		data : {
			id : _flowKey
		},
		url : _controlPath + "getEsbFlowById",
		dataType : "json",
		success : function(result) {
			easyHelp.showResultMsg(result, "", function(){
				//还原面板
				var doc = mxUtils.parseXml(result.graph);
				var codec = new mxCodec(doc);
				_editor.graph.getModel().beginUpdate();
				codec.decode(doc.documentElement, _editor.graph.getModel());
				_editor.graph.getModel().endUpdate();
				//还原属性域和_myCellMap
				var cells = _editor.graph.model.getChildren(_editor.graph.getDefaultParent());
				myAction.addCells(cells);
				//还原属性值
				var esbXml = mxUtils.parseXml(result.esbXml);
				$(esbXml).find("flow").children().each(function(){
					var id = $(this).attr("doc:description");
					_myCellMap.get(id).initLoad($(this));
				});
			});
		}
	});
});

/**
 * 方法
 */
function MyAction() {
};
/**
 * xml的xmlns
 */
MyAction.prototype.xmlns = new Map();
/**
 * xml的schemaLocation
 */
MyAction.prototype.schemaLocation = new Map();
/**
 * 显示graph文件
 */
MyAction.prototype.showGraph = function() {
	var enc = new mxCodec(mxUtils.createXmlDocument());
	var node = enc.encode(_editor.graph.getModel());
	return mxUtils.getPrettyXml(node);
};
/**
 * 返回esbXml文件
 */
MyAction.prototype.showEsbXml = function() {
	_required = false;
	$(".requiredInput").removeClass("requiredInput");
	if(!this.valid(_editor.graph.getDefaultParent(), _linkedList, "flow")){
		return null;
	}
	this.xmlns.clear();
	this.schemaLocation.clear();
	this.xmlns.put("xmlns", "http://www.mulesoft.org/schema/mule/core");
	this.xmlns.put("xmlns:doc", "http://www.mulesoft.org/schema/mule/documentation");
	this.xmlns.put("xmlns:spring", "http://www.springframework.org/schema/beans");
	this.xmlns.put("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
	this.xmlns.put("version", "EE-3.5.0");
	this.schemaLocation.put("flow", "http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-current.xsd http://www.mulesoft.org/schema/mule/core http://www.mulesoft.org/schema/mule/core/current/mule.xsd");
	var process = _myCellMap.get(_flowKey).getXmlDoc();
//	myAction.circle(_linkedList.head.getNext(), process);
	
	_linkedList.head.getNext().sort(function(a, b){
		var cellNode = _editor.graph.getModel().getCell(b);
		if(cellNode.tagName == "exception" || cellNode.tagName == "choiceexception"){
			return -1;
		}else{
			return 1;
		}
	});
	$.each(_linkedList.head.getNext(), function(i, id){
		var baseNode = _myCellMap.get(id);
		var node = baseNode.getXmlDoc();
		process.appendChild(node);
		myAction.circle(_linkedList.map.get(id).getNext(), process);
	});
	
	var mule = this.getMule();
	mule.appendChild(process);
	//如果存在有必填项没有填写，则会把_required置为true，
	if(_required){
		easyHelp.showMsg("带有*的输入框为必填项，请检查确认！");
		return null;
	}
	return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + ComUtils.getPrettyXml(mule);
};
/**
 * 递归，组装xml
 * @param list
 * @param parentXml
 */
MyAction.prototype.circle = function(list, parentXml) {
	$.each(list, function(i, id){
		var baseNode = _myCellMap.get(id);
		var node = baseNode.getXmlDoc();
		parentXml.appendChild(node);
		myAction.circle(_linkedList.map.get(id).getNext(), parentXml);
	});
};
/**
 * 组装根节点mule节点
 */
MyAction.prototype.getMule = function() {
	var muleXml = ComUtils.createElement("mule");
	var xmlnKeys = this.xmlns.keys();
	$.each(xmlnKeys, function(i, key){
		muleXml.setAttribute(key, myAction.xmlns.get(key));
	});
	var schemaStr = "";
	var schemaLocationArr = this.schemaLocation.values();
	$.each(schemaLocationArr, function(i, schema){
		schemaStr += schema + " ";
	});
	muleXml.setAttribute("xsi:schemaLocation", schemaStr);
	return muleXml;
};
/**
 * 验证连线是否符合要求
 * @param parentCell
 * @param linkedList
 * @param tagType
 * @returns {Boolean}
 */
MyAction.prototype.valid = function(parentCell, linkedList, tagType) {
	linkedList.clear();
	var cells = _editor.graph.model.getChildren(parentCell);
	if($.notNull(cells) && cells.length != 0){
		for(var i = 0; i < cells.length; i++){
			var cell = cells[i];
			if (cell.edge) {
				if (cell.source.parent.id != cell.target.parent.id) {
					easyHelp.showMsg("不同容器中的组件不能链接！");
					return false;
				}
				linkedList.add(cell.source.id, cell.target.id);
			}else if(cell.vertex){
				if(cell.edges == null || cell.edges.length == 0){
					linkedList.add("head", cell.id);
				}else if(cell.edges.length > 2){
					easyHelp.showMsg("连线不符合规范，无法解析");
					return false;
				}else if(cell.edges.length == 2){
					var edge1 = cell.edges[0];
					var edge2 = cell.edges[1];
					if(edge1.source.id == edge2.source.id || edge1.target.id == edge2.target.id){
						easyHelp.showMsg("连线不符合规范，无法解析");
						return false;
					}
				}
				if(myAction.isSwim(cell.tagName)){
					if(!myAction.valid(cell, _myCellMap.get(cell.id).linkedList, cell.tagName)){
						return false;
					}
				}
			}
		}
		if(tagType == "flow"){
			if(linkedList.head.getNext().length > 2 || linkedList.head.getNext().length == 0) {
				easyHelp.showMsg("连线不符合规范，无法解析");
				return false;
			}else if(linkedList.head.getNext().length == 2){
				var node1 = _editor.graph.getModel().getCell(linkedList.head.getNext()[0]);
				var node2 = _editor.graph.getModel().getCell(linkedList.head.getNext()[1]);
				if(node1.tagName != "exception" && node1.tagName != "choiceexception" && node2.tagName != "exception" && node2.tagName != "choiceexception"){
					easyHelp.showMsg("连线不符合规范，无法解析");
					return false;
				}
			}
		}else if(tagType == "exception"){
			if(linkedList.head.getNext().length != 1) {
				easyHelp.showMsg("连线不符合规范，无法解析");
				return false;
			}
		}
	}
	return true;
};
/**
 * 获取名称
 */
MyAction.prototype.getFlowName = function() {
	return _myCellMap.get(_flowKey).alias;
};
/**
 * 获取ID
 */
MyAction.prototype.getFlowId = function() {
	return _myCellMap.get(_flowKey).id;
};
/**
 * 添加元件事件
 * 
 * @param cells
 */
MyAction.prototype.addCells = function(cells) {
	var removeCells = [];
	if ($.notNull(cells)) {
		$.each(cells, function(i, cell){
			if (cell.edge) {
				if (cell.source.parent.id != cell.target.parent.id) {
					removeCells.push(cell);
					easyHelp.showMsg("不同容器中的组件不能链接！");
				}
			}else if(cell.vertex){//节点，而非连线
				if(cell.tagName == "exception" || cell.tagName == "choiceexception"){
					if(cell.parent.id == "1"){
						if(_isException == 1){
							removeCells.push(cell);
							easyHelp.showMsg("不能放置多个异常类！");
							return;
						}
					}
				}
				var allowTag = cell.parent.allowTag;
				var banTag = cell.parent.banTag;
				if($.notNull(allowTag)){
					if(allowTag.indexOf("," + cell.tagName + ",") == -1){
						removeCells.push(cell);
						easyHelp.showMsg("不允许放置！");
						return;
					}
				}
				if($.notNull(banTag)){
					if(banTag.indexOf("," + cell.tagName + ",") != -1){
						removeCells.push(cell);
						easyHelp.showMsg("不允许放置！");
						return;
					}
				}
				if(!_myCellMap.containsKey(cell.id)){
					var nodeBase = myAction.createBaseByTagName(cell.tagName, cell.id);
					if($.notNull(nodeBase)){
						nodeBase.parentId = cell.parent.id;
						nodeBase.init();
						_myCellMap.put(cell.id, nodeBase);
					}
				}
			}
		});
	}
	if(removeCells.length > 0){
		
		setTimeout(function() {
			_editor.undo();
		}, 100);
		
//		var flg = true;
//		for(var i = 0; i < removeCells.length; i++){
//			if(_myCellMap.containsKey(removeCells[i].id)){
//				flg = false;
//				break;
//			}
//		}
//		if(flg){
//			_editor.graph.removeCells(removeCells);
//		}else{
//			setTimeout(function() {
//				_editor.undo();
//			}, 100);
//		}
	}
};
/**
 * 删除元件事件
 * 
 * @param cells
 */
MyAction.prototype.removeCells = function(cells) {
	if ($.notNull(cells) && cells.length > 0) {
		$.each(cells, function(i, cell){
			if (_myCellMap.containsKey(cell.id)) {
				_myCellMap.get(cell.id).remove();
				_myCellMap.remove(cell.id);
			}
			if(myAction.isSwim(cell.tagName)){
				var childCell = _editor.graph.model.getChildren(cell);
				if($.notNull(childCell)){
					_editor.graph.removeCells(childCell);
				}
			}
		});
		if (_flowKey != _myCurCellId) {
			_myCurCellId = _flowKey;
			_myCellMap.get(_flowKey).showProp();
		}
	}
};
/**
 * 执行选中节点显示
 * 
 * @param cells
 */
MyAction.prototype.showSelectedCell = function(cells) {
	var cells = _editor.graph.getSelectionCells();
	var id;
	if ($.notNull(cells) && $.notNull(cells[0])
			&& _myCellMap.containsKey(cells[0].id)) {
		id = cells[0].id;
	} else {
		id = _flowKey;
	}
	if (id != _myCurCellId) {
		_myCurCellId = id;
		_myCellMap.get(id).showProp();
	}
};
/**
 * 创建元素对象
 * 
 * @returns
 */
MyAction.prototype.createBaseByTagName = function(tagName, id) {
	var baseNode = null;
	if (tagName == "http") {
		baseNode = new MyHttp(id);
	}else if(tagName == "logger"){
		baseNode = new MyLogger(id);
	}else if(tagName == "setpayload"){
		baseNode = new MySetpayload(id);
	}else if(tagName == "custtrans"){
		baseNode = new MyCusttrans(id);
	}else if(tagName == "obj2json"){
		baseNode = new MyObj2json(id);
	}else if(tagName == "obj2xml"){
		baseNode = new MyObj2xml(id);
	}else if(tagName == "xml2obj"){
		baseNode = new MyXml2obj(id);
	}else if(tagName == "json2obj"){
		baseNode = new MyJson2obj(id);
	}else if(tagName == "cust"){
		baseNode = new MyCust(id);
	}else if(tagName == "variable"){
		baseNode = new MyVariable(id);
	}else if(tagName == "file"){
		baseNode = new MyFile(id);
	}else if(tagName == "smtp"){
		baseNode = new MySmtp(id);
	}else if(tagName == "ftp"){
		baseNode = new MyFtp(id);
	}else if(tagName == "sftp"){
		baseNode = new MySftp(id);
	}else if(tagName == "tcp"){
		baseNode = new MyTcp(id);
	}else if(tagName == "database"){
		baseNode = new MyDatabase(id);
	}else if(tagName == "choice"){
		baseNode = new MyChoice(id);
	}else if(tagName == "flowref"){
		baseNode = new MyFlowref(id);
	}else if(tagName == "exception"){
		baseNode = new MyException(id);
	}else if(tagName == "choiceexception"){
		baseNode = new MyChoiceexception(id);
	}else if(tagName == "scattergather"){
		baseNode = new MyScattergather(id);
	}
	return baseNode;
};
/**
 * 判断是否是swimlane
 * @param tagName
 * @returns {Boolean}
 */
MyAction.prototype.isSwim = function(tagName) {
	if(tagName == "choice" || tagName == "exception" || tagName == "choiceexception" || tagName == "scattergather"){
		return true;
	}else{
		return false;
	}
};
/**
 * 格式化
 */
MyAction.prototype.formatGraph = function(){
	if(!this.valid(_editor.graph.getDefaultParent(), _linkedList, "flow")){
		return;
	}
	var _self = this;
	var top = 10;
	_linkedList.head.getNext().sort(function(a, b){
		var cellNode = _editor.graph.getModel().getCell(b);
		if(cellNode.tagName == "exception" || cellNode.tagName == "choiceexception"){
			return -1;
		}else{
			return 1;
		}
	});
	$.each(_linkedList.head.getNext(), function(i, id){
		var cellArr = [];
		_self.roundFormat([id], _formatW/2, cellArr);
		var height = 0;
		$.each(cellArr, function(j, cell){
			var cellHeight = Number(cell.getGeometry().height);
			if(height < cellHeight){
				height = cellHeight;
			}
		});
		var cellTop = top + (height - Number(cellArr[0].getGeometry().height))/2;
		_editor.graph.moveCells([cellArr[0]], 0, cellTop - Number(cellArr[0].getGeometry().y));
		_editor.graph.alignCells("middle", cellArr);
		top = top + 20 + height;
	});
};
MyAction.prototype.roundFormat = function(nextArr, left, cellArr){
	var _self = this;
	$.each(nextArr, function(i, id){
		var cellNode = _editor.graph.getModel().getCell(id);
		cellArr.push(cellNode);
		if(_self.isSwim(cellNode.tagName)){
			_myCellMap.get(id).formatGraph();
		}
		_editor.graph.moveCells([cellNode], left - Number(cellNode.getGeometry().x), 0);
		_self.roundFormat(_linkedList.map.get(id).getNext(), left + Number(cellNode.getGeometry().width) + _formatW, cellArr);
	});
};
var myAction = new MyAction();