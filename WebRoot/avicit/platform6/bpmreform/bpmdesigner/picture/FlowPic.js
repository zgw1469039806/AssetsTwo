var mxBasePath = "avicit/platform6/bpmreform/bpmdesigner/editors/mxgraph/src";
flowUtils.include("avicit/platform6/bpmreform/bpmdesigner/editors/mxgraph/mxClient.js");
flowUtils.include("avicit/platform6/bpmreform/bpmdesigner/editors/js/CountUtils.js");
flowUtils.include("avicit/platform6/bpmreform/bpmdesigner/editors/js/DesignerEditor.js");
flowUtils.include("avicit/platform6/bpmreform/bpmdesigner/picture/MyDesignerEditor.js");
var designerEditor = null;
var _iconType;
function initFlowPic(entryId, deploymentId, callback) {
	designerEditor = new MyDesignerEditor();
	//重写graph提示框
	mxUtils.alert = function(message) {
		flowUtils.warning(message);
	};
	//全局参数设置
	mxGraph.prototype.htmlLabels = true;
	/*mxGraph.prototype.isWrapping = function(cell) {
		return true;
	};*/
    mxGraph.prototype.collapseExpandResource = '';
	mxConstants.DEFAULT_HOTSPOT = 1;
	mxGraphHandler.prototype.guidesEnabled = true;
	mxGuide.prototype.isEnabledForEvent = function(evt) {
		return !mxEvent.isAltDown(evt);
	};
	mxEdgeHandler.prototype.snapToTerminals = true;
	//画布工具栏初始化及设置
	avicAjax.ajax({
		type : "POST",
		data : {
			entryId : entryId,
			deploymentId : deploymentId
		},
		url : "platform/bpm/business/getIconType",
		dataType : "json",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				mxObjectCodec.allowEval = true;
				var tempUrl = "";
				_iconType = result.iconType;
				if(result.iconType == "1"){
					tempUrl = "avicit/platform6/bpmreform/bpmdesigner/picture/config/new/workfloweditor.xml";
				}else{
					tempUrl = "avicit/platform6/bpmreform/bpmdesigner/picture/config/workfloweditor.xml";
					$(".uFlowKeyCss").hide();
					$(".uFlowKeyCss").next().hide();
				}
				var node = mxUtils.load(tempUrl).getDocumentElement();
				var editor = new mxEditor(node);
				mxObjectCodec.allowEval = false;
//				editor.graph.allowAutoPanning = true;
//				editor.graph.timerAutoScroll = true;
				//初始化数据
				designerEditor.setEditor(editor);
				editor.graph.addListener(mxEvent.CLICK, function(sender, evt) {
					var cell = evt.getProperty('cell');
					if (flowUtils.notNull(cell)) {
						var id = cell.id;
						var pid = cell.pid;
						if (flowUtils.notNull(pid)) {
							id = pid;
						}
						var node = designerEditor.myCellMap.get(id);
						if (flowUtils.notNull(node)) {
							if (typeof (node.actNodeClick) == "function") {
								node.actNodeClick();
							}
						}
					}
				});
				callback(designerEditor);
			}
		}
	});
	if(flowUtils.notNull(entryId)){
		$.ajax({
			type : "POST",
			data : {
				entryId : entryId
			},
			url : "platform/bpm/business/getParentprocess",
			dataType : "text",
			success : function(result) {
				if(flowUtils.notNull(result)){
					$("#bpmParentFlowPic").show();
					$("#bpmParentFlowPic").on("click", function(){
						var dialog = layer.open({
							type : 2,
							title: "父流程",
							area : [ "800px", "450px" ],
							content : "avicit/platform6/bpmreform/bpmdesigner/picture/picAndTracks.jsp?entryId=" + result
						});
						layer.full(dialog);
					});
				}
			}
		});
		if(typeof(_showBpmOpenFormBut) != "undefined"){
			$("#bpmOpenForm").show();
			$("#bpmOpenForm").on("click", function(){
				flowUtils.detail(entryId, "2");
			});
		}
	}
}
