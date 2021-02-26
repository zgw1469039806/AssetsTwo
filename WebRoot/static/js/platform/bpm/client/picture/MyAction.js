var _stop = false;
var _editor;// _editor
var _myAction;// 函数
var _myCellMap;// 对象Map
var _myLoadMap;// 加载时用到的变量，存放以name为key的元素对象
var _countUtils;// 自增长数值管理
var _toolTipMap;
var _lineArr = [];
var allEdges = [];
var _top = 0;
$(function(){
	
	if(mxClient.IS_IE){
		var butsTop = $("#buts").css("top");
		var graphTop = $("#graph").css("top");
		butsTop = butsTop.replace("px", "");
		graphTop = graphTop.replace("px", "");
		$("#buts").css("top", Number(butsTop) + 10);
		 _top = Number(graphTop) + 10;
		$("#graph").css("top",  _top);
	}else{
		var graphTop = $("#graph").css("top");
		graphTop = graphTop.replace("px", "");
		 _top = Number(graphTop);
	}
	// 函数
	_myAction = new MyAction();
	// 对象Map
	_myCellMap = new Map();
	//
	_toolTipMap = new Map();
	// map
	_myLoadMap = new Map();
	// 自增长数值管理
	_countUtils = new countUtils();
	// _editor
	_editor = new mxApplication(_picturePath + "config/myEditor.xml");
	mxEvent.disableContextMenu($("#graph").get(0));// 禁用右键菜单
	_editor.graph.allowDanglingEdges = false;// 禁止连线没有目标
	// _editor.graph.setCellsResizable(false);// 禁止改变元素大小
	_editor.graph.setAllowLoops(false);// 禁止连线的目标和源是同一元素
	_editor.graph.setMultigraph(false);// 禁止重复连接
	_editor.graph.htmlLabels = true;// isHtmlLabel
	mxGraphHandler.prototype.guidesEnabled = true;// 允许对齐线
	_editor.graph.setCellsDisconnectable(false);// 允许新的连接，但不允许现有的连接被改变成简化的
	_editor.graph.resizeContainer = true;// 允许改变容器大小
	_editor.graph.setEnabled(false);

	_editor.graph.setTooltips(true);
	_editor.graph.getTooltipForCell = function(cell) {
		if ($.notNull(cell.showTooltipName)) {
			var name = cell.showTooltipName;
			var tab = _toolTipMap.get(name);
			if ($.notNull(tab)) {
				return tab;
			}
			tab = "";
			$.ajax({
				type : "POST",
				data : {
					processInstanceId : processInstanceId,
					activityName : name
				},
				url : "platform/bpm/clientbpmdisplayaction/gettracktip",
				dataType : "json",
				async : false,
				success : function(obj) {
					var tracks = obj.tracks;
					var histActivity = obj.histActivity;

					if (histActivity != null) {
						var currentActiveLabel = histActivity.alias;
						var consumeTime = histActivity.consumeTime;
						var iTime = histActivity.sTime;
						var eTime = histActivity.eTime;
						tab += "<table style='margin:3px 3px 3px 3px;' width='400px'>";
						tab += "<tr>";
						tab += "<td width=50%><font color=blue>节点：" + replaceNull2Space(currentActiveLabel) + "</font></td>";
						tab += "<td width=50%><font color=blue>耗时：" + replaceNull2Space(consumeTime) + "</font></td>";
						tab += "</tr>";
						tab += "<tr>";
						tab += "<td width=50%><font color=blue>开始：" + replaceNull2Space(iTime) + "</font></td>";
						tab += "<td width=50%><font color=blue>结束：" + replaceNull2Space(eTime) + "</font></td>";
						tab += "</tr>";
						tab += "</table>";

						if (histActivity.type != null && histActivity.type != 'start') {
							tab += "<table style='border-collapse:collapse;margin:3px 3px 3px 3px;' cellpadding=3 cellspacing=3 border=1 width='400px'>";
							tab += "<tr><th width='50px'>接收人</th><th width='50px'>处理人</th><th width='165px'>意见</th><th width='125px'>时间</th></tr>";
							for ( var t in tracks) {
								var track = tracks[t];
								if (replaceNull2Space(track.assigneeName) == '') {
									continue;
								}
								tab += "<tr><td width='40px'>" + replaceNull2Space(track.assigneeName) + "</td><td width='40px'>" + replaceNull2Space(track.operateUserName) + "</td><td width='160px'>" + replaceNull2Space(track.message) + "</td><td width='80px'>" + replaceNull2Space(track.eTime) + "</td></tr>";
								if (t > 1) {
									tab += "<tr><td>......</td><td>......</td><td>......</td><td>......</td></tr>";
									break;
								}
							}
						}
						tab += "</table>";
					}
				}
			});
			_toolTipMap.put(name, tab);
			return tab;
		} else {
			return "";
		}
	}

	$.ajax({
		type : "POST",
		data : {
			processInstanceId : _processInstanceId
		},
		url : "platform/bpm/clientbpmdisplayaction/getProcessXml",
		dataType : "json",
		success : function(result) {
			if ($.notNull(result.processXml)) {
				var xml = mxUtils.parseXml(result.processXml);
				var xmlvalue = _myAction.converToGraphXml(xml);
				var doc = mxUtils.parseXml(xmlvalue);
				var codec = new mxCodec(doc);
				_editor.graph.getModel().beginUpdate();
				codec.decode(doc.documentElement, _editor.graph.getModel());
				_editor.graph.getModel().endUpdate();
				ajaxRequest("POST", "processInstanceId=" + processInstanceId, "platform/bpm/clientbpmdisplayaction/getgraphcoordinate", "json", "draw");
			}
		}
	});
	
	$("#playBut").on("click", function(){
		_stop = false;
		_editor.graph.setCellStyles("strokeColor", "gray", allEdges);
		_myAction.linemove(0);
	});
	$("#stopBut").on("click", function(){
		_stop = true;
		$("#mi").stop(true, true);
		$("#bo").stop(true, true);
	});
})

