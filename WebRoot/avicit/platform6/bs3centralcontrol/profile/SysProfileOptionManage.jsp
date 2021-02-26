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
<!-- ControllerPath = "ys/sysprofileoption/sysProfileOptionController/toSysProfileOptionManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,title:'应用列表',collapsible:false" style="height:0; overflow:hidden; font-size:0;width:200px;">
               <div id="tableToolbarM" class="toolbar">
                   <div class="toolbar-left">
                       <div class="input-group  input-group-sm">
                           <input  class="form-control" placeholder="输入名称查询" type="text" id="appSearchInput" name="txt">
                           <span class="input-group-btn">
                           <button id="appSearch" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
                       </span>
                       </div>
                   </div>
               </div>
               <div  id='mdiv' style="overflow:auto;">
                   <table id="jqGridApp"></table>
               </div>
 	</div>
	<div
		data-options="region:'center',onResize:function(a){$('#demoMainDept').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_sysProfileOption" class="toolbar" style="height:42px">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysProfileOption_button_add"
					permissionDes="主表添加">
					<a id="sysProfileOption_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm btn-point" role="button"
						title="添加"><i class="icon icon-add"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysProfileOption_button_edit"
					permissionDes="主表编辑">
					<a id="sysProfileOption_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="icon icon-edit"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysProfileOption_button_delete"
					permissionDes="主表删除">
					<a id="sysProfileOption_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="icon icon-delete"></i> 删除</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
									   domainObject="formdialog_sysProfileOption_button_import"
									   permissionDes="主表导入">
					<a id="sysProfileOption_import" href="javascript:void(0)"
					   class="btn btn-default form-tool-btn btn-sm" role="button"
					   title="导入"><i class="icon icon-daoru"></i> 导入</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
									   domainObject="formdialog_sysProfileOption_button_export"
									   permissionDes="主表导出">
					<a id="sysProfileOption_export" href="javascript:void(0)"
					   class="btn btn-default form-tool-btn btn-sm" role="button"
					   title="导出"><i class="icon icon-daochu"></i> 导出</a>
				</sec:accesscontrollist>
			</div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 160px">
					<input type="text" name="sysProfileOption_keyWord"
						id="sysProfileOption_keyWord"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="sysProfileOption_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
			</div>
		</div>
		<table id="sysProfileOption"></table>
		<div id="sysProfileOptionPager"></div>
	</div>
	<div
		data-options="region:'east',split:true,width:fixwidth(.4),onResize:function(a){$('#demoSubUser').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_sysProfileOptionValue" class="toolbar" style="height:42px">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysProfileOptionValue_button_add"
					permissionDes="子表添加">
					<a id="sysProfileOptionValue_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm btn-point" role="button"
						title="添加"><i class="icon icon-add"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysProfileOptionValue_button_edit"
					permissionDes="子表编辑">
					<a id="sysProfileOptionValue_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="icon icon-edit"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysProfileOptionValue_button_delete"
					permissionDes="子表删除">
					<a id="sysProfileOptionValue_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="icon icon-delete"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
		</div>
		<table id="sysProfileOptionValue"></table>
		<div id="sysProfileOptionValuePager"></div>
	</div>
</body>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bs3centralcontrol/appliaction/js/AppList.js" type="text/javascript"></script>
<script src="avicit/platform6/bs3centralcontrol/profile/js/SysProfileOption.js" type="text/javascript"></script>
<script src="avicit/platform6/bs3centralcontrol/profile/js/SysProfileOptionValue.js" type="text/javascript"></script>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
	
	
<script type="text/javascript">
var appid = "";
var sysProfileOption;
var sysProfileOptionValue;
var isInit = true;
		
