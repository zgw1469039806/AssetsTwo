/**
 * 编辑器
 */
function DesignerEditor() {
};
// 编辑器
DesignerEditor.prototype.editor = null;
DesignerEditor.prototype.setEditor = function(editor) {
	this.editor = editor;
};
// 定义存储数据的map对象
DesignerEditor.prototype.myCellMap = null;
// 流程key
DesignerEditor.prototype.processKey = null;
// 临时map，按名称记录对象
DesignerEditor.prototype.myLoadMap = null;
// 自增序列
DesignerEditor.prototype.countUtils = null;
// 当前对象ID
DesignerEditor.prototype.myCurCellId = null;
// 全局属性区域
DesignerEditor.prototype.homeDiv = null;
// 节点属性区域
DesignerEditor.prototype.profileDiv = null;
// controller
DesignerEditor.prototype.controlPath = "platform/bpm/designer/";
// 是否是新的设计器编辑的流程，意味着加载解析方式的不同
DesignerEditor.prototype.useNewDesigner = false;
// 横向泳道
DesignerEditor.prototype.swimlane1 = 0;
// 纵向泳道
DesignerEditor.prototype.swimlane2 = 0;
// 校验后是否允许保存
DesignerEditor.prototype.allowSave = true;
//是否自由流程
DesignerEditor.prototype.isUflow = false;

/**
 * 初始化
 */
DesignerEditor.prototype.init = function() {
	var _self = this;
	this.myCellMap = new Map();
	this.myLoadMap = new Map();
	this.countUtils = new CountUtils();
	this.homeDiv = $("#homeDiv");
	this.profileDiv = $("#profileDiv");
	if (_type == 3) {
		// 新建
		this.processKey = _id;// key值和id值一样
		var myProcess = new MyProcess(this, this.processKey);
		myProcess.init();
		this.myCellMap.put(this.processKey, myProcess);
		//流程名称
		if(flowUtils.notNull(_name)){
			myProcess.alias = _name;
			$("#" + this.processKey).find("#liu_cheng_ming_cheng").val(_name);
		}
		// 初始化泳道
		if (_isUflow == "1" && flowUtils.notNull(_swimlane)) {
			_swimlane = $.trim(_swimlane);
			_swimlane = _swimlane.replaceAll("，",",");
			_swimlane = _swimlane.replaceAll(" ",",");
			var swimlaneArr = _swimlane.split(",");
			var template = this.editor.templates["swimlane1"];
			var startTemplate = this.editor.templates["start"];
			var taskTemplate = this.editor.templates["task"];
			var endTemplate = this.editor.templates["end"];
			
			var startCell = this.editor.graph.cloneCells([ startTemplate ])[0];
			var endCell = this.editor.graph.cloneCells([ endTemplate ])[0];
			var lastTaskCell = null;
			
			for (var i = 0; i < swimlaneArr.length; i++) {
				if(!flowUtils.notNull(swimlaneArr[i])){
					continue;
				}
				
				var cell = this.editor.graph.cloneCells([ template ])[0];
				this.editor.addVertex(null, cell, 10, 10 + i * 110);
				$("#" + cell.id).find("#xian_shi_ming_cheng").val(swimlaneArr[i]);
				this.myCellMap.get(cell.id).labelChanged(swimlaneArr[i]);
				
				if(i == 0){
					this.editor.addVertex(cell, startCell, cell.getGeometry().x + 50, cell.getGeometry().y + (cell.getGeometry().height - startCell.getGeometry().height)/2);
				}
				var taskCell = this.editor.graph.cloneCells([ taskTemplate ])[0];
				this.editor.addVertex(cell, taskCell, startCell.getGeometry().x + startCell.getGeometry().width + 60, cell.getGeometry().y + (cell.getGeometry().height - taskCell.getGeometry().height)/2);
				$("#" + taskCell.id).find("#xian_shi_ming_cheng").val(swimlaneArr[i]);
				this.myCellMap.get(taskCell.id).labelChanged(swimlaneArr[i]);
				
				if(lastTaskCell == null){
					this.editor.graph.addEdge(this.editor.createEdge(startCell, taskCell), null, startCell, taskCell);
					this.editor.graph.selectVertices(cell);
					this.editor.execute("alignCellsMiddle");
					this.editor.execute("selectNone");
				}else{
					this.editor.graph.addEdge(this.editor.createEdge(lastTaskCell, taskCell), null, lastTaskCell, taskCell);
				}
				lastTaskCell = taskCell;
				
				if(i == (swimlaneArr.length - 1)){
					this.editor.addVertex(cell, endCell, taskCell.getGeometry().x + taskCell.getGeometry().width + 60, cell.getGeometry().y + (cell.getGeometry().height - endCell.getGeometry().height)/2);
					this.editor.graph.addEdge(this.editor.createEdge(taskCell, endCell), null, taskCell, endCell);
					this.editor.graph.selectVertices(cell);
					this.editor.execute("alignCellsMiddle");
					this.editor.execute("selectNone");
				}
			}
			this.editor.execute("autoLayout");
		}
		//自由流程
		if(_isUflow == "2"){
			var startTemplate = this.editor.templates["start"];
			var taskTemplate = this.editor.templates["task"];
			var endTemplate = this.editor.templates["end"];
			
			var startCell = this.editor.graph.cloneCells([ startTemplate ])[0];
			this.editor.addVertex(null, startCell, 30, 30);
			
			var taskCell = this.editor.graph.cloneCells([ taskTemplate ])[0];
			this.editor.addVertex(null, taskCell, startCell.getGeometry().x + startCell.getGeometry().width + 30, 30);
			$("#" + taskCell.id).find("#xian_shi_ming_cheng").val("节点1");
			this.myCellMap.get(taskCell.id).labelChanged("节点1");
			
			var endCell = this.editor.graph.cloneCells([ endTemplate ])[0];
			this.editor.addVertex(null, endCell, taskCell.getGeometry().x + taskCell.getGeometry().width + 30, 30);
			
			this.editor.graph.addEdge(this.editor.createEdge(startCell, taskCell), null, startCell, taskCell);
			var toEndEdge = this.editor.graph.addEdge(this.editor.createEdge(taskCell, endCell), null, taskCell, endCell);
			$("#" + toEndEdge.id).find("#xian_shi_ming_cheng").val("结束流程");
			this.myCellMap.get(toEndEdge.id).labelChanged("结束流程");
			
			this.editor.execute("selectAll");
			this.editor.execute("alignCellsMiddle");
			this.editor.execute("selectNone");
		}
	} else {
		avicAjax.ajax({
			type : "POST",
			data : {
				id : _id,
				type : _type,
				pdId : _pdId,
				deployId : _deployId,
				_iconType: _iconType
			},
			url : this.controlPath + "getProcessXml?date=" + new Date().getTime(),
			dataType : "json",
			success : function(result) {
				if (flowUtils.notNull(result.processXml)) {
					// 加载
					var xml = mxUtils.parseXml(result.processXml);
					//保存老的流程对象，调用网安保存流程同步配置日志时使用
					_oldProcess = xml.getElementsByTagName("process")[0];
					var xmlvalue = _self.converToGraphXml(xml);
					_self.editor.readGraphModel(xmlvalue);

                    var process = null;
                    var values = _self.myCellMap.values();
                    $.each(values, function(i, n){
                        if(n.tagName == "process"){
                            process = n;
                            return false;
                        }
                    });
                    if(process != null) {
                        process.notify();
					}

				} else {
					// 查不到对应流程文件
					flowUtils.error("查不到对应流程文件");
				}
			}
		});
	}
	if(_isUflow == "2"){
		this.isUflow = true;
	}
	//自由流，限制界面功能
	if(this.isUflow){
		this.editor.graph.cellsLocked = true;
		$("#toolbar_div").hide();
		$("#graph").css("left","5px");
	}
};
/**
 * 创建元素对象
 */