function draw(obj) {
	var currentArray = obj.redsquare;
	if (currentArray != null && currentArray.length > 0) {
		for ( var current in currentArray) {
			var xywh = currentArray[current];
			var array = xywh.split(",");
			var name = array[4];
			var cell = _myLoadMap.get(name).getCell();
			cell.showTooltipName = name;
			_editor.graph.setCellStyles("imageBorder", "red", [ cell ]);
		}
	}

	var histArray = obj.greensign;
	if (histArray != null && histArray.length > 0) {
		for ( var hist in histArray) {
			var xywh = histArray[hist];
			var array = xywh.split(",");
			var name = array[4];
			var cell = _myLoadMap.get(name).getCell();
			cell.showTooltipName = name;
			var id = _countUtils.getSelfId();
			var vertex = _editor.graph.createVertex(_editor.graph.getDefaultParent(), id, "", cell.getGeometry().x + 20, cell.getGeometry().y + 17, 16, 16, "image;image=static/js/platform/bpm/client/picture/images/tick.png;");
			_editor.graph.addCell(vertex, _editor.graph.getDefaultParent());
			vertex.showTooltipName = name;
		}
	}

	var lineArray = obj.redline;
	if (lineArray != null && lineArray.length > 0) {
		for ( var line in lineArray) {
			var xywh = lineArray[line];
			var array = xywh.split(",");
			var start = array[4];
			var end = array[5];
			if ($.notNull(start, end)) {
				var myLineArr = new MyLineArr();
				var startNode = _myLoadMap.get(start);
				var startCell = startNode.getCell();
				var endCell = _myLoadMap.get(end).getCell();
				myLineArr.startCell = startCell;
				myLineArr.endCell = endCell;
				var edgeArr = _editor.graph.getEdgesBetween(startCell, endCell, true);
				if (edgeArr.length > 0) {
					allEdges = allEdges.concat(edgeArr);
					myLineArr.addLines(edgeArr);
				} else if (startNode.hasForkJoin()) {
					var forkJoinId = startNode.forkJoinArr[0];
					var forkJoinCell = _myCellMap.get(forkJoinId).getCell();
					edgeArr = _editor.graph.getEdgesBetween(forkJoinCell, endCell, true);
					if (edgeArr.length > 0) {
						allEdges = allEdges.concat(edgeArr);
						myLineArr.addLines(edgeArr);
						edgeArr = _editor.graph.getEdgesBetween(startCell, forkJoinCell, true);
						allEdges = allEdges.concat(edgeArr);
						myLineArr.addLines(edgeArr);
					} else {
						var jumpLine = _myAction.addLine(startCell, endCell);
						allEdges.push(jumpLine);
						myLineArr.addLines([ jumpLine ]);
					}
				} else {
					var jumpLine = _myAction.addLine(startCell, endCell);
					allEdges.push(jumpLine);
					myLineArr.addLines([ jumpLine ]);
				}
				_lineArr.push(myLineArr);
			}
		}
		_editor.graph.setCellStyles("strokeColor", "red", allEdges);
		_editor.graph.removeCells(allEdges);
		_editor.graph.addCells(allEdges, _editor.graph.getDefaultParent());
	}
}

/**
 * 函数
 */
function MyAction() {
};

/**
 * 创建元素对象
 * 
 * @returns
 */
