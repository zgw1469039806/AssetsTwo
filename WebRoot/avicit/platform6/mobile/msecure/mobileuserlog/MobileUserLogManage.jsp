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
<!-- ControllerPath = "platform6/msecure/mobileuserlog/MobileUserLogController/MobileUserLogInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center'"
		style="background: #ffffff; height: 0px; padding: 0px; overflow: hidden;">
		<div id="toolbarMobileUserLog" class="datagrid-toolbar">
			<table>
				<tr>

					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileUserLog_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="mobileUserLog.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
					<!-- <td><a class="easyui-linkbutton" iconCls="icon-search"
						plain="true" onclick="selfDefQury.show();"
						href="javascript:void(0);">高级查询</a></td> -->
				</tr>
			</table>
		</div>
		<table id="dgMobileUserLog"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMobileUserLog',
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
						width="220">Id</th>
					<th data-options="field:'userId', halign:'center'" width="220">用户ID</th>
					<th data-options="field:'deviceId', halign:'center'" width="220">设备ID</th>
					<th data-options="field:'appVersionId', halign:'center'"
						width="220">版本ID</th>
					<th data-options="field:'type', halign:'center',formatter:logIndex,hidden:true" width="220">日志类型</th>
					<th data-options="field:'opContent', halign:'center'" width="220">日志内容</th>
					<th data-options="field:'isArchive', halign:'center',formatter:isOver, hidden:true" width="220">是否归档</th>
					<th data-options="field:'creationDate', halign:'center',formatter:formateDateTime" width="220">时间</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="width: 904px; height: 340px; display: none;">
		<form id="mobileUserLog">
			<table class="form_commonTable">
				<tr>
					<th width="10%">用户ID:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="userId" /></td>
					<th width="10%">设备ID:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="deviceId" /></td>
				</tr>
				<tr>
					<th width="10%">版本ID:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="appVersionId" /></td>
					<th width="10%">日志内容:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="opContent" /></td>
				</tr>
				<tr>
					<th width="10%">起始时间:</th>
					<td width="40%"><input class="easyui-datetimebox"
						style="width: 151px;" type="text" name="creationDate1" /></td>
							<th width="10%">结束时间:</th>
					<td width="40%"><input class="easyui-datetimebox"
						style="width: 151px;" type="text" name="creationDate2" /></td>
				</tr>
				<!-- 
				<tr>
					<th width="10%">日志类型:</th>
					<td width="40%">
						<select name="type" 
						class="easyui-combobox"
						data-options="width:151,editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						<option value=1>登录</option>
						</select>
					</td>
					<th width="10%">是否归档:</th>
					<td width="40%">
					<select name="isArchive" 
						class="easyui-combobox"
						data-options="width:151,editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						<option value=1>归档</option>
						<option value=0>未归档</option>
						</select>
					</td>
				</tr>
				 -->
				<tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns" class="datagrid-toolbar foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a class="easyui-linkbutton primary-btn"
						iconCls="" plain="false" onclick="mobileUserLog.searchData();"
						href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mobileUserLog.clearData();"
						href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mobileUserLog.hideSearchForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script
		src=" avicit/platform6/mobile/msecure/mobileuserlog/js/MobileUserLog.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var mobileUserLog;
		$(function() {
			mobileUserLog = new MobileUserLog('dgMobileUserLog', '${url}',
					'searchDialog', 'mobileUserLog');
			/////
			var array = [];

			var searchObject = {
				name : '用户ID',
				field : 'USER_ID',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '设备ID',
				field : 'DEVICE_ID',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '版本ID',
				field : 'APP_VERSION_ID',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '日志类型',
				field : 'TYPE',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '日志内容',
				field : 'OP_CONTENT',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '是否归档：归档，未归档',
				field : 'IS_ARCHIVE',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);
			///

			selfDefQury.init(array);
			selfDefQury.setQuery(function(param) {
				mobileUserLog.searchDataBySfn(param);
			});
		});
		function formateDate(value, row, index) {
			return mobileUserLog.formate(value);
		}
		function formateDateTime(value, row, index) {
			return mobileUserLog.formateDateTime(value);
		}
		//mobileUserLog.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="mobileUserLog.detail(\''
					+ row.id + '\');">' + value + '</a>';
		}
		function logIndex(value, row, index) {
			if (value == 1) {
				return "登录";
			}
		}
		function isOver(value, row, index) {
			if (value == 1) {
				return "归档";
			} else {
				return "未归档";
			}
		}
	</script>
</body>
</html>