DesignerEditor.prototype.createBaseByTagName = function(tagName, id, vertex, edge) {
	var baseNode = null;
	if (vertex) {
		if (tagName == "start") {
			baseNode = new MyStart(this, id);
		} else if (tagName == "end") {
			baseNode = new MyEnd(this, id);
		} else if (tagName == "task") {
			baseNode = new MyTask(this, id);
		} else if (tagName == "java") {
			baseNode = new MyJava(this, id);
		} else if (tagName == "sql") {
			baseNode = new MySql(this, id);
		} else if (tagName == "ws") {
			baseNode = new MyWs(this, id);
		} else if (tagName == "state") {
			baseNode = new MyState(this, id);
		} else if (tagName == "fork") {
			baseNode = new MyFork(this, id);
		} else if (tagName == "join") {
			baseNode = new MyJoin(this, id);
		} else if (tagName == "decision") {
			baseNode = new MyExclusive(this, id);
		} else if (tagName == "sub-process") {
			baseNode = new MySubprocess(this, id);
		} else if (tagName == "foreach") {
			baseNode = new MyForeach(this, id);
		} else if (tagName == "jms") {
			baseNode = new MyJms(this, id);
		} else if (tagName == "custom") {
			baseNode = new MyCustom(this, id);
		} else if (tagName == "rules") {
			baseNode = new MyRules(this, id);
		} else if (tagName == "swimlane") {
			baseNode = new MySwimlane(this, id);
		} else if (tagName == "text") {
			baseNode = new MyText(this, id);
		} else if (tagName == "rest") {
            baseNode = new MyRest(this, id);
        }
	} else if (edge) {
		baseNode = new MyTransition(this, id);
	}
	return baseNode;
};
/**
 * 判断是否横向泳道
 */
