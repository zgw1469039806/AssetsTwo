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
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
 <script src="avicit/platform6/mobile/msecure/mobileconfig/mobilepushconfig/js/MobilePushConfig.js" type="text/javascript"></script>
	<script type="text/javascript">
		var mobilePushConfig;
		$(function(){
			mobilePushConfig= new MobilePushConfig('dgMobilePushConfig','${url}','searchDialog','mobilePushConfig');
																																																																																																																																																																			});
		function formateDate(value,row,index){
			return mobilePushConfig.formate(value);
		}
		function formateDateTime(value,row,index){
			return mobilePushConfig.formateTime(value);
		}
		//mobilePushConfig.detail(\''+row.id+'\')
		function formateHref(value,row,inde){
			return '<a href="javascript:void(0);" onclick="mobilePushConfig.detail(\''+row.id+'\');">'+value+'</a>';
		}
	</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center'" style="background:#ffffff;height:0;">
		<div id="toolbarMobilePushConfig" class="datagrid-toolbar">
		 	<table>
		 		<tr>
		 		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobilePushConfig_button_add" permissionDes="添加">
					<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="mobilePushConfig.insert();" href="javascript:void(0);">添加</a></td>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobilePushConfig_button_edit" permissionDes="编辑">
					<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="mobilePushConfig.modify();" href="javascript:void(0);">编辑</a></td>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobilePushConfig_button_delete" permissionDes="删除">
					<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="mobilePushConfig.del();" href="javascript:void(0);">删除</a></td>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobilePushConfig_button_query" permissionDes="查询">	
					<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="mobilePushConfig.openSearchForm();" href="javascript:void(0);">查询</a></td>
				</sec:accesscontrollist>		
				</tr>
		 	</table>
	 	</div>
	 	<table id="dgMobilePushConfig"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMobilePushConfig',
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
					<th data-options="field:'id', halign:'center',checkbox:true" width="220">ID</th>
					<th data-options="field:'pushName', halign:'center'" width="220">推送名称</th>
					<th data-options="field:'pushUrl', halign:'center'" width="220">推送URL</th>
					<th data-options="field:'pushApp', halign:'center'" width="220">推送应用</th>
					<th data-options="field:'description', halign:'center'" width="220">描述</th>
																																																																																</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" style="overflow:auto;padding-bottom:35px;width: 904px;height:340px;">
		<form id="mobilePushConfig">
			<table class="form_commonTable">
				<tr>
					<td width="15%">推送名称:</td>
					<td width="35%"><input class="easyui-validatebox" type="text"
						name="pushName" /></td>
					<td width="15%">推动URL:</td>
					<td width="35%"><input class="easyui-validatebox" type="text"
						name="pushUrl" /></td>
				</tr>
				<tr>
					<td>推动应用:</td>
					<td><input class="easyui-validatebox" type="text"
						name="pushApp" /></td>
				</tr>
			</table>
		</form>
		<div id="searchBtns" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td  align="right">
						<a class="easyui-linkbutton primary-btn" plain="false" onclick="mobilePushConfig.searchData();" href="javascript:void(0);">查询</a>
			    		<a class="easyui-linkbutton" plain="false" onclick="mobilePushConfig.clearData();" href="javascript:void(0);">清空</a>
			    		<a class="easyui-linkbutton" plain="false" onclick="mobilePushConfig.hideSearchForm();" href="javascript:void(0);">返回</a>
					</td>
				</tr>
			</table>
		</div>
		
  </div>
 
</body>
</html>