MyAction.prototype.createBaseByTagName = function(tagName, id, vertex, edge) {
	var baseNode = null;
	if (vertex) {
		if (tagName == "start") {
			baseNode = new MyStart(id);
		} else if (tagName == "end") {
			baseNode = new MyEnd(id);
		} else if (tagName == "task") {
			baseNode = new MyTask(id);
		} else if (tagName == "java") {
			baseNode = new MyJava(id);
		} else if (tagName == "sql") {
			baseNode = new MySql(id);
		} else if (tagName == "ws") {
			baseNode = new MyWs(id);
		} else if (tagName == "state") {
			baseNode = new MyState(id);
		} else if (tagName == "fork") {
			baseNode = new MyFork(id);
		} else if (tagName == "join") {
			baseNode = new MyJoin(id);
		} else if (tagName == "decision") {
			baseNode = new MyExclusive(id);
		} else if (tagName == "sub-process") {
			baseNode = new MySubprocess(id);
		} else if (tagName == "foreach") {
			baseNode = new MyForeach(id);
		} else if (tagName == "jms") {
			baseNode = new MyJms(id);
		} else if (tagName == "custom") {
			baseNode = new MyCustom(id);
		} else if (tagName == "text") {
			baseNode = new MyText(id);
		}
	} else if (edge) {
		baseNode = new MyTransition(id);
	}
	return baseNode;
};
/**
 * 循环各个元素进行转换
 */
MyAction.prototype.cycleTags = function(tagName, process, rootXml, transitionArr) {
	var tags = process.getElementsByTagName(tagName);
	for (var i = 0; i < tags.length; i++) {
		var tagId = _countUtils.getSelfId();
		var tagNode = _myAction.createBaseByTagName(tagName, tagId, 1, 0);
		tagNode.initLoad(tags[i], rootXml);
		_myCellMap.put(tagId, tagNode);
		var transitions = tags[i].getElementsByTagName("transition");
		for (var j = 0; j < transitions.length; j++) {
			var transitionObject = {};
			transitionObject.xml = transitions[j];
			transitionObject.sourceId = tagId;
			transitionArr.push(transitionObject);
		}
	}
};
/**
 * 循环各个元素进行转换
 */
MyAction.prototype.converToGraphXml = function(data) {
	// process
	var process = data.getElementsByTagName("process")[0];
	
	var graphXml = ComUtils.createElement("mxGraphModel");
	var rootXml = ComUtils.createElement("root");
	var mxCell0 = ComUtils.createElement("mxCell");
	mxCell0.setAttribute("id", "0");
	rootXml.appendChild(mxCell0);
	var mxCell1 = ComUtils.createElement("mxCell");
	mxCell1.setAttribute("id", "1");
	mxCell1.setAttribute("parent", "0");
	rootXml.appendChild(mxCell1);

	var transitionArr = new Array();// 先循环节点，连线只是存储，最后再执行连线初始化，因为连线需要寻找target，即目标节点
	_myAction.cycleTags("start", process, rootXml, transitionArr);
	_myAction.cycleTags("end", process, rootXml, transitionArr);
	_myAction.cycleTags("task", process, rootXml, transitionArr);
	_myAction.cycleTags("java", process, rootXml, transitionArr);
	_myAction.cycleTags("sql", process, rootXml, transitionArr);
	_myAction.cycleTags("ws", process, rootXml, transitionArr);
	_myAction.cycleTags("state", process, rootXml, transitionArr);
	_myAction.cycleTags("fork", process, rootXml, transitionArr);
	_myAction.cycleTags("join", process, rootXml, transitionArr);
	_myAction.cycleTags("decision", process, rootXml, transitionArr);
	_myAction.cycleTags("sub-process", process, rootXml, transitionArr);
	_myAction.cycleTags("foreach", process, rootXml, transitionArr);
	_myAction.cycleTags("jms", process, rootXml, transitionArr);
	_myAction.cycleTags("custom", process, rootXml, transitionArr);
	_myAction.cycleTags("text", process, rootXml, transitionArr);
	for (var i = 0; i < transitionArr.length; i++) {
		var transitionId = _countUtils.getSelfId();
		var transitionNode = new MyTransition(transitionId);
		transitionNode.initLoad(transitionArr[i].xml, rootXml, transitionArr[i].sourceId);
		_myCellMap.put(transitionId, transitionNode);
	}

	graphXml.appendChild(rootXml);
	return mxUtils.getPrettyXml(graphXml);
};
MyAction.prototype.getPoint = function(start, end){
	var x1 = start.getGeometry().x;
	var y1 = start.getGeometry().y;
	
	var x2 = end.getGeometry().x;
	var y2 = end.getGeometry().y;
	
	x1 = x1 + 27.5;
	y1 = y1 + 25;
	
	x2 = x2 + 27.5;
	y2 = y2 + 25;
	
	var x, y;
	if(Math.abs(y1 - y2) < 60){
		x = x2 > x1 ? x2 - Math.abs(x1 - x2)/2 : x2 + Math.abs(x1 - x2)/2;
		if(y1 < y2){
			y = y1 - 45;
		}else{
			y = y2 - 45;
		}
	}else{
		y = y2 > y1 ? y2 - Math.abs(y1 - y2)/2 : y2 + Math.abs(y1 - y2)/2;
		if(x1 > x2){
			x = x1 + 45;
		}else{
			x = x2 + 45;
		}
	}
	var pt = mxUtils.convertPoint(_editor.graph.container, x, y + _top);
	return pt;
};