DesignerEditor.prototype.isSwimlane1 = function(cell) {
	return cell.getAttribute("cellType") == "swimlane1";
};

/**
 * 添加元件事件
 * 
 * @param cells
 */
DesignerEditor.prototype.addCell = function(cell) {
	if (!this.myCellMap.containsKey(cell.id)) {
		var nodeBase = this.createBaseByTagName(cell.value.nodeName, cell.id, cell.vertex, cell.edge);
		nodeBase.init();
		this.myCellMap.put(cell.id, nodeBase);
	}
};
/**
 * 删除元件事件
 * 
 * @param cells
 */
DesignerEditor.prototype.removeCells = function(cells) {
	for (var i = 0; i < cells.length; i++) {
		var cell = cells[i];
		this.myCellMap.get(cell.id).remove();
		this.myCellMap.remove(cell.id);
		if (cell.value.nodeName == "swimlane" && cell.children != null) {
			this.removeCells(cell.children);
		}
	}
};
/**
 * 双击元件事件
 * 
 * @param cells
 */
DesignerEditor.prototype.doubleClickCell = function(cell) {
	if(flowUtils.notNull(cell)){
		if (cell.value.nodeName == "sub-process") {
			this.myCellMap.get(cell.id).doubleClickCell();
		}
	}
};
/**
 * 构建process文件
 * 
 * @returns
 */
DesignerEditor.prototype.showProcess = function() {
	var process = this.myCellMap.get(this.processKey).getXmlDoc();
	process.setAttribute("useNewDesigner", "true");
	process.setAttribute("iconType", _iconType);
	process.setAttribute("isUflow", _isUflow);
	var transitionMap = new Map();
	var values = this.myCellMap.values();
	for (var i = 0; i < values.length; i++) {
		var baseNode = values[i];
		if (baseNode.tagName == "transition") {
			var sourceId = baseNode.getCell().source.id;
			if (transitionMap.containsKey(sourceId)) {
				transitionMap.get(sourceId).push(baseNode.getXmlDoc());
			} else {
				var transitionArr = new Array();
				transitionArr.push(baseNode.getXmlDoc());
				transitionMap.put(sourceId, transitionArr);
			}
		}
	}
	var start = 0;
	var end = 0;
	var task = 0;
	for (var i = 0; i < values.length; i++) {
		var baseNode = values[i];
		var cell = baseNode.getCell();
		if(baseNode.tagName == "start"){
			start ++;
			if(_needfirstuser != "true"){
				if(cell.edges && cell.edges.length > 0){
					var firstCell = cell.edges[0].target;
					var $candidate = $("#"+firstCell.id +" #draft-candidate-data-field");
					var actorDataValue = $candidate.val();
					if(actorDataValue.length > 0){
						var actorJSONArray = JSON.parse(actorDataValue);
						if(actorJSONArray.length > 0){
							this.allowSave = false;
							flowUtils.warning("拟稿节点不应该配置参与者");
							return;
						}
					}
				}
			}
		}
		if(baseNode.tagName == "end"){
			end ++;
		}
		if(baseNode.tagName == "task"){
			task ++;
		}
		if (baseNode.tagName != "process" && baseNode.tagName != "transition") {
			if(baseNode.tagName != "swimlane" && baseNode.tagName != "text"){
				if(!cell.edges || cell.edges.length == 0){
					this.allowSave = false;
					flowUtils.warning("不应有孤立的流程节点");
					return;
				}
			}
			var node = baseNode.getXmlDoc();
			if (transitionMap.containsKey(baseNode.id)) {
				var transitionArr = transitionMap.get(baseNode.id);
				for (j = 0; j < transitionArr.length; j++) {
					node.appendChild(transitionArr[j]);
				}
			}
			process.appendChild(node);
		}
	}
	if(start == 0 || end == 0 || task == 0){
		this.allowSave = false;
		flowUtils.warning("流程文件至少应包含开始节点、结束节点和一个人工节点");
		return;
	}

	//return mxUtils.getPrettyXml(process);
    return this.getPrettyXml(process);
};
/**
 * 循环各个元素进行转换
 */
