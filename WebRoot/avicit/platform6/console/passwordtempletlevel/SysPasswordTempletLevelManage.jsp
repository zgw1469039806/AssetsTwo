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
<!-- ControllerPath = "demo/syspasswordtempletlevel/sysPasswordTempletLevelController/toSysPasswordTempletLevelManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div
		data-options="region:'center',onResize:function(a){$('#demoMainDept').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_sysPasswordTempletLevel" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysPasswordTempletLevel_button_add"
					permissionDes="主表添加">
					<a id="sysPasswordTempletLevel_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm btn-point" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysPasswordTempletLevel_button_edit"
					permissionDes="主表编辑">
					<a id="sysPasswordTempletLevel_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysPasswordTempletLevel_button_delete"
					permissionDes="主表删除">
					<a id="sysPasswordTempletLevel_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
		</div>
		<table id="sysPasswordTempletLevel"></table>
		<div id="sysPasswordTempletLevelPager"></div>
	</div>
	<div
		data-options="region:'east',split:true,width:fixwidth(.5),onResize:function(a){$('#demoSubUser').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_sysPasswordTemplet" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysPasswordTemplet_button_save"
					permissionDes="子表保存">
					<a id="sysPasswordTemplet_save" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm btn-point" role="button"
						title="保存"><i class="icon icon-save"></i> 保存</a>
				</sec:accesscontrollist>
			</div>
		</div>
		<table id="sysPasswordTemplet"></table>
		<div id="sysPasswordTempletPager"></div>
	</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script
	src="avicit/platform6/console/passwordtempletlevel/js/SysPasswordTempletLevel.js"
	type="text/javascript"></script>
<script
	src="avicit/platform6/console/passwordtempletlevel/js/SysPasswordTemplet.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var sysPasswordTempletLevel;
	var sysPasswordTemplet;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="sysPasswordTempletLevel.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	} 
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="sysPasswordTempletLevel.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}

	$(document).ready(
			function() {
				var searchMainNames = new Array();
				var searchMainTips = new Array();
				searchMainNames.push("sysApplicationId");
				//searchMainTips.push("应用ID");
				searchMainNames.push("key");
				searchMainTips.push("模板名称");
				$('#sysPasswordTempletLevel_keyWord').attr('placeholder',
						'请输入' + searchMainTips[0] + '或' + searchMainTips[1]);
				var searchSubNames = new Array();
				var searchSubTips = new Array();
				searchSubNames.push("templetKey");
				searchSubTips.push("密码规则KEY");
				searchSubNames.push("templetValue");
				searchSubTips.push("密码规则值");
				$('#sysPasswordTemplet_keyWord').attr('placeholder',
						'请输入' + searchSubTips[0] + '或' + searchSubTips[1]);
				var sysPasswordTempletLevelGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '应用ID',
					name : 'sysApplicationId',
					width : 150,
					hidden : true,
					formatter : formatValue
				}, {
					label : '密码模板名称',
					name : 'key',
					width : 150
				}, {
					label : '密码模板标识',
					name : 'code',
					width : 150
				}, {
					label : '用户密级',
					name : 'userLevelCode',
					width : 150
				} ];
				var sysPasswordTempletGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '密码规则KEY',
					name : 'templetKey',
					width : 150
				},{
					label : '密码规则描述',
					name : 'configureName',
					width : 200
				}, {
					label : '密码规则值',
					name : 'templetValue',
					width : 150,
					editable : true,
					edittype : 'custom',
					editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:0,max:999999999999,step:1,precision:0}
				}, {
					label : '是否有效',
					name : 'templetState',
					width : 100,
					editable : true,
					edittype : 'select',
					editoptions :{value : {1:'有效',0:'无效'}}
				}, {
					label : '密码模板类型（级别）',
					name : 'templetType',
					width : 200,
					hidden:true
				} 
				];

				sysPasswordTempletLevel = new SysPasswordTempletLevel(
						'sysPasswordTempletLevel', '${url}', 'form',
						sysPasswordTempletLevelGridColModel, 'searchDialog',
						function(pid) {
							sysPasswordTemplet = new SysPasswordTemplet(
									'sysPasswordTemplet', '${surl}', "formSub",
									sysPasswordTempletGridColModel,
									'searchDialogSub', pid, searchSubNames,
									"sysPasswordTemplet_keyWord");
						}, function(pid) {
							sysPasswordTemplet.reLoad(pid);
						}, searchMainNames, "sysPasswordTempletLevel_keyWord");
				//主表操作
				//添加按钮绑定事件
				$('#sysPasswordTempletLevel_insert').bind('click', function() {
					sysPasswordTempletLevel.insert();
				});
				//编辑按钮绑定事件
				$('#sysPasswordTempletLevel_modify').bind('click', function() {
					sysPasswordTempletLevel.modify();
				});
				//删除按钮绑定事件
				$('#sysPasswordTempletLevel_del').bind('click', function() {
					sysPasswordTempletLevel.del();
				});
				//打开高级查询框
				$('#sysPasswordTempletLevel_searchAll').bind(
						'click',
						function() {
							sysPasswordTempletLevel.openSearchForm(this,
									$('#sysPasswordTempletLevel'));
						});
				//关键字段查询按钮绑定事件
				$('#sysPasswordTempletLevel_searchPart').bind('click',
						function() {
							sysPasswordTempletLevel.searchByKeyWord();
						});
				//子表操作
				//添加按钮绑定事件
				$('#sysPasswordTemplet_insert').bind('click', function() {
					sysPasswordTemplet.insert();
				});
				//编辑按钮绑定事件
				$('#sysPasswordTemplet_modify').bind('click', function() {
					sysPasswordTemplet.modify();
				});
				//删除按钮绑定事件
				$('#sysPasswordTemplet_del').bind('click', function() {
					sysPasswordTemplet.del();
				});
				//打开高级查询
				$('#sysPasswordTemplet_searchAll').bind('click',function() {
					sysPasswordTemplet.openSearchForm(this, $('#sysPasswordTemplet'));
				});
				//关键字段查询按钮绑定事件
				$('#sysPasswordTemplet_searchPart').bind('click', function() {
					sysPasswordTemplet.searchByKeyWord();
				});
				$('#sysPasswordTemplet_save').bind('click',function(){
					sysPasswordTemplet.save();
				});

			});
</script>
</html>