$(document).ready(function () {
	var searchMainNames = new Array();
	var searchMainTips = new Array();
	searchMainNames.push("profileOptionCode");
 	searchMainTips.push("代码");
	searchMainNames.push("profileOptionName");
 	searchMainTips.push("名称");
	$('#sysProfileOption_keyWord').attr('placeholder','请输入'+searchMainTips[0]+'或'+searchMainTips[1]);
		
	var sysProfileOptionGridColModel =  [
		{ label: 'id', name: 'id', key: true, width: 75, hidden:true}
		,{ label: '配置文件代码', name: 'profileOptionCode', width: 150}
		,{ label: '配置文件名称', name: 'profileOptionName', width: 150}
		,{ label: '使用级别', name: 'usageModifier', width: 100}
		,{ label: '应用ID', name: 'sysApplicationId', width: 150}
		,{ label: '有效标识', name: 'validFlag', width: 80}
		,{ label: '地点层可见 Y代表可以，N代表不可以，默认为Y', name: 'siteEnabledFlag', width: 150, hidden:true}
		,{ label: '应用程序层可见 Y代表可以，N代表不可以，默认为Y', name: 'appEnabledFlag', width: 150, hidden:true}
		,{ label: '角色层可见 Y代表可以，N代表不可以，默认为Y', name: 'roleEnabledFlag', width: 150, hidden:true}
		,{ label: '用户层可见 Y代表可以，N代表不可以，默认为Y', name: 'userEnabledFlag', width: 150, hidden:true}
		,{ label: '部门启用标记 Y代表可以，N代表不可以，默认为Y', name: 'deptEnabledFlag', width: 150, hidden:true}
		/*,{ label: '描述', name: 'description', width: 150}
		,{ label: '是否多值 Y 是 N 否', name: 'ynMultiValue', width: 150 , hidden:true}
		,{ label: '用户可更新标识 Y代表可以，N代表不可以，默认为Y', name: 'userChangeableFlag', width: 150, hidden:true}
		,{ label: '用户可查看标识 Y代表可以，N代表不可以，默认为Y', name: 'userVisibleFlag', width: 150, hidden:true}
		,{ label: '地点层可见 Y代表可以，N代表不可以，默认为Y', name: 'siteEnabledFlag', width: 150, hidden:true}
		,{ label: '应用程序层可见 Y代表可以，N代表不可以，默认为Y', name: 'appEnabledFlag', width: 150, hidden:true}
		,{ label: '角色层可见 Y代表可以，N代表不可以，默认为Y', name: 'roleEnabledFlag', width: 150, hidden:true}
		,{ label: '用户层可见 Y代表可以，N代表不可以，默认为Y', name: 'userEnabledFlag', width: 150, hidden:true}
		,{ label: '部门启用标记 Y代表可以，N代表不可以，默认为Y', name: 'deptEnabledFlag', width: 150, hidden:true}
		,{ label: 'SQL校验 用于配置文件选项的值列表的SQL验证', name: 'sqlValidation', width: 150, hidden:true}
		,{ label: '是否为系统初始 Y 是 N 否', name: 'systemFlag', width: 150, hidden:true}*/

	];
	var sysProfileOptionValueGridColModel =  [
		{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
		,{ label: '级别', name: 'profileLevelCode', width: 150}
		,{ label: '级别值', name: 'levelValue', width: 150}
		,{ label: '配置文件值', name: 'profileOptionValue', width: 150}
		/*,{ label: '配置文件选项值 对应PROFILE比表SQL的ID', name: 'profileOptionValue', width: 150}*/
	];
	sysAppTree = new AppList('jqGridApp','0','searchDialog','form','keyWord');
	
	sysAppTree.setOnSelect(function(appId){
		appid = appId;
		if(isInit){
			sysProfileOption= new SysProfileOption(
					'sysProfileOption',
					'${url}',
					'form',
					sysProfileOptionGridColModel,
					'searchDialog',
					function(pid){
						sysProfileOptionValue = new SysProfileOptionValue('sysProfileOptionValue',
								'${surl}', "formSub", sysProfileOptionValueGridColModel, 
								'searchDialogSub', pid, "sysProfileOptionValue_keyWord");
					},
					function(pid){
						sysProfileOptionValue.reLoad(pid);
					},
					searchMainNames,
					"sysProfileOption_keyWord",
					appid);
			isInit = false;
		}else{
			sysProfileOption.switchApp(appid);
		}
	});
	
	//主表操作
	//添加按钮绑定事件
	$('#sysProfileOption_insert').bind('click', function(){
		sysProfileOption.insert();
	});
	//编辑按钮绑定事件
	$('#sysProfileOption_modify').bind('click', function(){
		sysProfileOption.modify();
	});
	//删除按钮绑定事件
	$('#sysProfileOption_del').bind('click', function(){  
		sysProfileOption.del();
	});
    //导入按钮绑定事件
    $('#sysProfileOption_import').bind('click', function(){
        sysProfileOption.importProfile();
    });
    //导出按钮绑定事件
    $('#sysProfileOption_export').bind('click', function(){
        sysProfileOption.exportProfile();
    });
	//打开高级查询框
	$('#sysProfileOption_searchAll').bind('click', function(){
		sysProfileOption.openSearchForm(this,$('#sysProfileOption'));
	});
	//关键字段查询按钮绑定事件
	$('#sysProfileOption_searchPart').bind('click', function(){
		sysProfileOption.searchByKeyWord();
	});
	//子表操作
	//添加按钮绑定事件
	$('#sysProfileOptionValue_insert').bind('click', function(){
		sysProfileOptionValue.insert();
	});
	//编辑按钮绑定事件
	$('#sysProfileOptionValue_modify').bind('click', function(){
		sysProfileOptionValue.modify();
	});
	//删除按钮绑定事件
	$('#sysProfileOptionValue_del').bind('click', function(){  
		sysProfileOptionValue.del();
	});
	//打开高级查询
	$('#sysProfileOptionValue_searchAll').bind('click', function(){
		sysProfileOptionValue.openSearchForm(this,$('#sysProfileOptionValue'));
	});
	//关键字段查询按钮绑定事件
	$('#sysProfileOptionValue_searchPart').bind('click', function(){
		sysProfileOptionValue.searchByKeyWord();
	});
																																																																																																											
});

</script>
</html>