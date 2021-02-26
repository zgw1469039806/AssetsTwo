<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "ttt/bpmcatalog/bpmCatalogController/toBpmCatalogManage" -->
<title>运行流程实例</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="height:422px;">
		<table id="bpmProcinst"></table>
		<div id="bpmProcinstPager"></div>
	</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmSam/checkRunningProcess/js/BpmProcinst.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var bpmProcinst;
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="bpmProcinst.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
	}
	function getTraceButtons(cellvalue, options, rowObject){
		if(cellvalue==undefined || cellvalue==''){
			cellvalue=rowObject.procDefName;
			if(cellvalue==undefined || cellvalue==''){
				cellvalue="无";
			}
		}
		return '<a href="javascript:void(0)" onClick="bpmProcinst.processTrace(\''+rowObject.dbId+'\')">'+cellvalue+'</a>';
	}
	
	function processVariable(processInstanceId){
		bpmProcinst.processVariable(processInstanceId);
	}
	
	function endProcess(executionid){
		bpmProcinst.endProcess(executionid);
	}
	
	function bpm_operator_refresh(){
		bpmCatalog.clickNode();
	}


	$(document).ready(function() {
		var searchSubNames = new Array();
		var searchSubTips = new Array();
		var bpmProcinstGridColModel = [
			{
				label : 'dbId',
				name : 'dbId',
				key : true,
				hidden : true
			}
			,{
				label : 'executionId',
				name : 'executionId',
				hidden : true
			}
			, {
				label : '标题',
				name : 'title',
				width : 40,
				align : 'left',
				sortable : true,
				formatter : getTraceButtons
			}
			, {
				label : '申请日期',
				name : 'startDate',
				width : 60,
				align : 'center',
				sortable : true,
				formatter : formatDateTime
			}
			,{
				label : '状态',
				name : 'state',
				hidden : true
			}
			, {
				label : '状态',
				name : 'stateName',
				width : 25,
				align : 'left',
				sortable : true,
				formatter : function(cellvalue, options, rowObject) {
					if (rowObject.state == 'active') {
						return '流转中';
					} else if (rowObject.state == 'ended') {
						return '结束';
					} else if (rowObject.state == 'suspended') {
						return '挂起';
					}

				}
			}
			, {
				label : '处理人',
				name : 'assigneeName',
				width : 40,
				align : 'left',
				sortable : false
			}
		];
		bpmProcinst = new BpmProcinst('bpmProcinst', 'bpmSam/bpmn2jbpm/operation/getProcessInstanceByPage', "", bpmProcinstGridColModel, "", "", "", "", "","${param.pdid}");
		
		//关键字段查询按钮绑定事件
		$('#bpmProcinst_searchPart').bind('click', function() {
			bpmProcinst.searchByKeyWord();
		});
		$("#t_bpmProcinst").css("display", "none");
	});
</script>
</html>