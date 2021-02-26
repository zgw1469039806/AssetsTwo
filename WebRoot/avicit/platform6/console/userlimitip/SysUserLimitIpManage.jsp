<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page import="avicit.platform6.api.sysshirolog.utils.SecurityUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,table,form";
	String appId = SessionHelper.getApplicationId();

	String username = SessionHelper.getLoginName(request);
	Boolean isAdmin = SecurityUtil.isAdministrator(username);
%>

<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "sysuserlimitIp/sysuserlimitip/sysUserLimitIpController/toSysUserLimitIpManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysUserLimitIp_button_add"
				permissionDes="添加">
				<a id="sysUserLimitIp_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysUserLimitIp_button_save"
				permissionDes="保存">
				<a id="sysUserLimitIp_save" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysUserLimitIp_button_del"
				permissionDes="删除">
				<a id="sysUserLimitIp_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			<!-- <div class="input-group form-tool-search">
				<input type="text" name="sysUserLimitIp_keyWord"
					id="sysUserLimitIp_keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="sysUserLimitIp_searchPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div> -->
			<div class="input-group-btn form-tool-searchbtn">
				<a id="sysUserLimitIp_searchAll" href="javascript:void(0)"
					class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span
					class="caret"></span></a>
			</div>
		</div>
	</div>
	<table id="sysUserLimitIpjqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">受限人:</th>
				<td width="39%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="userLimitUserId" name="userLimitUserId">
						<input class="form-control" placeholder="请选择用户" type="text"
							id="userLimitUserIdAlias" name="userLimitUserIdAlias"> <span
							class="input-group-addon"> <i
							class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
				<th width="10%">IP类型:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="limitTypeIpType" id="limitTypeIpType" title="0：IP点，1：IP段"
						isNull="true" lookupCode="PLATFORM_USER_LIMIT_IP_TYPE" /></td>
			</tr>
			<tr>
				<th width="10%">用户访问类型:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="limitUserType" id="limitUserType" title="分为用户不能访问；用户只能访问"
						isNull="true" lookupCode="PLATFORM_USER_LIMTI_TYPE" /></td>
				<!-- <th width="10%">开始IP:</th>
				<td width="39%"><input title="开始IP"
					class="form-control input-sm" type="text" name="userLimitIpFrom"
					id="userLimitIpFrom" /></td> -->
			</tr>
			<!-- <tr>
				<th width="10%">结束IP:</th>
				<td width="39%"><input title="结束IP"
					class="form-control input-sm" type="text" name="userLimitIpEnd"
					id="userLimitIpEnd" /></td>
			</tr> -->
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/console/userlimitip/js/SysUserLimitIp.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var isAdmin ="<%=isAdmin%>";
	var viewScopeType = '';
	if (isAdmin == "true") {
		viewScopeType = '';
	} else {
		viewScopeType = 'currentOrg';
	}

	//后台获取的通用代码数据
	var limitTypeIpTypeData = ${limitTypeIpTypeData};
	var limitUserTypeData = ${limitUserTypeData};
	var sysUserLimitIp;
	$(document).ready(
					function() {
						var dataGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 75,
							hidden : true
						}, {
							label : '<span style="color:#ff0000"> * </span>受限人',
							name : 'userLimitUserIdAlias',
							width : 150,
							editable: true,
							edittype : 'custom',
							editoptions : {
								custom_element : userElem,
								custom_value : userValue,
								forId : 'userLimitUserId',
								viewScope:viewScopeType,
								callBack: function (user) {
									var id = $("#sysUserLimitIpjqGrid").jqGrid('getGridParam','selrow');
									// var currentRowId = sysUserLimitIp.currentRowId;
									var rowData = $('#sysUserLimitIpjqGrid').jqGrid('getRowData', id);
									rowData.loginName=user.loginNames;
									rowData.userLimitUserIdAlias=user.usernames;
									rowData.userLimitUserId=user.userids;
									var userName = $(rowData.userLimitUserIdAlias);
									userName.find('#cellUseridAlias').attr('value',user.usernames);
									rowData.userName = userName.outerHTML;
									$('#sysUserLimitIpjqGrid').jqGrid('setCell', id,"loginName",user.loginNames);
								}
							}
						}, {
							label : '受限人id',
							name : 'userLimitUserId',
							width : 75,
							hidden : true,
							editable : true
						},{
							label : '<span style="color:#ff0000"> * </span>受限人账号',
							name : 'loginName',
							width : 150,
							editable : false

						}, {
							label : 'IP类型id',
							name : 'limitTypeIpType',
							width : 75,
							hidden : true
						}, {
							label : '<span style="color:#ff0000"> * </span>IP限制类型',
							name : 'limitTypeIpTypeName',
							width : 150,
							editable : true,
							edittype : "custom",
							editoptions : {
								custom_element : selectElem,
								custom_value : selectValue,
								forId : 'limitTypeIpType',
								value : limitTypeIpTypeData
							}
						}, {
							label : '用户访问类型id',
							name : 'limitUserType',
							width : 75,
							hidden : true
						}, {
							label : '<span style="color:#ff0000"> * </span>用户访问类型',
							name : 'limitUserTypeName',
							width : 150,
							editable : true,
							edittype : "custom",
							editoptions : {
								custom_element : selectElem,
								custom_value : selectValue,
								forId : 'limitUserType',
								value : limitUserTypeData
							}
						}, {
							label : '<span style="color:#ff0000"> * </span>开始IP',
							name : 'userLimitIpFrom',
							width : 150,
							editable : true
						}, {
							label : '结束IP',
							name : 'userLimitIpEnd',
							width : 150,
							editable : true
						} ];
						var searchNames = [];
						var searchTips = [];
						searchNames.push("userLimitIpFrom");
						searchTips.push("开始IP");
						searchNames.push("userLimitIpEnd");
						searchTips.push("结束IP");
						$('#sysUserLimitIp_keyWord').attr('placeholder',
								'请输入' + searchTips[0] + '或' + searchTips[1]);
						sysUserLimitIp = new SysUserLimitIp(
								'sysUserLimitIpjqGrid', '${url}',
								'searchDialog', 'form',
								'sysUserLimitIp_keyWord', searchNames,
								dataGridColModel);
						//添加按钮绑定事件
						$('#sysUserLimitIp_insert').bind('click', function() {
							sysUserLimitIp.insert();
						});
						//删除按钮绑定事件
						$('#sysUserLimitIp_del').bind('click', function() {
							sysUserLimitIp.del();
						});
						//保存按钮绑定事件
						$('#sysUserLimitIp_save').bind('click', function() {
							sysUserLimitIp.save();
						});
						//查询按钮绑定事件
						$('#sysUserLimitIp_searchPart').bind('click',
								function() {
									sysUserLimitIp.searchByKeyWord();
								});
						//打开高级查询框
						$('#sysUserLimitIp_searchAll').bind('click',
								function() {
									sysUserLimitIp.openSearchForm(this);
								});
						//回车键查询
						$('#sysUserLimitIp_keyWord').on('keydown', function(e) {
							if (e.keyCode == 13) {
								sysUserLimitIp.searchByKeyWord();
							}
						});
						$('#userLimitUserIdAlias').on('focus', function(e) {
							new H5CommonSelect({
								type : 'userSelect',
								idFiled : 'userLimitUserId',
								textFiled : 'userLimitUserIdAlias'
							});
							this.blur();
						});

					});
</script>
</html>