DesignerEditor.prototype.cycleTags = function(tagName, process, rootXml, transitionArr) {
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
		tagNode.initLoad(tags[i], rootXml);
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
/**
 * 循环各个元素进行转换
 */
DesignerEditor.prototype.converToGraphXml = function(data) {
	// process
	var process = data.getElementsByTagName("process")[0];
	this.processKey = process.getAttribute("key");
	this.useNewDesigner = "true" == process.getAttribute("useNewDesigner") ? true : false;
	var myProcess = new MyProcess(this, this.processKey);
	myProcess.initLoad(process);
	this.myCellMap.put(this.processKey, myProcess);

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
	this.cycleTags("text", process, rootXml, transitionArr);
    this.cycleTags("rest", process, rootXml, transitionArr);
	for (var i = 0; i < transitionArr.length; i++) {
		var transitionId = this.countUtils.getSelfId();
		if (this.useNewDesigner) {
			transitionId = transitionArr[i].xml.getAttribute("_id");
			this.countUtils.setSelfId(Number(transitionId));
		}
		var transitionNode = new MyTransition(this, transitionId);
		transitionNode.initLoad(transitionArr[i].xml, rootXml, transitionArr[i].sourceId);
		this.myCellMap.put(transitionId, transitionNode);
	}

	graphXml.appendChild(rootXml);
	return graphXml;
};
/**
 * 保存为新版本
 */
DesignerEditor.prototype.saveToNew_xml = function() {
	var postData = this.getPostData();
	if(flowUtils.notNull(postData)){
		var _self = this;
		postData.type = "3";//新建
		flowUtils.confirm("确定保存为新版本？", function() {
			avicAjax.ajax({
				url : _self.controlPath + "saveFlowModel",
				type : "POST",
				data : postData,
				datatype : "json",
				success : function(r) {
					if (flowUtils.notNull(r.error)) {
						flowUtils.error(r.error);
					} else {
						flowUtils.success("保存为新版本成功！页面将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindow();
							//调用网安方法保存流程节点同步配置日志
							if(flowUtils.notNull(_processDataSynJs)){
								//修改时触发
								if(_pdId !=""){
									saveWaProcessSynConfigLog(_oldProcess,_newProcess);
								}
							}
						}, true);
					}
				}
			});
		});
	}
};
/**
 * 保存
 */
DesignerEditor.prototype.save_xml = function() {
	var postData = this.getPostData();
	if(flowUtils.notNull(postData)){
		var _self = this;
		flowUtils.confirm(this.validDelNodeFlg()?"确定保存？":"本次编辑有节点被删除，可能会影响现有正在运行的数据，确定保存并覆盖现有流程版本吗？", function() {
			avicAjax.ajax({
				url : _self.controlPath + "saveFlowModel",
				type : "POST",
				data : postData,
				datatype : "json",
				success : function(r) {
					if (flowUtils.notNull(r.error)) {
						flowUtils.error(r.error);
					} else {
						flowUtils.success("保存成功");
						flowUtils.refreshBack();
						//调用网安方法保存流程节点同步配置日志
						if(flowUtils.notNull(_processDataSynJs)){
							//修改时触发
							if(_pdId !=""){
								var xml = postData.flow_xml;
								var xmlObj = mxUtils.parseXml(xml);
								var process = xmlObj.getElementsByTagName("process")[0];
								saveWaProcessSynConfigLog(_oldProcess,process);
							}
						}
					}
				}
			});
		});
	}
};
/**
 * 发布
 */
DesignerEditor.prototype.send_xml = function() {
	var postData = this.getPostData();
	if(flowUtils.notNull(postData)){
		var _self = this;
		postData.sendXml = "true";
		flowUtils.confirm("确定保存并发布吗？", function() {
			avicAjax.ajax({
				url : _self.controlPath + "saveFlowModel",
				type : "POST",
				data : postData,
				datatype : "json",
				success : function(r) {
					if (flowUtils.notNull(r.error)) {
						flowUtils.error(r.error);
					} else {
						flowUtils.success("保存并发布成功！页面将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindow();
							//调用网安方法保存流程节点同步配置日志
							if(flowUtils.notNull(_processDataSynJs)){
								//修改时触发
								if(_pdId !=""){
									saveWaProcessSynConfigLog(_oldProcess,_newProcess);
								}
							}
						}, true);
					}
				}
			});
		});
	}
};
/**
 * 校验保存时是否有节点被删除
 */
DesignerEditor.prototype.validDelNodeFlg = function(){
	for(var i = 0; i < this.myLoadMap.values().length; i++){
		var loadNode = this.myLoadMap.values()[i];
		if(!this.myCellMap.containsKey(loadNode.id)){
			return false;
		}
	}
	return true;
};

