<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "phoneproject/portalimage/PortalImageController/PortalImageInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center'" style="background: #ffffff;">
		<div id="toolbarPortalImage" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalImage_button_add" permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="portalImage.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalImage_button_edit" permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="portalImage.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalImage_button_delete" permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="portalImage.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalImage_button_query" permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="portalImage.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgPortalImage"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarPortalImage',
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
					<th data-options="checkbox:true" width="220"></th>
					<th data-options="field:'imageName', halign:'center'" width="220">图片名称</th>
					<th data-options="field:'imagePath', halign:'center'" width="220">图片路径</th>
					<th data-options="field:'imageOrder', halign:'center'" width="220">显示顺序</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="overflow: auto; padding-bottom: 35px;">
		<form id="portalImage">
			<table style="padding-top: 10px; width: 600px; margin: 0 auto;">
				<tr>
					<td align="right">图片名称:</td>
					<td><input class="inputbox" style="width: 151px;" type="text" name="imageName" /></td>
					<td align="right">图片路径:</td>
					<td><input class="inputbox" style="width: 151px;" type="text" name="imagePath" /></td>
				</tr>
				<tr>
					<td align="right">显示顺序:</td>
					<td><input class="inputbox" style="width: 151px;" type="text" name="imageOrder" /></td>
				</tr>
			</table>
		</form>
		<div id="searchBtns">
			<a class="easyui-linkbutton" iconCls="" plain="false" onclick="portalImage.searchData();" href="javascript:void(0);">查询</a>
			<a class="easyui-linkbutton" iconCls="" plain="false" onclick="portalImage.clearData();" href="javascript:void(0);">清空</a>
			<a class="easyui-linkbutton" iconCls="" plain="false" onclick="portalImage.hideSearchForm();"
				href="javascript:void(0);">返回</a>
		</div>
	</div>
	<script src=" avicit/phoneproject/portalimage/js/PortalImage.js" type="text/javascript"></script>
	<script type="text/javascript">
		var portalImage;
		$(function() {
			portalImage = new PortalImage('dgPortalImage', '${url}',
					'searchDialog', 'portalImage');
		});
		function formateDate(value, row, index) {
			return portalImage.formate(value);
		}
		function formateDateTime(value, row, index) {
			return portalImage.formateTime(value);
		}
		//portalImage.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="portalImage.detail(\''
					+ row.id + '\');">' + value + '</a>';
		}
	</script>
</body>
</html>