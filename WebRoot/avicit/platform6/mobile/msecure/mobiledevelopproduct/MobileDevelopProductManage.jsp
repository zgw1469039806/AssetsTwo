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
<!-- ControllerPath = "platform6/msecure/mobiledevelopproduct/MobileDevelopProductController/MobileDevelopProductInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
	<script
		src=" avicit/platform6/mobile/msecure/mobiledevelopproduct/js/MobileDevelopProduct.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var mobileDevelopProduct;
		$(function(){
			mobileDevelopProduct= new MobileDevelopProduct('dgMobileDevelopProduct','${url}','searchDialog','mobileDevelopProduct');
																																																																																																																																																																																																																																												});
		function formateDate(value,row,index){
			return mobileDevelopProduct.formate(value);
		}
		function formateDateTime(value,row,index){
			return mobileDevelopProduct.formateTime(value);
		}
		//mobileDevelopProduct.detail(\''+row.id+'\')
		function formateHref(value,row,inde){
			return '<a href="javascript:void(0);" onclick="mobileDevelopProduct.detail(\''+row.id+'\');">'+value+'</a>';
		}
      	</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center'" style="background:#ffffff;height:0;">
		<div id="toolbarMobileDevelopProduct" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileDevelopProduct_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="mobileDevelopProduct.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileDevelopProduct_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mobileDevelopProduct.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileDevelopProduct_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mobileDevelopProduct.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileDevelopProduct_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="mobileDevelopProduct.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgMobileDevelopProduct"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMobileDevelopProduct',
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
					<th data-options="field:'platform', halign:'center'" width="220">设备系统</th>
					<th data-options="field:'certType', halign:'center'" width="220">证书类型</th>
					<th data-options="field:'password', halign:'center'" width="220">证书密码</th>
					<th data-options="field:'remark', halign:'center'" width="220">备注</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="width: 904px;height:340px;display:none;">
		<form id="mobileDevelopProduct">
			<table class="form_commonTable">
				<tr>
					<th width="10%">设备系统:
					</td>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="platform" /></td>
					<th width="10%">证书类型:
					</td>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="certType" /></td>
				</tr>
			</table>
		</form>
		<div id="searchBtns" class="datagrid-toolbar foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a class="easyui-linkbutton primary-btn"
						iconCls="" plain="false"
						onclick="mobileDevelopProduct.searchData();"
						href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
						iconCls="" plain="false"
						onclick="mobileDevelopProduct.clearData();"
						href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
						iconCls="" plain="false"
						onclick="mobileDevelopProduct.hideSearchForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
		                                          
</body>
</html>