DesignerEditor.prototype.getPostData = function(){
	var flowName = this.myCellMap.get(this.processKey).alias;
	if (!flowUtils.notNull(flowName)) {
		flowUtils.warning("流程名称不能为空");
		return;
	}
	this.allowSave = true;
	var postData = {};
	postData.catalogId = _catalog;
	postData.id = _id;
	postData.type = _type;
	postData.flowName = flowName;
	postData.flowKey = this.processKey;
	postData.flowDesc = "";
	postData.pdId = _pdId;
	postData.deployId = _deployId;
	postData.isUflow = _isUflow;
	// 在组织xml的同时，组织要入库的数据到xml中，中间校验出现问题，置this.allowSave为false
	// postData.flow_xml = this.showProcess();
	//回归项目修改
	var flow_xml = this.showProcess();

	if (!this.allowSave) {
		return;
	}
	// postData.png_xml = this.getImageXml();
	//回归项目修改
	var png_xml = this.getImageXml();
	postData.flow_xml = Base64.encode(flow_xml);
	postData.png_xml = Base64.encode(png_xml);

	var bounds = this.editor.graph.getGraphBounds();
	var w = Math.ceil(bounds.x + bounds.width + 4);
	var h = Math.ceil(bounds.y + bounds.height + 4);
	postData.w = w;
	postData.h = h;
	return postData;
};
DesignerEditor.prototype.validMoveCells = function(cells, dx, dy, clone, target, evt, mapping) {
	if (target != null && target.value.nodeName == "swimlane") {
		for (var i = 0; i < cells.length; i++) {
			if (cells[i].value.nodeName == "swimlane") {
				flowUtils.warning("泳道内不能放置泳道");
				return false;
			}
		}
	}
	return true;
};
/**
 * 创建ImageXml
 * 
 * @returns
 */
DesignerEditor.prototype.getImageXml = function() {
	var xmlDoc = mxUtils.createXmlDocument();
	var root = xmlDoc.createElement('output');
	xmlDoc.appendChild(root);
	
	var xmlCanvas = new mxXmlCanvas2D(root);
	xmlCanvas.converter.setBaseUrl(_bpm_baseurl);
	var imgExport = new mxImageExport();
	imgExport.drawState(this.editor.graph.getView().getState(this.editor.graph.model.root), xmlCanvas);
	
	return mxUtils.getXml(root);
};
DesignerEditor.prototype.validDeleteCell = function(cells, includeEdges){
	if(this.isUflow){
		flowUtils.warning("自由流程只能调整布局，不能手动增删节点");
		return false;
	}
	return true;
};
DesignerEditor.prototype.validAddCell = function(cell, parent, index, source, target) {
	if(this.isUflow){
		flowUtils.warning("自由流程只能调整布局，不能手动增删节点");
		return false;
	}
	if (cell.edge) {
		if (source.value.nodeName == "end") {
			flowUtils.warning("结束节点不能作为起点");
			return false;
		} else if (target.value.nodeName == "start") {
			flowUtils.warning("开始节点不能作为终点");
			return false;
		} else if(source.value.nodeName == "start"){
			if (target.value.nodeName != "task") {
				flowUtils.warning("开始节点只能指向人工节点");
				return false;
			}else if(source.edges && source.edges.length != 0){
				flowUtils.warning("开始节点只能指向一个人工节点");
				return false;
			}
		}
	} else if (cell.vertex && cell.value.nodeName == "start") {
		var values = this.myCellMap.values();
		for (var i = 0; i < values.length; i++) {
			if (values[i].tagName == "start") {
				flowUtils.warning("不能添加多个开始节点");
				return false;
			}
		}
	} else if (cell.vertex && cell.value.nodeName == "swimlane") {
		if ((this.isSwimlane1(cell) && this.swimlane2 > 0) || (!this.isSwimlane1(cell) && this.swimlane1 > 0)) {
			flowUtils.warning("横向泳道与纵向泳道不能混用");
			return false;
		} else if (parent.value.nodeName == "swimlane") {
			flowUtils.warning("泳道内不能放置泳道");
			return false;
		}
	}
	return true;
};
DesignerEditor.prototype.validConnectCell = function(_mxgraph, edge, terminal, source, constraint){
	if(this.isUflow){
		flowUtils.warning("自由流程只能调整布局，不能手动改动连线");
		return false;
	}
	var sourceCell = null;
	var targetCell = null;
	if(source){
		sourceCell = terminal;
		targetCell = edge.target;
	}else{
		sourceCell = edge.source;
		targetCell = terminal;
	}
	if (sourceCell.value.nodeName == "end") {
		flowUtils.warning("结束节点不能作为起点");
		return false;
	} else if (targetCell.value.nodeName == "start") {
		flowUtils.warning("开始节点不能作为终点");
		return false;
	} else if(sourceCell.value.nodeName == "start"){
		if (targetCell.value.nodeName != "task") {
			flowUtils.warning("开始节点只能指向人工节点");
			return false;
		}else if(sourceCell.edges && sourceCell.edges.length != 0){
			flowUtils.warning("开始节点只能指向一个人工节点");
			return false;
		}
	}
	var cellNode = this.myCellMap.get(edge.id);
	if(!source){
		cellNode.rename("to " + this.myCellMap.get(targetCell.id).name);
	}
	setTimeout(function () {
		cellNode.controlCandidate();
	}, 500);
	return true;
};
DesignerEditor.prototype.changeSelected = function() {
	var _self = this;
	if (_self.editor.graph != null) {
		if(_self.myCurCellId != null){
			var preCell = _self.editor.graph.getModel().getCell(_self.myCurCellId);
			if(flowUtils.notNull(preCell) && flowUtils.notNull(preCell.style) && preCell.style.indexOf("symbol") == "0"){
				_self.editor.graph.setCellStyles("imageBorder", "", [ preCell ]);
			}
		}
		if (!_self.editor.graph.isSelectionEmpty()) {
			var cell = _self.editor.graph.getSelectionCell();
			if(flowUtils.notNull(cell, cell.style) && cell.style.indexOf("symbol") == "0"){
				_self.editor.graph.setCellStyles("imageBorder", "green", [ cell ]);
			}
			_self.myCellMap.get(cell.id).showProp();
		} else {
			$(".prop_wrap").hide();
			_self.myCurCellId = null;
			setTimeout(function(){
				$('#propMainDiv').find('.nav-tabs').find('li').eq(0).trigger("click");
				$('#propMainDiv').find('.nav-tabs').find('a').eq(1).trigger("blur");
				$("#toolbar").find("img").eq(0).trigger("click");
			}, 100);
		}
	}
};
/**
 * 自定义undo操作，只undo移动节点，出现添加或删除节点，则clear
 * @param manager
 * @param undoableEdit
 * @returns {Boolean}
 */
