/**
 * 编辑器
 */
function MyDesignerEditor() {
	DesignerEditor.call(this);
};
MyDesignerEditor.prototype = new DesignerEditor();
MyDesignerEditor.prototype.lineArr = [];
MyDesignerEditor.prototype.allEdges = [];
MyDesignerEditor.prototype.toolTipMap = null;
MyDesignerEditor.prototype.userTextMap = null;
MyDesignerEditor.prototype.picJsp = "avicit/platform6/bpmreform/bpmdesigner/picture/picAndTracks.jsp";
MyDesignerEditor.prototype.init = function(entryId, deploymentId, type) {
	var _self = this;
	this.useNewDesigner = false;
	this.swimlane1 = 0;
	this.swimlane2 = 0;
	this.myCellMap = new Map();
	this.myLoadMap = new Map();
	this.countUtils = new CountUtils();
	this.toolTipMap = new Map();
	this.userTextMap = new Map();
	this.allEdges = [];
	this.type = type;
	if (flowUtils.notNull(entryId)) {
		this.entryId = entryId;
		$.ajax({
			type : "POST",
			data : {
				processInstanceId : entryId
			},
			url : "platform/bpm/clientbpmdisplayaction/getProcessXml",
			dataType : "json",
			success : function(result) {
				if (flowUtils.notNull(result.processXml)) {
					//是否启用了表单复制功能
					_self.autocopyformdata = result.autocopyformdata;
					result.processXml = result.processXml.replaceAll("avicit/platform6/bpmreform/bpmdesigner/editors/images/48/","avicit/platform6/bpmreform/bpmdesigner/editors/images/48/norun/");
					result.processXml = result.processXml.replaceAll("avicit/platform6/bpmreform/bpmdesigner/editors/images/node/","avicit/platform6/bpmreform/bpmdesigner/editors/images/node/norun/");
					var xml = mxUtils.parseXml(result.processXml);
					var xmlvalue = _self.converToGraphXml(xml);
					_self.editor.readGraphModel(xmlvalue);
                    //_self.moveToLeftTop();
					_self.drawInfo(result.isShowInfo);
                    _self.drawSubpprocessModelPic();
					_self.draw(result, entryId);
					// 跳转、补发、拿回等动作
					if (flowUtils.notNull(_self.type)) {
						$.ajax({
							type : "POST",
							data : {
								processInstanceId : entryId
							},
							url : "platform/bpm/clientbpmdisplayaction/getcoordinate",
							dataType : "json",
							success : function(result) {
								if (flowUtils.notNull(result, result.activity)) {
									_self.drawAct(result.activity, entryId);
								}
							}
						});
					}
				}
			}
		});
		this.editor.graph.setTooltips(true);
		this.editor.graph.getTooltipForCell = function(cell) {
			if(_self.isShowInfo == "true"){
				return "";
			}
			if (flowUtils.notNull(cell.showTooltipName)) {
				var name = cell.showTooltipName;
				var flg = _self.toolTipMap.get(name);
				if (flowUtils.notNull(flg)) {
					return "";
				}
				//
				$.ajax({
					type : "POST",
					data : {
						processInstanceId : entryId,
						activityName : name
					},
					url : "platform/bpm/clientbpmdisplayaction/gettracktip",
					dataType : "json",
					success : function(obj) {
						var tab = "";
						var tracks = obj.tracks;
						var histActivity = obj.histActivity;

						if (histActivity != null) {
							var currentActiveLabel = histActivity.alias;
							var consumeTime = histActivity.consumeTime;
							var iTime = histActivity.sTime;
							var eTime = histActivity.eTime;
							tab += "<table style='margin:3px 3px 3px 3px;' width='500px'>";
							tab += "<tr>";
							tab += "<td width=50%><font color=blue>节点：" + $.trim(currentActiveLabel) + "</font></td>";
							tab += "<td width=50%><font color=blue>耗时：" + $.trim(consumeTime) + "</font></td>";
							tab += "</tr>";
							tab += "<tr>";
							tab += "<td width=50%><font color=blue>开始：" + $.trim(iTime) + "</font></td>";
							tab += "<td width=50%><font color=blue>结束：" + $.trim(eTime) + "</font></td>";
							tab += "</tr>";
							tab += "</table>";

							if (histActivity.type != null && histActivity.type != 'start') {
								tab += "<table style='border-collapse:collapse;margin:3px 3px 3px 3px;' cellpadding=3 cellspacing=3 border=1 width='500px'>";
								tab += "<tr><th width='80px'>接收人</th><th width='80px'>处理人</th><th width='80px'>操作类型</th><th width='165px'>意见</th><th width='165px'>时间</th></tr>";
								for ( var t in tracks) {
									if (t > 5) {
										tab += "<tr><td>......</td><td>......</td><td>......</td><td>......</td><td>......</td></tr>";
										break;
									}
									var track = tracks[t];
									if ($.trim(track.assigneeName) == '') {
										continue;
									}
									tab += "<tr><td>" + $.trim(track.assigneeName) + "</td><td>" + $.trim(track.operateUserName) + "</td><td>" + $.trim(track.opType) + "</td><td>" + $.trim(track.message) + "</td><td>" + $.trim(track.eTime) + "</td></tr>";
								}
							}
							tab += "</table>";
						}

						var $src = $(_self.editor.graph.view.getState(cell).shape.node);
						$src.popover({
							html : true,
							container : 'body',
							template : '<div class="popover" role="tooltip" style="max-width:2000px;"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>',
							content : tab
						});
						$src.hover(function(){
							$src.popover('show');
						}, function(){
							$(".popover").hide();
						});
						$src.popover('show');
						_self.toolTipMap.put(name, "true");
					}
				});
			} else {
				return "";
			}
		};
	} else if (flowUtils.notNull(deploymentId)) {
		$.ajax({
			type : "POST",
			data : {
				deploymentId : deploymentId
			},
			url : "platform/bpm/clientbpmdisplayaction/getProcessXmlByDefineId",
			dataType : "json",
			success : function(result) {
				if (flowUtils.notNull(result.processXml)) {
					var xml = mxUtils.parseXml(result.processXml);
					var xmlvalue = _self.converToGraphXml(xml);
					_self.editor.readGraphModel(xmlvalue);
                    //_self.moveToLeftTop();
					_self.drawInfo(result.isShowInfo);
                    _self.drawSubpprocessModelPic();
				}
			}
		});
		this.editor.graph.setTooltips(false);
		this.editor.graph.getTooltipForCell = function(cell) {
		};
	}
};
MyDesignerEditor.prototype.moveToLeftTop = function() {
    var cells = this.editor.graph.getChildCells(null, true, false);
    if(cells != null){
        var x = 1000;
        var y = 1000;

        for (var i = 0; i < cells.length; i++){
			var cell_x = cells[i].getGeometry().x;
            var cell_y = cells[i].getGeometry().y;
            if(cell_x < x){
            	x = cell_x;
			}
			if(cell_y < y){
            	y = cell_y;
			}
        }

        this.editor.graph.moveCells(cells, 5-x, 5-y);
	}
};
MyDesignerEditor.prototype.cycleTags = function(tagName, process, rootXml, transitionArr) {
	var tags = process.getElementsByTagName(tagName);
	for (var i = 0; i < tags.length; i++) {
        if(tagName == "text" && !flowUtils.notNull(tags[i].getAttribute("id"))){
            continue;
        }
		var tagId = this.countUtils.getSelfId();
		if (this.useNewDesigner) {
			tagId = tags[i].getAttribute("id");
			this.countUtils.setSelfId(Number(tagId));
		}
		var tagNode = this.createBaseByTagName(tagName, tagId, 1, 0);
		tagNode.initTracks(tags[i], rootXml);
		this.myCellMap.put(tagId, tagNode);
		var transitions = tags[i].getElementsByTagName("transition");
		for (var j = 0; j < transitions.length; j++) {
			var transitionObject = {};
			transitionObject.xml = transitions[j];
			transitionObject.sourceId = tagId;
			transitionArr.push(transitionObject);
		}
	}
};

