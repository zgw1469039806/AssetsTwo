<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "recruit/recruitmgr/mdatask/MdaTaskController/MdaTaskInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var mdaTask;
	$(function() {
		mdaTask = new MdaTask('dgMdaTask', '${url}', 'searchDialog', 'mdaTask');
		/////
		var array = [];

		var searchObject = {
			name : 'ORG_IDENTITY',
			field : 'ORG_IDENTITY',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'TASKNAME',
			field : 'TASKNAME',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'CRAWLTYPE',
			field : 'CRAWLTYPE',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'CRAWLCONFIGID',
			field : 'CRAWLCONFIGID',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'TIMEOUTMILLIS',
			field : 'TIMEOUTMILLIS',
			type : 1,
			dataType : 'number'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'STARTTIME',
			field : 'STARTTIME',
			type : 1,
			dataType : 'date'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'FINISHTIME',
			field : 'FINISHTIME',
			type : 1,
			dataType : 'date'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'PROGRESS',
			field : 'PROGRESS',
			type : 1,
			dataType : 'number'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'MSG',
			field : 'MSG',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'FLAG',
			field : 'FLAG',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'OUTPUTDATA',
			field : 'OUTPUTDATA',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'PROPS',
			field : 'PROPS',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'RUNSTATUS',
			field : 'RUNSTATUS',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'CRAWLCONFIGSNAPSHOT',
			field : 'CRAWLCONFIGSNAPSHOT',
			type : 1,
			dataType : 'number'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'TASKLEVEL',
			field : 'TASKLEVEL',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);

		var searchObject = {
			name : 'CLASSIFYIDS',
			field : 'CLASSIFYIDS',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);
		///

		selfDefQury.init(array);
		selfDefQury.setQuery(function(param) {
			mdaTask.searchDataBySfn(param);
		});
	});
	function formateDate(value, row, index) {
		return mdaTask.formate(value);
	}
	function formateDateTime(value, row, index) {
		return mdaTask.formateDateTime(value);
	}
	//mdaTask.detail(\''+row.id+'\')
	function formateHref(value, row, inde) {
		return '<a href="javascript:void(0);" onclick="mdaTask.detail(\''
				+ row.id + '\');">' + value + '</a>';
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center'"
		style="background: #ffffff; height: 0px; padding: 0px; overflow: hidden;">
		<div id="toolbarMdaTask" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaTask_button_delete" permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mdaTask.del();" href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaTask_button_query" permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="mdaTask.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgMdaTask"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMdaTask',
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">ID</th>
					<th data-options="field:'orgIdentity', halign:'center'" width="220" hidden="true">ORG_IDENTITY</th>

					<th data-options="field:'taskname', halign:'center'" width="220">任务名称</th>

					<th data-options="field:'tasklevel', halign:'center'" width="220">任务优先级</th>
					
					<th data-options="field:'classifyids', halign:'center'" width="220">分类</th>

					<th data-options="field:'crawlconfigid', halign:'center'"
						width="220">采集项名称</th>
						
					<th data-options="field:'crawltype', halign:'center'" width="220">采集类型</th>
					
					<th data-options="field:'runstatus', halign:'center'" width="220">采集结果</th>
					
					<th	data-options="field:'starttime', halign:'center',formatter:formateDate"
						width="220">执行时间</th>

					<th data-options="field:'timeoutmillis', halign:'center'"
						width="220" hidden="true">TIMEOUTMILLIS</th>

					<th data-options="field:'finishtime', halign:'center',formatter:formateDate"
						width="220" hidden="true">FINISHTIME</th>
					<th data-options="field:'progress', halign:'center'" width="220" hidden="true">PROGRESS</th>

					<th data-options="field:'msg', halign:'center'" width="220" hidden="true">MSG</th>

					<th data-options="field:'flag', halign:'center'" width="220" hidden="true">FLAG</th>

					<th data-options="field:'outputdata', halign:'center'" width="220" hidden="true">OUTPUTDATA</th>

					<th data-options="field:'props', halign:'center'" width="220" hidden="true">PROPS</th>

					<th data-options="field:'crawlconfigsnapshot', halign:'center'"
						width="220" hidden="true">CRAWLCONFIGSNAPSHOT</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="width: 904px; height: 340px; display: none;">
		<form id="mdaTask">
			<table class="form_commonTable">
				<tr>
					<th width="10%">任务名称:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="taskname" /></td>
					<th width="10%">任务优先级:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="tasklevel" /></td>
				</tr>
				<tr>
					<th width="10%">分类:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="classifyids" /></td>
					<th width="10%">采集项名称:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="crawlconfigid" /></td>					
				</tr>
				<tr>
					<th width="10%">采集类型:</th>
					<!-- <td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="crawltype" /></td> -->
					<td width="39%"><pt6:syslookup name="crawltype" id="crawltype"
						title="采集类型" isNull="false" lookupCode="MDA_ITEMTYPE"
						dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"></pt6:syslookup></td>
					<th width="10%">采集结果:</th>
					<!-- <td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="runstatus" /></td> -->
					<td width="39%"><pt6:syslookup name="runstatus" id="runstatus"
						title="采集结果" isNull="false" lookupCode="MDA_RUNSTATUS"
						dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel"></pt6:syslookup></td>
				</tr>
				<tr>
					<th width="10%">执行时间从:</th>
					<td width="40%"><input name="starttimeBegin"
						id="starttimeBegin" class="easyui-datebox" editable="false" />
					<th width="10%">执行时间(至):</th>
					<td><input name="starttimeEnd" id="starttimeEnd"
						class="easyui-datebox" editable="false" /></td>
				</tr>
			</table>
		</form>
		<div id="searchBtns" class="datagrid-toolbar foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a class="easyui-linkbutton primary-btn"
						iconCls="" plain="false" onclick="mdaTask.searchData();"
						href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mdaTask.clearData();"
						href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mdaTask.hideSearchForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script src=" avicit/platform6/mda_easyui/mdatask/js/MdaTask.js" type="text/javascript"></script>
</body>
</html>