MyAction.prototype.addLine = function(startCell, endCell){
	var id = _countUtils.getSelfId();
	_editor.graph.insertEdge(_editor.graph.getDefaultParent(), id, "", startCell, endCell, "");
	var jumpLine = _editor.graph.getModel().getCell(id);
	var state = _editor.graph.view.getState(jumpLine);
	var handler = _editor.graph.createHandler(state);
	
	var geo = _editor.graph.getCellGeometry(state.cell);
	if (geo != null){
		geo = geo.clone();
		var pt = _myAction.getPoint(startCell, endCell);
		var index = mxUtils.findNearestSegment(state, pt.x, pt.y);
		handler.convertPoint(pt, true);
		if (geo.points == null){
			geo.points = [pt];
		}else{
			geo.points.splice(index, 0, pt);
		}
		handler.graph.getModel().setGeometry(state.cell, geo);
		handler.destroy();
	}
	return jumpLine;
};
MyAction.prototype.linemove = function(index){
	if(index < _lineArr.length && !_stop){
		var myLine = _lineArr[index];
		myLine.getPoints();
		_myAction.flowLine(myLine, 0, function(){
			_editor.graph.setCellStyles("strokeColor", "red", myLine.lines);
			$("#bo").css("left", myLine.endCell.getGeometry().x - 5);
			$("#bo").css("top", myLine.endCell.getGeometry().y - 5);
			$("#bo").css("width", 65);
			$("#bo").css("height", 60);
			$("#bo").show();
			$("#bo").animate({left:myLine.endCell.getGeometry().x, top:myLine.endCell.getGeometry().y, width: 55, height: 50}, 1000, null, function(){
				$("#bo").hide();
				_myAction.linemove(index + 1);
			});
		});
	}else{
		_editor.graph.setCellStyles("strokeColor", "red", allEdges);
	}
};

MyAction.prototype.flowLine = function(myLine, index, fun){
	if(index < myLine.points.length && !_stop){
		var point = myLine.points[index];
		if(index == 0){
			$("#mi").css("left", point.x - 4);
			$("#mi").css("top", point.y - 4);
			$("#mi").show();
			_myAction.flowLine(myLine, index + 1, fun);
		}else{
			$("#mi").animate({left:point.x - 4, top:point.y - 4}, 1000, null, function(){
				_myAction.flowLine(myLine, index + 1, fun);
			});
		}
	}else{
		$("#mi").hide();
		fun.call(this);
	}
};

/**
 * MyLineArr
 * @returns
 */
function MyLineArr() {
};
MyLineArr.prototype.startCell = null;
MyLineArr.prototype.endCell = null;
MyLineArr.prototype.lines = [];
MyLineArr.prototype.points = [];
MyLineArr.prototype.addLines = function(lineArr){
	this.lines = lineArr.concat(this.lines);
};
MyLineArr.prototype.getPoints = function(){
	this.points = [];
	var points = [];
	for(var i = 0; i < this.lines.length; i++){
		var jumpLine = this.lines[i];
		var state = _editor.graph.view.getState(jumpLine);
		var handler = _editor.graph.createHandler(state);
		var arr = handler.abspoints;
		handler.destroy();
		points = points.concat(arr);
	}
	var x = -1;
	var y = -1;
	var flgX = false;
	var flgY = false;
	for(var i = 0; i < points.length; i++){
		var point = points[i];
		if(point.x == x && point.y == y){
			continue;
		}
		if((flgX && point.x == x) || (flgY && point.y == y)){
			this.points.splice(this.points.length - 1, 1);
		}
		if(point.x == x){
			flgX = true;
		}else{
			flgX = false;
		}
		if(point.y == y){
			flgY = true;
		}else{
			flgY = false;
		}
		x = point.x;
		y = point.y;
		this.points.push(point);
	}
};