MyDesignerEditor.prototype.converToGraphXml = function(data) {
	// process
	var process = data.getElementsByTagName("process")[0];
	this.useNewDesigner = "true" == process.getAttribute("useNewDesigner") ? true : false;

	var graphXml = flowUtils.createElement("mxGraphModel");
	var rootXml = flowUtils.createElement("root");
	var workflowXml = flowUtils.createElement("Workflow");
	workflowXml.setAttribute("id", "0");
	var mxCell0 = flowUtils.createElement("mxCell");
	workflowXml.appendChild(mxCell0);
	var layerXml = flowUtils.createElement("Layer");
	layerXml.setAttribute("id", "1");
	var mxCell1 = flowUtils.createElement("mxCell");
	mxCell1.setAttribute("parent", "0");
	layerXml.appendChild(mxCell1);
	rootXml.appendChild(workflowXml);
	rootXml.appendChild(layerXml);

	var transitionArr = new Array();// 先循环节点，连线只是存储，最后再执行连线初始化，因为连线需要寻找target，即目标节点
	this.cycleTags("swimlane", process, rootXml, transitionArr);
	this.cycleTags("start", process, rootXml, transitionArr);
	this.cycleTags("end", process, rootXml, transitionArr);
	this.cycleTags("task", process, rootXml, transitionArr);
	this.cycleTags("java", process, rootXml, transitionArr);
	this.cycleTags("sql", process, rootXml, transitionArr);
	this.cycleTags("ws", process, rootXml, transitionArr);
	this.cycleTags("state", process, rootXml, transitionArr);
	this.cycleTags("fork", process, rootXml, transitionArr);
	this.cycleTags("join", process, rootXml, transitionArr);
	this.cycleTags("decision", process, rootXml, transitionArr);
	this.cycleTags("sub-process", process, rootXml, transitionArr);
	this.cycleTags("foreach", process, rootXml, transitionArr);
	this.cycleTags("jms", process, rootXml, transitionArr);
	this.cycleTags("custom", process, rootXml, transitionArr);
	this.cycleTags("rules", process, rootXml, transitionArr);
    this.cycleTags("rest", process, rootXml, transitionArr);
	this.cycleTags("text", process, rootXml, transitionArr);
	for (var i = 0; i < transitionArr.length; i++) {
		var transitionId = this.countUtils.getSelfId();
		if (this.useNewDesigner) {
			transitionId = transitionArr[i].xml.getAttribute("_id");
			this.countUtils.setSelfId(Number(transitionId));
		}
		var transitionNode = new MyTransition(this, transitionId);
		transitionNode.initTracks(transitionArr[i].xml, rootXml, transitionArr[i].sourceId);
		this.myCellMap.put(transitionId, transitionNode);
	}

	graphXml.appendChild(rootXml);
	return graphXml;
};
//节点旁边显示候选规则
MyDesignerEditor.prototype.drawInfo = function(isShowInfo){
	var _self = this;
	_self.isShowInfo = isShowInfo;
	if(isShowInfo == "true"){
		var values = this.myCellMap.values();
		$.each(values, function(i, n){
			if(n.tagName == "task"){
				var userText =  n.setUserSelectDomText;
				if(flowUtils.notNull(userText)){
					_self.drawUserText(n.getCell(), userText, "");
				}
			}
		});
	}
};
MyDesignerEditor.prototype.drawUserText = function(cell, text, time){
//	if(text.length > 5){
//		text = text.substring(0,5);
//	}
//	var textCell = this.userTextMap.get(cell.id);
//	if(textCell == null){
//		var textTemplate = this.editor.templates["text"];
//		textCell = this.editor.graph.cloneCells([ textTemplate ])[0];
//		this.editor.addVertex(null, textCell, cell.getParent().getGeometry().x + cell.getGeometry().x + 10, cell.getParent().getGeometry().y + cell.getGeometry().y);
//		this.editor.graph.labelChanged(textCell, text);
//		this.editor.graph.removeSelectionCell(textCell);
//		this.userTextMap.put(cell.id, textCell);
//	}else{
//		this.editor.graph.labelChanged(textCell, text);
//	}
	var htmlText = "<span id='" + cell.id + "_text'><span class='p1'>" + text + "</span><span class='p1'>" + this.myCellMap.get(cell.id).alias + "</span><span class='p1'>" + time + "</span></span>";
	this.editor.graph.labelChanged(cell, htmlText);
	var tab = "<span>" + text + "</span><br/><span>" + this.myCellMap.get(cell.id).alias + "</span><br/><span>" + time + "</span>";
	$("#" + cell.id + "_text").popover({
		html : true,
		trigger : 'hover',
		container : 'body',
		template : '<div class="popover" role="tooltip" style="max-width:2000px;"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>',
		content : tab
	});
};

