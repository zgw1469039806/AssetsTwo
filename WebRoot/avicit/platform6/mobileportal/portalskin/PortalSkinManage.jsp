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
<!-- ControllerPath = "avicit/platform6/portalskin/controller/NewPortalSkinController/toPortalSkinManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div
		data-options="region:'center',onResize:function(a){$('#portalSkin').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_portalSkin" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_portalSkin_button_add"
					permissionDes="主表添加">
					<a id="portalSkin_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_portalSkin_button_edit"
					permissionDes="主表编辑">
					<a id="portalSkin_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_portalSkin_button_delete"
					permissionDes="主表删除">
					<a id="portalSkin_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_portalProgram_button_delete"
					permissionDes="启用皮肤状态">
					<a id="portalSkin_start" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="启用">启用</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_portalProgram_button_delete"
					permissionDes="禁用皮肤状态">
					<a id="portalSkin_stop" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="禁用">禁用</a>
				</sec:accesscontrollist>
			</div>
			<!-- <div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 125px">
					<input type="text" name="portalSkin_keyWord"
						id="portalSkin_keyWord" style="width: 125px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="portalSkin_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="portalSkin_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div> -->
		</div>
		<table id="portalSkin"></table>
		<div id="portalSkinPager"></div>
	</div>
	<div
		data-options="region:'south',split:true,height:fixheight(.5),onResize:function(a){$('#portalSkinVersion').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_portalSkinVersion" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_portalSkinVersion_button_add"
					permissionDes="子表添加">
					<a id="portalSkinVersion_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_portalSkinVersion_button_edit"
					permissionDes="子表编辑">
					<a id="portalSkinVersion_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_portalSkinVersion_button_delete"
					permissionDes="子表删除">
					<a id="portalSkinVersion_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_portalProgram_button_delete"
					permissionDes="启用版本状态">
					<a id="portalSkinVersion_start" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="启用">启用</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_portalProgram_button_delete"
					permissionDes="禁用版本状态">
					<a id="portalSkinVersion_stop" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="禁用">禁用</a>
				</sec:accesscontrollist>
			</div>
			<!-- <div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 125px">
					<input type="text" name="portalSkinVersion_keyWord"
						id="portalSkinVersion_keyWord" style="width: 125px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="portalSkinVersion_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="portalSkinVersion_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div> -->
		</div>
		<table id="portalSkinVersion"></table>
		<div id="portalSkinVersionPager"></div>
	</div>