DesignerEditor.prototype.validUndoCell = function(manager, undoableEdit){
	for(var i = 0; i < undoableEdit.changes.length; i++){
		if(undoableEdit.changes[i].constructor != mxGeometryChange){
			manager.clear();
			return false;
		}
	}
	return true;
};
DesignerEditor.prototype.goLeft = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		editor.graph.moveCells(cells, -1, 0);
	}
};
DesignerEditor.prototype.goUp = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		editor.graph.moveCells(cells, 0, -1);
	}
};
DesignerEditor.prototype.goRight = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		editor.graph.moveCells(cells, 1, 0);
	}
};
DesignerEditor.prototype.goDown = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		editor.graph.moveCells(cells, 0, 1);
	}
};
DesignerEditor.prototype.autoLayout = function(editor) {
	var cells = editor.graph.getChildVertices();
	if (flowUtils.notNull(cells)) {
		var o = {};
		var vCells = new Map();
		if (this.swimlane1 > 0) {
			for (var i = 0; i < cells.length; i++) {
				if (cells[i].vertex && cells[i].value.nodeName == "swimlane") {
					var y = Number(cells[i].getGeometry().y);
					vCells.put(y, cells[i]);
					if (!flowUtils.notNull(o.miny) || o.miny > y) {
						o.miny = y;
					}
					if (!flowUtils.notNull(o.maxy) || o.maxy < y) {
						o.maxy = y;
					}
				}
			}
			if (vCells.size() > 1) {
				var keys = vCells.keys();
				keys = keys.sort(function(a, b) {
					return a - b;
				})
				var width = vCells.get(keys[0]).getGeometry().width;
				var x = vCells.get(keys[0]).getGeometry().x;
				var h = 0;
				for (var i = 0; i < keys.length; i++) {
					vCells.get(keys[i]).getGeometry().width = width;
					editor.graph.moveCells([ vCells.get(keys[i]) ], 1, 0);
					editor.graph.moveCells([ vCells.get(keys[i]) ], x - vCells.get(keys[i]).getGeometry().x, (o.miny + h) - Number(keys[i]));
					h += vCells.get(keys[i]).getGeometry().height;
					vCells.remove(keys[i]);
				}
			}
		} else {
			for (var i = 0; i < cells.length; i++) {
				if (cells[i].vertex && cells[i].value.nodeName == "swimlane") {
					var x = Number(cells[i].getGeometry().x);
					vCells.put(x, cells[i]);
					if (!flowUtils.notNull(o.minx) || o.minx > x) {
						o.minx = x;
					}
					if (!flowUtils.notNull(o.maxx) || o.maxx < x) {
						o.maxx = x;
					}
				}
			}
			if (vCells.size() > 1) {
				var keys = vCells.keys();
				keys = keys.sort(function(a, b) {
					return a - b;
				})
				var height = vCells.get(keys[0]).getGeometry().height;
				var y = vCells.get(keys[0]).getGeometry().y;
				var w = 0;
				for (var i = 0; i < keys.length; i++) {
					vCells.get(keys[i]).getGeometry().height = height;
					editor.graph.moveCells([ vCells.get(keys[i]) ], 0, 1);
					editor.graph.moveCells([ vCells.get(keys[i]) ], (o.minx + w) - Number(keys[i]), y - vCells.get(keys[i]).getGeometry().y);
					w += vCells.get(keys[i]).getGeometry().width;
					vCells.remove(keys[i]);
				}
			}
		}
	}
};
/**
 * 直线
 * @param editor
 */