MyDesignerEditor.prototype.drawSubpprocessModelPic = function(){
    var _values = this.myCellMap.values();
    $.each(_values, function(i, n){
        if(n.tagName == "sub-process"){
            n.actNodeClick = function () {
                var dialog = layer.open({
                    type : 2,
                    title: "子流程：" + n.alias,
                    area : [ "800px", "450px" ],
                    content : "avicit/platform6/bpmreform/bpmdesigner/picture/pic.jsp?deploymentId=" + n.deploymentId
                });
                layer.full(dialog);
            };
        }
    });
};

MyDesignerEditor.prototype.draw = function(obj, entryId) {
	var _self = this;
	var subprocess = obj.subprocess;
	var userInfo = obj.userInfo;
	var currentArray = obj.redsquare;
	if (currentArray != null && currentArray.length > 0) {
		$.each(currentArray, function(i, xywh){
			var array = xywh.split(",");
			var name = array[4];
			var node = _self.myLoadMap.get(name);
			node.isCurrent = "true";
			var cell = node.getCell();
			cell.showTooltipName = name;
			if(_iconType == "1"){
				//新图元
				var newStyle = _self.editor.graph.model.getStyle(cell).replace('/new/','/new_run/');
				var list = eval("subprocess."+name);
				if(flowUtils.notNull(list)){
					newStyle = newStyle.replace('/task_human.png','/task_human_sub.png');
				}
				_self.editor.graph.model.setStyle(cell, newStyle);
			}else{
				if(node.tagName=='task'){
					var newStyle;
					var list = eval("subprocess."+name);
					if(flowUtils.notNull(list)){
						newStyle = _self.editor.graph.model.getStyle(cell).replace('/48/norun/task_human.png','/48/run/task_human_sub.gif');
					}else{
						newStyle = _self.editor.graph.model.getStyle(cell).replace('/48/norun/task_human.png','/48/run/task_human.gif');
					}
					newStyle = newStyle.replace('/node/norun/employee02.png','/node/run/employee02.gif');
					newStyle = newStyle.replace('/node/norun/leader01.png','/node/run/leader01.gif');
					newStyle = newStyle.replace('/node/norun/leader02.png','/node/run/leader02.gif');
					_self.editor.graph.model.setStyle(cell, newStyle);
				}else if(node.tagName=='state'){
					var newStyle = _self.editor.graph.model.getStyle(cell).replace('/48/norun/task_wait.png','/48/run/task_wait.gif');
					_self.editor.graph.model.setStyle(cell, newStyle);
				}else if(node.tagName == "sub-process"){
					var newStyle = _self.editor.graph.model.getStyle(cell).replace('/48/norun/task_subprocess.png','/48/run/task_subprocess.gif');
					_self.editor.graph.model.setStyle(cell, newStyle);
				}
				//_self.editor.graph.setCellStyles("imageBorder", "red", [ cell ]);
			}
//			if(name.indexOf("Subprocess") != -1){
//				node.actNodeClick = function() {
//					$.ajax({
//						type : "POST",
//						data : {
//							entryId : entryId,
//							subprocess : name
//						},
//						url : "platform/bpm/business/getSubprocess",
//						dataType : "text",
//						success : function(result) {
//							if(flowUtils.notNull(result)){
//								var dialog = layer.open({
//									type : 2,
//									title: "子流程",
//									area : [ "800px", "450px" ],
//									content : "avicit/platform6/bpmreform/bpmdesigner/picture/picAndTracks.jsp?entryId=" + result
//								});
//								layer.full(dialog);
//							}else{
//								flowUtils.warning("数据错误！");
//							}
//						}
//					});
//				};
//			}

			//启用了表单复制功能
			if(_self.autocopyformdata == "true"){

			}else {
				var _list = eval("subprocess."+name);
				if(flowUtils.notNull(_list)){
					node.actNodeClick = function() {
						var list = eval("subprocess."+name);
						_self.clickNode(list);
					};
				}
			}
			//节点旁边显示处理人
			if(flowUtils.notNull(userInfo)){
				var userText = eval("userInfo." + node.name);
				var reasonableFinishTime = eval("userInfo." + node.name + "_reasonableFinishTime");
				if(flowUtils.notNull(userText)){
					_self.drawUserText(cell, userText, reasonableFinishTime);
				}
			}
		});
	}

	var histArray = obj.greensign;
	if (histArray != null && histArray.length > 0) {
		$.each(histArray, function(i, xywh){
			var xywh = histArray[i];
			var array = xywh.split(",");
			var name = array[4];
			var node = _self.myLoadMap.get(name);
			node.isHistory = "true";
			var cell = node.getCell();
			cell.showTooltipName = name;
			cell.isHistory = "true";
			if(_iconType == "1"){
				//新图元
				var newStyle = _self.editor.graph.model.getStyle(cell).replace('/new/','/new_over/');
				var list = eval("subprocess."+name);
				if(flowUtils.notNull(list)){
					newStyle = newStyle.replace('/task_human.png','/over/task_human_sub.png');
				}
				_self.editor.graph.model.setStyle(cell, newStyle);
			}else{
				/*var id = _self.countUtils.getSelfId();
				var vertex = _self.editor.graph.createVertex(cell.getParent(), id, "", cell.getGeometry().x + 20, cell.getGeometry().y + 17, 16, 16, "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/tick.png;");
				vertex.pid = cell.id;
				_self.editor.graph.addCell(vertex, cell.getParent());
				vertex.showTooltipName = name;*/
				var newStyle = _self.editor.graph.model.getStyle(cell).replace('/48/norun/','/48/over/');
				newStyle = newStyle.replace('/node/norun/','/node/');
				_self.editor.graph.model.setStyle(cell, newStyle);
			}
//			if(name.indexOf("Subprocess") != -1){
//				node.actNodeClick = function() {
//					$.ajax({
//						type : "POST",
//						data : {
//							entryId : entryId,
//							subprocess : name
//						},
//						url : "platform/bpm/business/getSubprocess",
//						dataType : "text",
//						success : function(result) {
//							if(flowUtils.notNull(result)){
//								var dialog = layer.open({
//									type : 2,
//									title: "子流程",
//									area : [ "1000px", "500px" ],
//									content : "avicit/platform6/bpmreform/bpmdesigner/picture/picAndTracks.jsp?entryId=" + result
//								});
//								layer.full(dialog);
//							}else{
//								flowUtils.warning("数据错误！");
//							}
//						}
//					});
//				};
//			}

			//启用了表单复制功能
			if(_self.autocopyformdata == "true"){
				if(node.tagName == "task"){
					node.actNodeClick = function() {
						_self.clickNode2OpenForm(name);
					};
				}
			}else {
				var _list = eval("subprocess."+name);
				if(flowUtils.notNull(_list)){
					node.actNodeClick = function() {
						var list = eval("subprocess."+name);
						_self.clickNode(list);
					};
				}
			}



			//节点旁边显示处理人
			if(flowUtils.notNull(userInfo)){
				var userText = eval("userInfo." + node.name);
				var endTime = eval("userInfo." + node.name + "_endTime");
				if(flowUtils.notNull(userText)){
					_self.drawUserText(cell, userText, endTime);
				}
			}
		});
	}

	var lineArray = obj.redline;
	if (lineArray != null && lineArray.length > 0) {
		var lastRetreatCell = null;
		for (var i = 0; i < lineArray.length; i++) {
			var xywh = lineArray[i];
			var array = xywh.split(",");
			var start = array[4];
			var end = array[5];
			if (flowUtils.notNull(start, end)) {
				var startNode = this.myLoadMap.get(start);
				var startCell = startNode.getCell();
				var endCell = this.myLoadMap.get(end).getCell();
				var edgeArr = this.editor.graph.getEdgesBetween(startCell, endCell, true);
				if (edgeArr.length > 0 && !edgeArr[0].isAdd) {
					this.allEdges = this.allEdges.concat(edgeArr);
				} else if (startNode.hasForkJoin()) {
					var forkJoinCell = null;
					var forkJoinNode = null;
					for(var j = 0; j < startNode.forkJoinArr.length; j ++){
						var forkJoinId = startNode.forkJoinArr[j];
						var forkJoinNode = this.myCellMap.get(forkJoinId);
						forkJoinCell = forkJoinNode.getCell();
						var tempEdgeArr = this.editor.graph.getEdgesBetween(forkJoinCell, endCell, true);
						if(tempEdgeArr.length > 0){
							break;
						}
						forkJoinCell = null;
						forkJoinNode = null;
					}
					if(forkJoinNode == null){
						continue;
					}
					forkJoinNode.isHistory = "true";
					if(_iconType == "1"){
						//新图元
						var newStyle = this.editor.graph.model.getStyle(forkJoinCell).replace('/new/','/new_over/');
						this.editor.graph.model.setStyle(forkJoinCell, newStyle);
					}
					edgeArr = this.editor.graph.getEdgesBetween(forkJoinCell, endCell, true);
					if (edgeArr.length > 0) {
						this.allEdges = this.allEdges.concat(edgeArr);
						edgeArr = this.editor.graph.getEdgesBetween(startCell, forkJoinCell, true);
						this.allEdges = this.allEdges.concat(edgeArr);
						var newStyle = _self.editor.graph.model.getStyle(forkJoinCell).replace('/48/norun/gateway_fork.png','/48/gateway_fork.png');
						newStyle = newStyle.replace('/48/norun/gateway_join.png','/48/gateway_join.png');
						_self.editor.graph.model.setStyle(forkJoinCell, newStyle);
					} else {
						if(_iconType == "1"){
							//新图元，不要线
							continue;
						}
						var newStyle = this.editor.graph.model.getStyle(startCell).replace('/task_human.png','/task_human_back.png');
						this.editor.graph.model.setStyle(startCell, newStyle);
						var jumpLine = this.addLine(startCell, endCell);
						this.editor.graph.setCellStyles("strokeColor", "red", [jumpLine]);
						//this.allEdges.push(jumpLine);
					}
				} else {
					if(edgeArr.length > 0){
						continue;
					}
					if(_iconType == "1"){
						//新图元，不要线
						continue;
					}
					var jumpLine = this.addLine(startCell, endCell);
					jumpLine.isAdd = true;
					this.editor.graph.setCellStyles("strokeColor", "red", [jumpLine]);
					//this.allEdges.push(jumpLine);


					/*var newStyle = this.editor.graph.model.getStyle(startCell).replace('/task_human.png','/task_human_back.png');
					this.editor.graph.model.setStyle(startCell, newStyle);*/
					lastRetreatCell = startCell;
				}
			}
		}
		if(_iconType == "1"){
			//新图元，不要线变色
		}else{
			/*if(lastRetreatCell){
				var newStyle = this.editor.graph.model.getStyle(lastRetreatCell).replace('/task_human.png','/task_human_back.png');
				this.editor.graph.model.setStyle(lastRetreatCell, newStyle);
			}*/
			/*this.editor.graph.setCellStyles("strokeWidth", "2", this.allEdges);
			this.editor.graph.setCellStyles("strokeColor", "#2a93ff", this.allEdges);*/
			this.editor.graph.setCellStyles("strokeColor", "blue", this.allEdges);
//			this.editor.graph.removeCells(this.allEdges);
//			this.editor.graph.addCells(this.allEdges, this.editor.graph.getDefaultParent());
		}
	}
};
/**
 * 隐藏未流转节点
 */