</body>
<%-- <!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form">
		<table class="form_commonTable">
			<tr>
				<th width="10%">皮肤名称:</th>
				<td width="39%"><input title="皮肤名称"
					class="form-control input-sm" type="text" name="skinName"
					id="skinName" /></td>
				<th width="10%">皮肤代码:</th>
				<td width="39%"><input title="皮肤代码"
					class="form-control input-sm" type="text" name="skinCode"
					id="skinCode" /></td>
			</tr>
			<tr>
				<th width="10%">皮肤描述:</th>
				<td width="39%"><input title="皮肤描述"
					class="form-control input-sm" type="text" name="skinDesc"
					id="skinDesc" /></td>
				<th width="10%">皮肤状态:</th>
				<td width="39%"><pt6:h5radio css_class="radio-inline"
						name="skinState" title="皮肤状态" canUse="0" lookupCode="PLATFORM_SKIN_STATE" />
				</td>
			</tr>
			<tr>
			</tr>
		</table>
	</form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto; display: none">
	<form id="formSub">
		<input type="hidden" name="deptid" id="deptid" />
		<table class="form_commonTable">
			<tr>
				<th width="10%">皮肤版本名:</th>
				<td width="39%"><input title="皮肤版本名"
					class="form-control input-sm" type="text" name="skinVersionName"
					id="skinVersionName" /></td>
				<th width="10%">版本入口:</th>
				<td width="39%"><input title="版本入口"
					class="form-control input-sm" type="text"
					name="skinVersionEntrance" id="skinVersionEntrance" /></td>
			</tr>
			<tr>
				<th width="10%">打开方式:</th>
				<td width="39%"><input title="打开方式"
					class="form-control input-sm" type="text"
					name="skinVersionOpenMode" id="skinVersionOpenMode" /></td>
				<th width="10%">STATE配置文件:</th>
				<td width="39%"><input title="STATE配置文件"
					class="form-control input-sm" type="text"
					name="skinVersionManifest" id="skinVersionManifest" /></td>
			</tr>
			<tr>
				<th width="10%">皮肤版本地址:</th>
				<td width="39%"><input title="皮肤版本地址"
					class="form-control input-sm" type="text" name="skinVersionUrl"
					id="skinVersionUrl" /></td>
				<th width="10%">皮肤描述:</th>
				<td width="39%"><input title="皮肤描述"
					class="form-control input-sm" type="text" name="skinVersionDesc"
					id="skinVersionDesc" /></td>
			</tr>
			<tr>
				<th width="10%">版本状态:</th>
				<td width="39%"><pt6:h5radio css_class="radio-inline"
						name="skinVersionState" title="版本状态" canUse="0"
						lookupCode="SKIN_STATE" /></td>
				<th width="10%">是否最新版本:</th>
				<td width="39%"><input title="是否最新版本"
					class="form-control input-sm" type="text" name="skinVersionIsNew"
					id="skinVersionIsNew" title="版本状态" canUse="0"
						lookupCode="PLATFORM_PROGRAM_VERSION_ISNEW" /></td>
			</tr>
			<tr>
			</tr>
		</table>
	</form>
</div> --%>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/mobileportal/portalskin/js/PortalSkin.js"
	type="text/javascript"></script>