DesignerEditor.prototype.changeEdgeStyle1 = function(editor) {
	var cell = editor.graph.getSelectionCell();
	if (flowUtils.notNull(cell) && cell.edge) {
		editor.graph.setCellStyles("edgeStyle", "straightEdge", [cell]);
	}
	this.clearWaypoints(editor);
};
/**
 * 曲线
 * @param editor
 */
DesignerEditor.prototype.changeEdgeStyle2 = function(editor) {
	var cell = editor.graph.getSelectionCell();
	if (flowUtils.notNull(cell) && cell.edge) {
		editor.graph.setCellStyles("edgeStyle", null, [cell]);
	}
	this.clearWaypoints(editor);
};
/**
 * 清空拐点
 * @param editor
 */
DesignerEditor.prototype.clearWaypoints = function(editor) {
	var graph = editor.graph;
	var cells = graph.getSelectionCells();

	if (cells != null)
	{
		cells = graph.addAllEdges(cells);

		graph.getModel().beginUpdate();
		try
		{
			for (var i = 0; i < cells.length; i++)
			{
				var cell = cells[i];

				if (graph.getModel().isEdge(cell))
				{
					var geo = graph.getCellGeometry(cell);

					if (geo != null)
					{
						geo = geo.clone();
						geo.points = null;
						graph.getModel().setGeometry(cell, geo);
					}
				}
			}
		}
		finally
		{
			graph.getModel().endUpdate();
		}
	}
};
/**
 * 增加拐点
 * @param editor
 */
DesignerEditor.prototype.addWayPoint = function(editor) {
	var graph = editor.graph;
	var cell = graph.getSelectionCell();

	if (cell != null && graph.getModel().isEdge(cell))
	{
		var handler = graph.selectionCellsHandler.getHandler(cell);

		if (handler instanceof mxEdgeHandler)
		{
			var t = graph.view.translate;
			var s = graph.view.scale;
			var dx = t.x;
			var dy = t.y;

			var parent = graph.getModel().getParent(cell);
			var pgeo = graph.getCellGeometry(parent);

			while (graph.getModel().isVertex(parent) && pgeo != null)
			{
				dx += pgeo.x;
				dy += pgeo.y;

				parent = graph.getModel().getParent(parent);
				pgeo = graph.getCellGeometry(parent);
			}

			var x = Math.round(graph.snap(graph.popupMenuHandler.triggerX / s - dx));
			var y = Math.round(graph.snap(graph.popupMenuHandler.triggerY / s - dy));

			handler.addPointAt(handler.state, x, y);
		}
	}
};
DesignerEditor.prototype.comWidth = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		var o = {};
		var vCells = new Map();
		for (var i = 0; i < cells.length; i++) {
			if (cells[i].vertex && cells[i].value.nodeName != "swimlane") {
				var x = Number(cells[i].getGeometry().x);
				vCells.put(x, cells[i]);
				if (!flowUtils.notNull(o.minx) || o.minx > x) {
					o.minx = x;
				}
				if (!flowUtils.notNull(o.maxx) || o.maxx < x) {
					o.maxx = x;
				}
			}
		}
		if (vCells.size() > 1) {
			var w = (o.maxx - o.minx) / (vCells.size() - 1);
			var keys = vCells.keys();
			keys = keys.sort(function(a, b) {
				return a - b;
			})
			for (var i = 0; i < keys.length; i++) {
				editor.graph.moveCells([ vCells.get(keys[i]) ], (o.minx + w * i) - Number(keys[i]), 0);
				vCells.remove(keys[i]);
			}
		}
	}
};
DesignerEditor.prototype.comHeight = function(editor) {
	var cells = editor.graph.getSelectionCells();
	if (flowUtils.notNull(cells)) {
		var o = {};
		var vCells = new Map();
		for (var i = 0; i < cells.length; i++) {
			if (cells[i].vertex && cells[i].value.nodeName != "swimlane") {
				var y = Number(cells[i].getGeometry().y);
				vCells.put(y, cells[i]);
				if (!flowUtils.notNull(o.miny) || o.miny > y) {
					o.miny = y;
				}
				if (!flowUtils.notNull(o.maxy) || o.maxy < y) {
					o.maxy = y;
				}
			}
		}
		if (vCells.size() > 1) {
			var h = (o.maxy - o.miny) / (vCells.size() - 1);
			var keys = vCells.keys();
			keys = keys.sort(function(a, b) {
				return a - b;
			})
			for (var i = 0; i < keys.length; i++) {
				editor.graph.moveCells([ vCells.get(keys[i]) ], 0, (o.miny + h * i) - Number(keys[i]));
				vCells.remove(keys[i]);
			}
		}
	}
};
/**
 * 重写的mxUtils中的方法，因为原方法在处理text类型时会多加一个空格
 *
 * @param node
 * @param tab
 * @param indent
 * @returns
 */