MyDesignerEditor.prototype.hideCells = function(){
	var values = this.myCellMap.values();
	var removeArr = [];
	$.each(values, function(i, n){
		if(n.tagName == "swimlane"){
			return;
		}
		if(n.tagName == "transition"){
			return;
		}
		if(n.isCurrent != "true" && n.isHistory != "true"){
			removeArr.push(n.getCell());
		}
	});
	this.editor.graph.removeCells(removeArr);
};
MyDesignerEditor.prototype.beforeSelectRow = function(){
	$("#processGrid").jqGrid('resetSelection');
    return true;
};
MyDesignerEditor.prototype.openSubprocess = function(id){
	var _self = this;
	var dialog = layer.open({
		type : 2,
		title: "子流程",
		area : [ "800px", "450px" ],
		content : _self.picJsp + "?entryId=" + id
	});
	layer.full(dialog);
};
MyDesignerEditor.prototype.clickNode = function(list){
	var _self = this;
	if(flowUtils.notNull(list)){
		if(list.length == 1){
			_self.openSubprocess(list[0].entryId);
		}else{
			layer.open({
			    type:  1,
			    area: [ "400px",  "500px"],
			    title: "子流程",
			    content: "<table id='processGrid'></table>",
			    btn: ['确定', '关闭'],
				 success : function(layero, index) {
					$("#processGrid").jqGrid({
						datastr : JSON.stringify(list),
						datatype : "jsonstring",
						colModel : [{
							name : 'entryId',
							key : true,
							hidden : true
						}, {
							label : '标题',
							name : 'entryName',
							align : 'center'
						}, {
							label : '接收人',
							name : 'userName',
							align : 'center'
						} , {
							label : '子流程模板',
							name : 'procdefName',
							align : 'center'
						} ],
						rownumbers : true,
						altRows : true,
						styleUI : 'Bootstrap',
						autowidth : true,
						height : '100%',
						multiselect: false,
						multiboxonly:true,
						beforeSelectRow: _self.beforeSelectRow
					});
				},
				yes: function(index, layero){
					var id = $("#processGrid").jqGrid("getGridParam","selrow");
					if (id != "") {
						_self.openSubprocess(id);
					} else{
						layer.msg("请选择数据");
						return;
					}
					layer.close(index);
				}
			});
		}
	}
};

