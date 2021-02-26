<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form,fileupload,table";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>流程设计</title>
<script type="text/javascript">
var consoleFlag = "_console";//定义全局变量用于区分前后台
</script>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link href="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/theme.css" rel="stylesheet">
<link href="avicit/platform6/bpmreform/bpmdesigner/editors/js/common/common.css" rel="stylesheet">
<script>
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
	//全局变量
	var mxBasePath = "avicit/platform6/bpmreform/bpmdesigner/editors/mxgraph/src";
	//记录主键，已发布的取得事lob表主键
	var _id = "${id}";
	//类型，1是未发布，2是已发布，3是新建
	var _type = "${type}";
	//初始化泳道
	var _swimlane = "${swimlane}";
	//目录
	var _catalog = "${catalog}";
	//pdid
	var _pdId = "${pdId}";
	//deployId
	var _deployId = "${deployId}";
	//流程名称，新建时使用
	var _name = "${name}";
	//
	var _bmpsName = "${name}";
	//
	var _iconType = "${iconType}";//1是新图元，2是旧图元
	//是否自由流程，1标识固定流程，2标识自由流程
	var _isUflow = "${isUflow}";
	//拟稿节点能不能配置参与者
	var _needfirstuser = "${needfirstuser}";
	//网安项目定制，流程数据同步自定义js路径
	var _processDataSynJs = "${processDataSynJs}";
	//保存修改前的process对象,加载流程时存储，网安保存同步日志时比对使用
	var _oldProcess;
	//网安项目定制，路由条件添加或删除调用的自定义js路径
	var _routConditionChangeJs = "${routConditionChangeJs}";
</script>
<style type="text/css" media="screen">
div.base {
	position: absolute;
	overflow: hidden;
}

#toolbar_div {
	left: 5px;
	top: 60px;
	width: 78px;
}

#property_div {
	right: 5px;
	top: 60px;
	width: 320px;
}

