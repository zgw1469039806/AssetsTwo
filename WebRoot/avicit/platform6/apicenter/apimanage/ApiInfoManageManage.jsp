<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/shiro.tld"%>
<%
	String importlibs = "common,tree,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "monitor/apicenter/monitorapiinfo/monitorApiInfoController/toMonitorApiInfoManage" -->
<title>API中心管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css"
	href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css" />
<link rel="stylesheet" type="text/css"
	href="static\css\platform\aceadmin\css\bootstrap-multiselect.min.css" />
<style>
.ui-jqgrid {
	margin-top: 10px
}

.head {
	
}

.serachLabel {
	left: 0
}

.ztree1 {
	margin: 0;
	padding: 5px;
	color: #333;
}

.ztree1 li {
	padding: 0;
	margin: 0;
	list-style: none;
	line-height: 21px;
	text-align: left;
	white-space: nowrap;
	outline: 0;
}

.ztree1 * {
	padding: 0;
	margin: 0;
	font-size: 12px;
}

.ztree1 li span.button.root_open {
	background-position: -104px -84px;
}

.ztree1 li span.button.switch {
	width: 21px;
	height: 21px;
}

.ztree1 li span.button {
	color: #2fad95;
	line-height: 21px;
	text-align: center;
}

.ztree1 li span.button {
	line-height: 0;
	margin: 0;
	width: 21px;
	height: 21px;
	display: inline-block;
	vertical-align: middle;
	border: 0 none;
	cursor: pointer;
	outline: none;
	background-color: transparent;
	background-repeat: no-repeat;
	background-attachment: scroll;
	background-image:
		url("static/h5/jquery-ztree/3.5.12/css/zTreeStyle/img/metro.png");
}

.ztree1 li a.curSelectedNode {
	padding-top: 0px;
	background-color: #e5e5e5;
	color: black;
	height: 21px;
	opacity: 0.8;
}

.ztree1 li a {
	padding-right: 3px;
	margin: 0;
	cursor: pointer;
	height: 21px;
	color: #333;
	background-color: transparent;
	text-decoration: none;
	display: inline-block;
}

.ztree1 li span.button.ico_open {
	background: none;
	vertical-align: initial;
}

.ztree1 li span.button.ico_open {
	margin-right: 2px;
	background-position: -147px -21px;
	vertical-align: top;
}

.appIcon_ico_docu {
	margin-right: 2px;
	background: url(./avicit/platform6/apicenter/apimanage/images/yingyong.png) no-repeat scroll 0px 2px transparent !important;
	vertical-align: top;
	*vertical-align: middle
}
.busDomainIcon_ico_docu {
	margin-right: 2px;
	background: url(./avicit/platform6/apicenter/apimanage/images/yewuyu.png) no-repeat scroll 0px 2px transparent !important;
	vertical-align: top;
	*vertical-align: middle
}
.busDomainIcon_ico_open{
	margin-right: 2px;
	background: url(./avicit/platform6/apicenter/apimanage/images/yewuyu.png) no-repeat scroll 0px 2px transparent !important;
	vertical-align: top;
	*vertical-align: middle
}
.busDomainIcon_ico_close{
	margin-right: 2px;
	background: url(./avicit/platform6/apicenter/apimanage/images/yewuyu.png) no-repeat scroll 0px 2px transparent !important;
	vertical-align: top;
	*vertical-align: middle
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,width:fixwidth(.2),onResize:function(a){$('#sysImpSheetTableResjqGrid').setGridWidth(a);$(window).trigger('resize');}" >
		<div class="row" style="margin: 5px;height:98%">
			<div id="_tree-center" data-options="region:'center',width:'100%'" 
				style="padding-right: 10px;height:100%">
				<ul id="_ztree" class="ztree" style="width: 100%;height:100%"></ul>
			</div>
		</div>
	</div>
	<div
		data-options="region:'center',onResize:function(a){$('#jqGrid').setGridWidth(a);$(window).trigger('resize');}">
		<div id="tableToolbar" class="toolbar">
			<div class="toolbar-left">
				<div class="input-group form-tool-search">
					<input type="text" name="monitorApiInfo_keyWord"
						id="monitorApiInfo_keyWord" style="width: 240px;"
						class="form-control input-sm" placeholder="请输入API名称"> <label
						id="monitorApiInfo_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="monitorApiInfo_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>

			</div>
			<div class="toolbar-right">
				<span
					style="height: 33px; line-height: 33px; font-size: 14px;">排序：</span>
				
					<span id="ApiInfo_searchAll" title="全部" style="color:blue;height: 33px; line-height: 33px; font-size: 14px;cursor:pointer">全部 </span> 
					<span id="ApiInfo_searchlatest" title="最新" style="height: 33px; line-height: 33px; font-size: 14px;cursor:pointer">最新 </span>
				

			</div>
		</div>
		<table id="monitorApiInfojqGrid"></table>
	</div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
	    <input  class="form-control input-sm" type="hidden" name="businessDomain" id="businessDomain" />
	    
		<table class="form_commonTable">
			<tr>
				<th width="15%">API名称:</th>
				<td width="34%"><input title="API名称"
					class="form-control input-sm" type="text" name="apiName"
					id="apiName" /></td>
				<th width="15%">服务编码:</th>
				<td width="34%"><input title="服务编码"
					class="form-control input-sm" type="text" name="serviceCode"
					id="serviceCode" /></td>
			</tr>
			<tr>
				<th width="15%">应用编码:</th>
				<td width="34%"><input title="应用编码"
					class="form-control input-sm" type="text" name="appCode"
					id="appCode" /></td>
				<th width="15%">责任部门:</th>
				<td width="34%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="deptName" name="deptName"> <input
							class="form-control" placeholder="责任部门" type="text"
							id="deptNameAlias" name="deptNameAlias"> <span
							class="input-group-addon"> <i
							class="glyphicon glyphicon-equalizer"></i>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="15%">应用名称:</th>
				<td width="34%"><input title="应用名称"
					class="form-control input-sm" type="text" name="appName"
					id="appName" /></td>
				<th width="15%">应用版本:</th>
				<td width="34%"><input title="应用版本"
					class="form-control input-sm" type="text" name="appVersion"
					id="appVersion" /></td>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/apicenter/apimanage/js/MonitorTree.js"
	type="text/javascript"></script>
<script src="avicit/platform6/apicenter/apimanage/js/apiOrganization.js"
	type="text/javascript"></script>
<script src="avicit/platform6/apicenter/apimanage/js/APICenter.js"
	type="text/javascript"></script>
</html>