<script src="avicit/platform6/mobileportal/portalskin/js/PortalSkinVersion.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var portalSkin;
	var portalSkinVersion;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="portalSkin.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="portalSkin.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}
	function formatState(cellvalue, options, rowObject) {
		var thisState = rowObject.skinState;
		if(thisState =="0"){
			return '启用';
		}else{
			return '禁用';
		}
	}
	function formatSubState(cellvalue, options, rowObject) {
		var thisState = rowObject.skinVersionState;
		if(thisState =="0"){
			return '启用';
		}else{
			return '禁用';
		}
	}
	function formatSubIsNew(cellvalue, options, rowObject) {
		var thisIsNew = rowObject.skinVersionIsNew;
		if(thisIsNew =="0"){
            return '是';
        }else{
            return '否';
		}
	}

	$(document).ready(
			function() {
				var searchMainNames = new Array();
				var searchMainTips = new Array();
				searchMainNames.push("skinName");
				searchMainTips.push("皮肤名称");
				searchMainNames.push("skinCode");
				searchMainTips.push("皮肤代码");
				var searchMainC = searchMainTips.length == 2 ? '或'
						+ searchMainTips[1] : "";
				$('#portalSkin_keyWord').attr('placeholder',
						'请输入' + searchMainTips[0] + searchMainC);
				var searchSubNames = new Array();
				var searchSubTips = new Array();
				searchSubNames.push("skinVersionName");
				searchSubTips.push("皮肤版本名");
				searchSubNames.push("skinId");
				searchSubTips.push("服务外键id");
				var searchSubC = searchSubTips.length == 2 ? '或'
						+ searchSubTips[1] : "";
				$('#portalSkinVersion_keyWord').attr('placeholder',
						'请输入' + searchSubTips[0] + searchSubC);
				var portalSkinGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '皮肤名称',
					name : 'skinName',
					width : 150
				}, {
					label : '皮肤代码',
					name : 'skinCode',
					width : 150
				}, {
					label : '皮肤图标地址',
					name : 'skinImg',
					width : 280
				}/* , {
					label : '负责人',
					name : 'skinResponsibles',
					width : 150,
					hidden : true
				}, {
					label : '皮肤描述',
					name : 'skinDesc',
					width : 150,
					hidden : true
				} */, {
					label : '皮肤状态',
					name : 'skinState',
					formatter:formatState,
					width : 50
				} ];
				var portalSkinVersionGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '皮肤版本名',
					name : 'skinVersionName',
					width : 150
				}/* , {
					label : '服务外键id',
					name : 'skinId',
					width : 150,
					hidden : true
				} , {
					label : '版本入口',
					name : 'skinVersionEntrance',
					width : 150,
					hidden : true
				}, {
					label : '打开方式',
					name : 'skinVersionOpenMode',
					width : 150,
					hidden : true
				}*/, {
					label : 'STATE配置文件',
					name : 'skinVersionManifest',
					width : 200
				}/* , {
					label : '设备名称',
					name : 'skinVersionModuleName',
					width : 150,
					hidden : true
				}, {
					label : '从属',
					name : 'skinVersionDependance',
					width : 150,
					hidden : true
				} */, {
					label : '皮肤版本地址',
					name : 'skinVersionUrl',
					width : 200
				}/* , {
					label : '皮肤描述',
					name : 'skinVersionDesc',
					width : 150,
					hidden : true
				} */, {
					label : '是否最新版本',
					name : 'skinVersionIsNew',
					formatter:formatSubIsNew,
					width : 40
				}, {
					label : '版本状态',
					name : 'skinVersionState',
					formatter:formatSubState,
					width : 40
				}, ];

				portalSkin = new PortalSkin('portalSkin', '${url}', 'form',
						portalSkinGridColModel, 'searchDialog', function(pid) {
							portalSkinVersion = new PortalSkinVersion(
									'portalSkinVersion', '${surl}', "formSub",
									portalSkinVersionGridColModel,
									'searchDialogSub', pid, searchSubNames,
									"portalSkinVersion_keyWord");
						}, function(pid) {
							portalSkinVersion.reLoad(pid);
						}, searchMainNames, "portalSkin_keyWord");
				//主表操作
				//添加按钮绑定事件
				$('#portalSkin_insert').bind('click', function() {
					portalSkin.insert();
				});
				//编辑按钮绑定事件
				$('#portalSkin_modify').bind('click', function() {
					portalSkin.modify();
				});
				//删除按钮绑定事件
				$('#portalSkin_del').bind('click', function() {
					portalSkin.del();
				});
				//禁用按钮绑定事件
				$('#portalSkin_stop').bind('click', function() {
					portalSkin.stop();
				});
				//启用按钮绑定事件
				$('#portalSkin_start').bind('click', function() {
					portalSkin.start();
				});
				//打开高级查询框
				$('#portalSkin_searchAll').bind('click', function() {
					portalSkin.openSearchForm(this, $('#portalSkin'));
				});
				//关键字段查询按钮绑定事件
				$('#portalSkin_searchPart').bind('click', function() {
					portalSkin.searchByKeyWord();
				});
				//子表操作
				//添加按钮绑定事件
				$('#portalSkinVersion_insert').bind('click', function() {
					portalSkinVersion.insert();
				});
				//编辑按钮绑定事件
				$('#portalSkinVersion_modify').bind('click', function() {
					portalSkinVersion.modify();
				});
				//删除按钮绑定事件
				$('#portalSkinVersion_del').bind('click', function() {
					portalSkinVersion.del();
				});
				//禁用按钮绑定事件
				$('#portalSkinVersion_stop').bind('click', function() {
					portalSkinVersion.stop();
				});
				//启用按钮绑定事件
				$('#portalSkinVersion_start').bind('click', function() {
					portalSkinVersion.start();
				});
				//打开高级查询
				$('#portalSkinVersion_searchAll').bind(
						'click',
						function() {
							portalSkinVersion.openSearchForm(this,
									$('#portalSkinVersion'));
						});
				//关键字段查询按钮绑定事件
				$('#portalSkinVersion_searchPart').bind('click', function() {
					portalSkinVersion.searchByKeyWord();
				});

			});
</script>
</html>