MyDesignerEditor.prototype.clickNode2OpenForm = function(taskName){
	flowUtils.detail(this.entryId, 2, null, taskName);
};

MyDesignerEditor.prototype.getPoint = function(start, end) {
	var startX = 0;
	var startY = 0;
	if(start.parent.id != "1"){
		startX = start.parent.getGeometry().x;
		startY = start.parent.getGeometry().y;
	}
	var x1 = startX + start.getGeometry().x;
	var y1 = startY + start.getGeometry().y;

	var endX = 0;
	var endY = 0;
	if(end.parent.id != "1"){
		endX = end.parent.getGeometry().x;
		endY = end.parent.getGeometry().y;
	}
	var x2 = endX + end.getGeometry().x;
	var y2 = endY + end.getGeometry().y;

	x1 = x1 + start.getGeometry().width/2;
	y1 = y1 + start.getGeometry().height/2;

	x2 = x2 + end.getGeometry().width/2;
	y2 = y2 + end.getGeometry().height/2;

	var x, y;
	if (Math.abs(y1 - y2) < 60) {
		x = x2 > x1 ? x2 - Math.abs(x1 - x2) / 2 : x2 + Math.abs(x1 - x2) / 2;
		if (y1 < y2) {
			y = y1 - 20;
		} else {
			y = y2 - 20;
		}
	} else {
		y = y2 > y1 ? y2 - Math.abs(y1 - y2) / 2 : y2 + Math.abs(y1 - y2) / 2;
		if (x1 > x2) {
			x = x1 + (start.getGeometry().width + 20);
		} else {
			x = x2 + (end.getGeometry().width + 20);
		}
	}
	x = x < 1 ? 1 : x;
	y = y < 1 ? 1 : y;
	var top = $(this.editor.graph.container).offset().top;
	//var pt = mxUtils.convertPoint(this.editor.graph.container, x, y + top);
	var pt = this.convertPoint(this.editor.graph.container, x, y + top);
	return pt;
};