#graph {
	left: 93px;
	right: 334px;
	top: 60px;
	bottom: 10px;
	overflow: auto;
	background: url('avicit/platform6/bpmreform/bpmdesigner/editors/images/grid.gif');
	border-style: solid;
	border-color: #F2F2F2;
	border-width: 1px;
	-webkit-box-shadow: 0px 0px 5px #999999;
	-moz-box-shadow: 0px 0px 5px #999999;
	box-shadow: 0px 0px 5px #999999;
}
</style>
</head>
<body onload="init();" style="overflow-x:hidden;">
	<div id="navbar" class="navbar ace-save-state" style="background-color:#FFF">
		<div class="navbar-container ace-save-state" id="navbar-container" >
			<div id="header-title" class="navbar-header pull-left" style="padding-top:2px;padding-left:10px">
					<h4 id="formName">${bpmNav}(${isUflow == 2 ? "自由流程" : "固定流程" })</h4>
			</div>
			<div class="navbar-buttons navbar-header pull-right" style="padding-top:10px;">
				<div class="navbar-form navbar-left" >
					<span style="color: #58a9ff;"> <i class="icon iconfont icon-Preservation" id="saveBut" title="保存"></i>
					</span>
					<c:if test="${type == 2 && isUflow == 1}">
						<span style="color: #58a9ff;"> <i class="icon iconfont icon-Save" id="saveToNewBut" title="保存为新版本"></i>
						</span>
					</c:if>
					<c:if test="${type == 1 || type == 3}">
						<span style="color: #58a9ff;"> <i class="icon iconfont icon-baocunfabu" id="sendXml" title="保存并发布"></i>
						</span>
					</c:if>
					<span style="border-left: 1px solid #B5B5B5;padding-bottom: 0px;padding-top: 7px;"> </span>
					<span style="color: #B5B5B5;"> <i class="icon iconfont icon-simulation" id="simulation" title="模拟"></i>
					</span>
					<span style="color: #B5B5B5;"> <i class="icon iconfont icon-Release" id="showProcessBut" title="源文件"></i>
					</span>
					<span style="color: #B5B5B5;"> <i class="icon iconfont icon-setting" id="changeIconType" title="切换图标"></i>
					</span>
				</div>
			</div>
		</div>
	</div>

	<div class="panel panel-primary base" id="toolbar_div">
		<div class="panel-heading">工具栏</div>
		<div class="panel-body" style="height:550px;padding: 8px 0px 0px 8px;">
			<div id="toolbar"></div>
		</div>
	</div>
	<div class="panel panel-primary base" id="property_div">
		<div class="panel-heading">属性</div>
		<div class="panel-body" style="height:550px;">
			<div class="twoTabNav" id="propMainDiv">
				<ul class="nav nav-tabs">
					<li class="active" style="width:50%;text-align:center;"><a href="javascript:void(0);">全局</a></li>
					<li style="width:50%;text-align:center;"><a href="javascript:void(0);">节点</a></li>
				</ul>
				<ul class="tab-cont">
					<li class="active" id="homeDiv"></li>
					<li id="profileDiv"></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="base" id="graph"></div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<%@ include file="template/Custom.html"%>
	<%@ include file="template/Rules.html"%>
	<%@ include file="template/Decision.html"%>
	<%@ include file="template/End.html"%>
	<%@ include file="template/Foreach.html"%>
	<%@ include file="template/Fork.html"%>
	<%@ include file="template/Java.html"%>
	<%@ include file="template/Jms.html"%>
	<%@ include file="template/Join.html"%>
	<%@ include file="template/Process.html"%>
	<%@ include file="template/Sql.html"%>
	<%@ include file="template/Start.html"%>
	<%@ include file="template/State.html"%>
	<%@ include file="template/Subprocess.html"%>
	<%@ include file="template/Task.html"%>
	<%@ include file="template/Transition.html"%>
	<%@ include file="template/Ws.html"%>
	<%@ include file="template/Swimlane.html"%>
	<%@ include file="template/Text.html"%>
	<%@ include file="template/Rest.html"%>

	<script type="text/javascript" src="static/js/platform/component/common/base64.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/NodeEvent.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/BpmDocUploader.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/mxgraph/mxClient.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/common/common.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/webservice/js/webservice.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/prop.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/CountUtils.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/DesignerEditor.js"></script>
	<script type="text/javascript" src="avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/BpmAuthControl.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/FormAuthTpl/FormAuth.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ProcessVariable/ProcessVariable.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/MethodAndClass/MethodAndClass.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/SubProcess/SubProcess.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ParameterInAndOut/ParameterInAndOut.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/SQLQueryParameter/SQLQueryParameter.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/JMSCollection/JMSCollection.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/FormFieldParameter/FormFieldParameter.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/TransitionTimeOut/TransitionTimeOut.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ExprConfig/ExprConfig.js"></script>
	<script type="text/javascript" src="avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.js"></script>
    <script type="text/javascript" src="avicit/platform6/eform/formdesign/select/selectDbColumnName/selectDbColumnName.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/FieldRelationControl/FieldRelationControl.js"></script>
	<script type="text/javascript">

		$(function () {
			$(window).on('resize', function() {
				resizeHeaderTitle();
			});

			resizeHeaderTitle();

			function resizeHeaderTitle() {
				$("#header-title").css("width", document.body.clientWidth - 240)
			}
		});

		var designerEditor = new DesignerEditor();
		if(flowUtils.notNull(_processDataSynJs)){
			//flowUtils.include("avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ProcessDataSynchronization/ProcessDataSynchronization.js");
			flowUtils.include(_processDataSynJs);
		}
		if(flowUtils.notNull(_routConditionChangeJs)){
			flowUtils.include(_routConditionChangeJs);
		}
		$("#simulation").on("click", function() {
			if(_pdId == ""){
				flowUtils.warning("未发布的模板不能模拟");
				return;
			}
			flowUtils.openOnDialog("platform/bpm/business/start?simulation=1&defineId=" + _pdId, "流程模拟");
		});
		//按钮绑定事件
		$("#saveBut").on("click", function() {
			designerEditor.save_xml();
		});
		$("#saveToNewBut").on("click", function() {
			designerEditor.saveToNew_xml();
		});
		$("#sendXml").on("click", function() {
			designerEditor.send_xml();
		});
		$("#showProcessBut").on("click", function() {
			var tempIndex = layer.open({
				type : 1,
				area : [ '100%', '100%' ],
				/*content : "<textarea style='height:99%;width:100%;' disabled>" + designerEditor.showProcess() + "</textarea>"*/
                content : "<textarea style='height:99%;width:100%;' readonly>" + designerEditor.showProcess() + "</textarea>"
			});
			layer.full(tempIndex);
		});
		$("#changeIconType").on("click", function() {
			if(_iconType == "1") {
				_iconType = "2";
			}else {
				_iconType = "1";
			}
			designerEditor = new DesignerEditor();
			$("#graph").empty();
			$("#toolbar").empty();
			$(".temp").remove();
			init();
		});
		//重写graph提示框
		mxUtils.alert = function(message) {
			flowUtils.warning(message);
		};
		//全局参数设置
		//最多记录10次操作，undo
		mxUndoManager.prototype.size = 10;
		mxGraph.prototype.htmlLabels = true;
		/*mxGraph.prototype.isWrapping = function(cell) {
			return true;
		};*/
		mxConstants.DEFAULT_HOTSPOT = 1;
		mxGraphHandler.prototype.guidesEnabled = true;
		mxGuide.prototype.isEnabledForEvent = function(evt) {
			return !mxEvent.isAltDown(evt);
		};
		mxEdgeHandler.prototype.snapToTerminals = true;

        mxElbowEdgeHandler.prototype.getTooltipForNode = function(node) {
           return null;
        };

		function init() {
			//画布工具栏初始化及设置
			mxObjectCodec.allowEval = true;
			var tempUrl = "";
			if (_iconType == "1") {
				//新图元
				tempUrl = "avicit/platform6/bpmreform/bpmdesigner/editors/config/new/workfloweditor.xml";
			} else {
				tempUrl = "avicit/platform6/bpmreform/bpmdesigner/editors/config/workfloweditor.xml";
			}
			var node = mxUtils.load(tempUrl).getDocumentElement();
			var editor = new mxEditor(node);
			mxObjectCodec.allowEval = false;
			editor.graph.allowAutoPanning = true;
			editor.graph.timerAutoScroll = true;
			// 添加cell后监听
			editor.graph.addListener(mxEvent.CELLS_ADDED, function(sender, evt) {
				var cells = evt.getProperty('cells');
				designerEditor.addCell(cells[0]);
			});
			// 删除cell监听
			editor.graph.addListener(mxEvent.REMOVE_CELLS, function(sender, evt) {
				var cells = evt.getProperty('cells');
				designerEditor.removeCells(cells);
			});
			// 选择变化
			editor.graph.getSelectionModel().addListener(mxEvent.CHANGE, function(sender) {
				designerEditor.changeSelected();
			});
			// 双击事件
			editor.graph.addListener(mxEvent.DOUBLE_CLICK, function(sender, evt) {
				var cell = evt.getProperty('cell');
				designerEditor.doubleClickCell(cell);
			});
			//自定义事件
			editor.addAction('goLeft', function(editor) {
				designerEditor.goLeft(editor);
			});
			editor.addAction('goUp', function(editor) {
				designerEditor.goUp(editor);
			});
			editor.addAction('goRight', function(editor) {
				designerEditor.goRight(editor);
			});
			editor.addAction('goDown', function(editor) {
				designerEditor.goDown(editor);
			});
			editor.addAction('autoLayout', function(editor) {
				designerEditor.autoLayout(editor);
			});
			editor.addAction('changeEdgeStyle1', function(editor) {
				designerEditor.changeEdgeStyle1(editor);
			});
			editor.addAction('changeEdgeStyle2', function(editor) {
				designerEditor.changeEdgeStyle2(editor);
			});
			editor.addAction('addWayPoint', function(editor) {
				designerEditor.addWayPoint(editor);
			});
			editor.addAction('clearWaypoints', function(editor) {
				designerEditor.clearWaypoints(editor);
			});
			editor.addAction('comWidth', function(editor) {
				designerEditor.comWidth(editor);
			});
			editor.addAction('comHeight', function(editor) {
				designerEditor.comHeight(editor);
			});
			editor.addAction('changeDottedLine', function(editor) {
				designerEditor.changeDottedLine(editor);
			});
			editor.addAction('changeSolidLine', function(editor) {
				designerEditor.changeSolidLine(editor);
			});
			$("#toolbar").find("img[src='avicit/platform6/bpmreform/bpmdesigner/editors/images/16/gateway_exclusive.png']").css("visibility", "hidden");
			//初始化数据
			designerEditor.setEditor(editor);
			designerEditor.init();
		}
	</script>
</body>
</html>
