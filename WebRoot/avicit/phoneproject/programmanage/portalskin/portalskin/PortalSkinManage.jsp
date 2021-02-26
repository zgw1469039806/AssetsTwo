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
<!-- ControllerPath = "phoneproject/programmanage/portalskin/portalskin/PortalSkinController/PortalSkinInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div style="background: #ffffff; height: 50%">
		<div id="toolbarPortalSkin" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_portalSkin_button_add" permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="portalSkin.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_portalSkin_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="portalSkin.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_portalSkin_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="portalSkin.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<%-- <sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_portalSkin_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="portalSkin.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist> --%>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalSkin_button_using" permissionDes="启用">					
						<td><a class="easyui-linkbutton" plain="true" onclick="portalSkin.change('_0');" href="javascript:void(0);">启用</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalSkin_button_forbidden" permissionDes="禁用">					
						<td><a class="easyui-linkbutton" plain="true" onclick="portalSkin.change('_1');" href="javascript:void(0);">禁用</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgPortalSkin"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarPortalSkin',
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
						width="220">主键</th>
					<th data-options="field:'skinName', halign:'center'" width="220">皮肤名称</th>
					<th data-options="field:'skinCode', halign:'center'" width="220">皮肤代码</th>
					<th data-options="field:'skinImg', halign:'center'" width="220">皮肤图标地址</th>
					<!-- 
					<th data-options="field:'skinResponsibles', halign:'center'"
						width="220">责任人</th>
					<th data-options="field:'skinDesc', halign:'center'" width="220">皮肤描述</th>
					-->
					<th data-options="field:'skinState', halign:'center'">皮肤状态</th>
					<th data-options=" field:'attribute01',halign:'center',formatter:formateCaoZuo">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	<div style="height: 50%; background: #f5fafe;">
		<div id="toolbarportalSkinVersion" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_portalSkinVersion_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true"
							onclick="portalSkinVersion.insert(portalSkin.getSelectID());"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_portalSkinVersion_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="portalSkinVersion.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_portalSkinVersion_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="portalSkinVersion.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalSkin_button_using" permissionDes="启用">					
						<td><a class="easyui-linkbutton" plain="true" onclick="portalSkinVersion.change('_0');" href="javascript:void(0);">启用</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_portalSkin_button_forbidden" permissionDes="禁用">					
						<td><a class="easyui-linkbutton" plain="true" onclick="portalSkinVersion.change('_1');" href="javascript:void(0);">禁用</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id='dgportalSkinVersion' class="easyui-datagrid"
			data-options="
    		fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			idField :'id',
			toolbar:'#toolbarportalSkinVersion',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			method:'get',
			pagination:true,
            pageSize:dataOptions.pageSize,
            pageList:dataOptions.pageList,
			striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">主键</th>
					<th data-options="field:'skinVersionName', halign:'center'"
						width="220">皮肤版本名称</th>
					<!-- <th data-options="field:'skinId', halign:'center'" width="220">应用皮肤表外键</th> -->
					<!-- 
					<th data-options="field:'skinVersionEntrance', halign:'center'"
						width="220">皮肤入口地址</th>
					<th data-options="field:'skinVersionOpenMode', halign:'center'"
						width="220">打开方式</th>
					-->
					<th data-options="field:'skinVersionManifest', halign:'center'"
						width="220">STATE配置文件</th>
					<!-- 
					<th data-options="field:'skinVersionModuleName', halign:'center'"
						width="220">包名称</th>
					<th data-options="field:'skinVersionDependance', halign:'center'"
						width="220">依赖包</th>
					 -->
					<th data-options="field:'skinVersionUrl', halign:'center'"
						width="220">皮肤版本地址</th>
					<!-- <th data-options="field:'skinVersionDesc', halign:'center'"
						width="220">应用皮肤版本描述</th> -->
					<th data-options="field:'skinVersionIsNew', halign:'center'">是否最新版本</th>
					<th data-options="field:'skinVersionState', halign:'center'">版本状态</th>
					<th data-options=" field:'attribute01',halign:'center',formatter:formateVersionCaoZuo">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="overflow: auto; padding-bottom: 35px;">
		<form id="portalSkin">
			<table style="padding-top: 10px; width: 600px; margin: 0 auto;">
				<tr>
					<td align="right">皮肤名称:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="skinName" /></td>
					<td align="right">皮肤代码（唯一性标识）:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="skinCode" /></td>
				</tr>
				<tr>
					<td align="right">皮肤图标:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="skinImg" /></td>
					<td align="right">皮肤责任人（多选）:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="skinResponsibles" /></td>
				</tr>
				<tr>
					<td align="right">皮肤描述:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="skinDesc" /></td>
					<td align="right">皮肤状态(0 启用；1 禁用):</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="skinState" /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns">
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="portalSkin.searchData();" href="javascript:void(0);">查询</a>
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="portalSkin.clearData();" href="javascript:void(0);">清空</a>
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="portalSkin.hideSearchForm();" href="javascript:void(0);">返回</a>
		</div>
	</div>
	<script
		src=" avicit/phoneproject/programmanage/portalskin/portalskin/js/PortalSkin.js"
		type="text/javascript"></script>
	<script
		src=" avicit/phoneproject/programmanage/portalskin/portalskin/js/PortalSkinVersion.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var portalSkin;
		var portalSkinVersion;
		$(function() {
			portalSkin = new PortalSkin('dgPortalSkin', '${url}',
					'searchDialog', 'portalSkin');

			portalSkin.setOnLoadSuccess(function() {
				portalSkinVersion = new PortalSkinVersion(
						'dgportalSkinVersion', '${surl}');
			});
			portalSkin.setOnSelectRow(function(rowIndex, rowData, id) {
				portalSkinVersion.loadByPid(id);
			});

			portalSkin.init();

		});
		function formateDate(value, row, index) {
			return portalSkin.formate(value);
		}
		function formateDateTime(value, row, index) {
			return portalSkin.formateTime(value);
		}
		//portalSkin.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="portalSkin.detail(\''
					+ row.id + '\');">' + value + '</a>';
		}
		function formateCaoZuo(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="portalSkin.del(\''+ row.id + '\',\'' + row.skinState + '\' );">' + value+ '</a>';
		}
		function formateVersionCaoZuo(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="portalSkinVersion.del(\''+ row.id+ '\',\''+ row.skinVersionState+ '\' );">'+ value + '</a>';
		}
	</script>
</body>
</html>