MyDesignerEditor.prototype.convertPoint = function(container, x, y)
{
	var origin = {
	 x:0,
	 y:0
	};
	var offset = mxUtils.getOffset(container);

	offset.x -= origin.x;
	offset.y -= origin.y;

	return new mxPoint(x - offset.x, y - offset.y);
}

MyDesignerEditor.prototype.addLine = function(startCell, endCell) {
	var id = this.countUtils.getSelfId();
	this.editor.graph.insertEdge(this.editor.graph.getDefaultParent(), id, "", startCell, endCell, "");
	var jumpLine = this.editor.graph.getModel().getCell(id);
	var state = this.editor.graph.view.getState(jumpLine);
	var handler = this.editor.graph.createHandler(state);

	var geo = this.editor.graph.getCellGeometry(state.cell);
	if (geo != null) {
		geo = geo.clone();
		var pt = this.getPoint(startCell, endCell);
		var index = mxUtils.findNearestSegment(state, pt.x, pt.y);
		handler.convertPoint(pt, true);
		if (geo.points == null) {
			geo.points = [ pt ];
		} else {
			geo.points.splice(index, 0, pt);
		}
		handler.graph.getModel().setGeometry(state.cell, geo);
		handler.destroy();
	}
	return jumpLine;
};
// 跳转、补发、拿回、全局读者动作
MyDesignerEditor.prototype.arrayObj = new Array();
MyDesignerEditor.prototype.drawAct = function(activityMap, processInstanceId) {
	var _self = this;
	$.each(activityMap, function(i, activity) {
		var activityAlias = activity.activityAlias;
		var activityName = activity.activityName;
		var isCurrent = activity.isCurrent;
		var over = activity.over;
		var executionId = activity.executionId;
		var isAlone = activity.executionAlone;
		var sameActName = activity.sameActName;
		var node = _self.myLoadMap.get(activityName);
		if (flowUtils.notNull(node)) {
			if (isCurrent == "true") {
				_self.arrayObj.push(node);
			}
			node.actNodeClick = function() {
				if (isCurrent == "true") {
					if (type == 'dosupplement') {
						_self.dosupplement(executionId, activityName);
					}
					if (type == 'doglobaljump') {
						_self.dojump(node, processInstanceId, isCurrent, activityName, activityAlias, executionId, isAlone);
					}
					if (type == 'dowithdraw') {
						_self.dowithdraw(executionId, activityName);
					}
				}else{
					if (type == 'doglobaljump') {
						_self.dojump(node, processInstanceId, isCurrent, activityName, activityAlias, executionId, isAlone);
					}
					if (type == 'doretreattowant' && over == "true") {
						_self.doretreattowant(activityName);
					}
				}
				if(type == "dostepuserdefined"){
					_self.dostepuserdefined(activityName);
				}
			};
		}
	});
};
MyDesignerEditor.prototype.dowithdraw = function(executionId, activityName) {
	parent.bpmWithdraw.callback(executionId, activityName);
};
MyDesignerEditor.prototype.dosupplement = function(executionId, activityName) {
	parent.bpmSupplement.callback(executionId, activityName);
};
MyDesignerEditor.prototype.dostepuserdefined = function(activityName) {
	parent.bpmStepuserdefined.callback(activityName);
};
MyDesignerEditor.prototype.doretreattowant = function(activityName) {
	parent.bpmRetreatToWant.callback(activityName);
};
MyDesignerEditor.prototype.startExecutionId = null;
MyDesignerEditor.prototype.dojump = function(node, processInstanceId, isCurrent, activityName, activityAlias, executionId, isAlone) {
	var _self = this;
	// 只有一个当前节点，默认是开始节点
	if (isAlone)  {
		if (isCurrent == "true") {
			return;
		}
	} else {
		if (isCurrent == "true") {
			this.startExecutionId = executionId;
			this.editor.graph.setCellStyles("imageBorder", "blue", [ node.getCell() ]);
			$.each(this.arrayObj, function(i, n) {
				if (n.id != node.id) {
					if(_iconType == "1"){
						//新图元
						_self.editor.graph.setCellStyles("imageBorder", "", [ n.getCell() ]);
					}else{
						_self.editor.graph.setCellStyles("imageBorder", "red", [ n.getCell() ]);
					}
				}
			});
			return;
		} else {
			if (!flowUtils.notNull(this.startExecutionId)) {
				flowUtils.warning("请您先选择一个当前节点作为流程跳转的起始节点");
				return;
			}
		}
	}
	// Added in 01-16
	var rst;
	if (flowUtils.notNull(this.startExecutionId)) {
		rst = this.validateDestActivity(processInstanceId, this.startExecutionId, activityName);
	} else {
		rst = this.validateDestActivity(processInstanceId, executionId, activityName);
	}
	if (rst.flag == "failed") {
		flowUtils.warning("无法跳转到所选节点，请您重新选择");
		return;
	}
	// 分支跳转
	if (flowUtils.notNull(this.startExecutionId)) {
		executionId = this.startExecutionId;
	}
	parent.bpmGlobaljump.callback(executionId, activityName);
};
MyDesignerEditor.prototype.validateDestActivity = function(processInstanceId, executionId, activityName) {
	var result = "";
	$.ajax({
		type : "POST",
		data : {
			procinstDbid : processInstanceId,
			executionId : executionId,
			activityName : activityName
		},
		url : "platform/bpm/clientbpmoperateaction/validateDestActivity",
		async : false,
		dataType : "json",
		success : function(msg) {
			result = msg;
		}
	});
	return result;
};