DesignerEditor.prototype.getPrettyXml = function(node, tab, indent) {
    var result = [];

    if (node != null) {
        tab = tab || '  ';
        indent = indent || '';

        if (node.nodeType == mxConstants.NODETYPE_TEXT) {
            result.push(node.nodeValue);
        } else {
            result.push(indent + '<' + node.nodeName);

            // Creates the string with the node attributes
            // and converts all HTML entities in the values
            var attrs = node.attributes;

            if (attrs != null) {
                for (var i = 0; i < attrs.length; i++) {
                    var val = mxUtils.htmlEntities(attrs[i].nodeValue);
                    result.push(' ' + attrs[i].nodeName + '="' + val + '"');
                }
            }

            // Recursively creates the XML string for each
            // child nodes and appends it here with an
            // indentation
            var tmp = node.firstChild;

            if (tmp != null) {
                var temIndent = "";
                result.push('>');
                if (tmp.nodeType != mxConstants.NODETYPE_TEXT) {
                    temIndent = indent;
                    result.push('\n');
                }

                while (tmp != null) {
                    result.push(this.getPrettyXml(tmp, tab, indent
                        + tab));
                    tmp = tmp.nextSibling;
                }

                result.push(temIndent + '</' + node.nodeName + '>\n');
            } else {
                result.push('/>\n');
            }
        }
    }

    return result.join('');
};
/**
 *
 * @param key
 * @param cell
 * @returns {string|null}
 */
DesignerEditor.prototype.getStyleValue = function(key, cell) {
	var style = this.editor.graph.model.getStyle(cell);
	if (style != null) {
		var pairs = style.split(';');
		for (var i = 0; i < pairs.length; i++) {
			if (pairs[i].indexOf('=') != -1) {
				var styleValue = pairs[i].split("=");
				if(styleValue[0] == key){
					return styleValue[1];
				}
			}
		}
	}
	return null;
};
function isEdgeStraight(editor, cell, evt) {
	var graph = editor.graph;
	if(cell != null && cell.edge && graph.getSelectionCells().length == 1){
		var state = graph.view.getState(cell);
		if(mxUtils.getValue(state.style, "edgeStyle", null) == 'straightEdge'){
			return true;
		}
	}
	return false;
}
function isEdgeNotStraight(editor, cell, evt) {
	var graph = editor.graph;
	if(cell != null && cell.edge && graph.getSelectionCells().length == 1){
		var state = graph.view.getState(cell);
		if(mxUtils.getValue(state.style, "edgeStyle", null) != 'straightEdge'){
			return true;
		}
	}
	return false;
}
function canAddPoint(editor, cell, evt) {
	if(!isEdgeStraight(editor, cell, evt)){
		return false;
	}
	var graph = editor.graph;
	var handler = graph.selectionCellsHandler.getHandler(cell);
	var isWaypoint = false;

	if (handler instanceof mxEdgeHandler && handler.bends != null && handler.bends.length > 2)
	{
		var index = handler.getHandleForEvent(graph.updateMouseEvent(new mxMouseEvent(evt)));
		isWaypoint = index > 0 && index < handler.bends.length - 1;
	}
	return !isWaypoint;
}
function isEdgeSolidLine(editor, cell, evt) {
	return !isEdgeDottedLine(editor, cell, evt);
}
function isEdgeDottedLine(editor, cell, evt) {
	var graph = editor.graph;
	if(cell != null && cell.edge && graph.getSelectionCells().length == 1){
		var state = graph.view.getState(cell);
		if(mxUtils.getValue(state.style, mxConstants.STYLE_DASHED, null) == '1'){
			return true;
		}
	}
	return false;
}
DesignerEditor.prototype.changeSolidLine = function(editor) {
	var cell = editor.graph.getSelectionCell();
	if (flowUtils.notNull(cell) && cell.edge) {
		editor.graph.setCellStyles(mxConstants.STYLE_DASHED, null, [cell]);
	}
};
DesignerEditor.prototype.changeDottedLine = function(editor) {
	var cell = editor.graph.getSelectionCell();
	if (flowUtils.notNull(cell) && cell.edge) {
		editor.graph.setCellStyles(mxConstants.STYLE_DASHED, '1', [cell]);
	}
};