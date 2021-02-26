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
<style type="text/css">
body {
	margin: 0;
	padding: 0;
}

</style>
<%
	String processInstanceId = "\'"+request.getParameter("processInstanceId")+"\'";//流程实例id
	String executionid = "\'"+request.getParameter("executionid")+"\'";
	String isHistory = request.getParameter("isHistory");
	String state = "\'"+request.getParameter("state")+"\'";
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!-- ControllerPath = "ttt/bpmcatalog/bpmCatalogController/toBpmCatalogManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body >

		<div id="toolbar_bpmWorkitem" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="bpmWorkitem_button_addPerformer" permissionDes="增加执行人">
					<a id="bpmWorkitem_button_addPerformer" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="增加执行人"> 增加执行人</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="bpmWorkitem_button_delPerformer" permissionDes="删除执行人">
					<a id="bpmWorkitem_button_delPerformer" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn  btn-sm" role="button"
						title="删除执行人"> 删除执行人</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="bpmWorkitem_button_addTransfer" permissionDes="增加传阅人">
					<a id="bpmWorkitem_button_addTransfer" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn  btn-sm" role="button"
						title="增加传阅人"> 增加传阅人</a>
				</sec:accesscontrollist>

				<sec:accesscontrollist hasPermission="3"
					domainObject="bpmWorkitem_button_delTransfer" permissionDes="删除传阅人">
					<a id="bpmWorkitem_button_delTransfer" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn  btn-sm" role="button"
						title="删除传阅人"> 删除传阅人</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="bpmWorkitem_button_addReader" permissionDes="增加读者">
					<a id="bpmWorkitem_button_addReader" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn  btn-sm" role="button"
						title="增加读者"> 增加读者</a>
				</sec:accesscontrollist>

				<sec:accesscontrollist hasPermission="3"
					domainObject="bpmWorkitem_button_delReader" permissionDes="删除读者">
					<a id="bpmWorkitem_button_delReader" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn  btn-sm" role="button"
						title="删除读者"> 删除读者</a>
				</sec:accesscontrollist>
			</div>
		</div>
		<table id="bpmWorkitem"></table>
		<div id="bpmWorkitemPager"></div>
	</div>
</body>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmmonitor/js/BpmWorkitem.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowButtons.js"></script>
<script type="text/javascript">

	var bpmWorkitem;
	var processInstanceId = <%=processInstanceId%>;
	var executionid = <%=executionid%>;
	var processState = <%=state%>;
	var isHistory = <%=isHistory%>;
	$(document).ready(function() {
		var bpmWorkitemGridColModel = [
			{
				name : 'dbid_',
				label : '工作项ID',
				width : 25,
				align : 'left',
				sortable : false
			},{
				label : 'execution_',
				name : 'execution_',
				hidden : true
			}
			, {
				name : 'task_title_',
				label : '工作项名称',
				width : 35,
				align : 'left',
				sortable : false
			}, {
				name : 'state_',
				label : '状态',
				width : 25,
				align : 'left',
				sortable : false,
				formatter : function(cellvalue, options, rowObject) {
					if(flowUtils.notNull(cellvalue)){
						if(cellvalue=='reader'){
							return "读者(reader)";
						}else if(cellvalue=='transmit'){
							return "传阅(transmit)";
						}else if(cellvalue=='completed'){
							return "已办(completed)";
						}else{
							return cellvalue;
						}
					}else{
						return "";
					}

				}
			}, {
				name : 'process_def_name_',
				label : '所属流程实例',
				width : 45,
				align : 'left',
				sortable : false
			}, {
				name : 'assignee_',
				label : '参与者ID',
				width : 45,
				align : 'left',
				sortable : false
			}, {
				name : 'assigneeName',
				label : '参与者名称',
				width : 35,
				align : 'left',
				sortable : false
			}, {
				name : 'assigneeDeptName',
				label : '参与者部门',
				width : 35,
				align : 'left',
				sortable : false
			}, {
				name : 'create_',
				label : '开始时间',
				width : 40,
				align : 'center',
				sortable : false,
				formatter : function(cellvalue, options, rowObject) {
					var openDate = cellvalue;
					if (openDate == undefined) {
						return '';
					}
					var newDate = new Date(openDate);
					return newDate.format("yyyy-MM-dd hh:mm:ss");
				}
			}, {
				name : 'end_',
				label : '完成时间',
				width : 40,
				align : 'center',
				sortable : false,
				formatter : function(cellvalue, options, rowObject) {
					var tempDate = rowObject.end_;
					if (tempDate == undefined) {
						return '';
					}
					var endDate = new Date(tempDate);
					return endDate.format("yyyy-MM-dd hh:mm:ss");
				}
			}, {
				name : 'create_',
				hidden : true
			},{
				name:'task_type_',
				hidden:true
			}
		];

		var url = 'platform/bpm/bpmConsoleAction/getProcessEntryTodoList.json?processInstanceId=' + processInstanceId;
		bpmWorkitem = new BpmWorkitem('bpmWorkitem',url,bpmWorkitemGridColModel,processInstanceId,executionid,processState);

		$('#bpmWorkitem_button_addPerformer').bind('click', function() {
			bpmWorkitem.addPerformer();
		});
		$('#bpmWorkitem_button_delPerformer').bind('click',function(){
			bpmWorkitem.delPerformer();
		});
		$('#bpmWorkitem_button_addReader').bind('click',function(){
			bpmWorkitem.addReader();
		});

		$('#bpmWorkitem_button_addTransfer').bind('click',function(){
			bpmWorkitem.addTransfer();
		});

		$('#bpmWorkitem_button_delReader').bind('click',function(){
			bpmWorkitem.delReader();
		});

		$('#bpmWorkitem_button_delTransfer').bind('click',function(){
			bpmWorkitem.delTransfer();
		});



		if('1'==isHistory){
			$('#bpmWorkitem_button_addPerformer').hide();
			$('#bpmWorkitem_button_delPerformer').hide();
		}

	});

	function bpm_operator_refresh(){
		bpmWorkitem.reLoad();
	}
</script>
</html>
