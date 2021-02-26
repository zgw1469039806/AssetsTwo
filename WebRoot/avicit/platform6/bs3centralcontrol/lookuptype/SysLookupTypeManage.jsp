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
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,title:'应用列表',collapsible:false" style="height:0; overflow:hidden; font-size:0;width:150px;">
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
	<div data-options="region:'center',onResize:function(a){$('#sysLookupType').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_sysLookupType" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysLookupType_button_add"
					permissionDes="主表添加">
					<a id="sysLookupType_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm btn-point" role="button"
						title="添加"><i class="icon icon-add"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysLookupType_button_edit"
					permissionDes="主表编辑">
					<a id="sysLookupType_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="icon icon-edit"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysLookupType_button_delete"
					permissionDes="删除">
					<a id="sysLookupType_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="icon icon-delete"></i> 删除</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysLookupType_button_LanguageMian"
					permissionDes="语言设置通用代码类型">
					<a id="sysLookupType_set" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="语言设置"><i class="icon icon-setting"></i> 语言设置</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysLookupType_toolbar_tool" permissionDes="工具">
					<div class="dropdown">
						<a class="btn btn-primary form-tool-btn btn-sm" role="button" href="javascript:void(0);"
						   data-toggle="dropdown" id="dropdownMenu">工具<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">

							<sec:accesscontrollist hasPermission="3"
												   domainObject="formdialog_sysLookupType_button_Import_Excel"
												   permissionDes="EXCEL导入">
								<li role="presentation"><a id="sysLookupType_Import_Excel" href="javascript:void(0);" >EXCEL 导入</a></li>
								<li role="separator" class="divider"></li>
							</sec:accesscontrollist>

							<sec:accesscontrollist hasPermission="3"
												   domainObject="formdialog_sysLookupType_button_Import"
												   permissionDes="XML导入">
								<li role="presentation"><a id="sysLookupType_Import" href="javascript:void(0);" >XML 导入</a></li>
								<li role="separator" class="divider"></li>
							</sec:accesscontrollist>

							<sec:accesscontrollist hasPermission="3"
												   domainObject="formdialog_sysLookupType_button_LanguageMian"
												   permissionDes="XML导出">
								<li role="presentation"><a id="sysLookupType_Export" href="javascript:void(0);" >XML 导出</a></li>
								<li role="separator" class="divider"></li>
							</sec:accesscontrollist>

						</ul>
					</div>
				</sec:accesscontrollist>
			</div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 175px">
					<input type="text" name="sysLookupType_keyWord"
						id="sysLookupType_keyWord" class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="sysLookupType_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
			</div>
		</div>
		<table id="sysLookupType"></table>
		<div id="sysLookupTypePager"></div>
	</div>
	<div data-options="region:'east',split:true,width:fixwidth(.37),onResize:function(a){$('#sysLookup').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_sysLookup" class="toolbar" style="height:42px">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysLookup_button_add" permissionDes="通用代码添加">
					<a id="sysLookup_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm btn-point" role="button"
						title="通用代码添加"><i class="icon icon-add"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysLookup_button_delete"
					permissionDes="通用代码删除">
					<a id="sysLookup_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="通用代码删除"><i class="icon icon-delete"></i> 删除</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysLookup_button_save"
					permissionDes="通用代码保存">
					<a id="sysLookup_save" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="保存"><i class="icon icon-save"></i> 保存</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysLookupType_button_LanguageSub"
					permissionDes="语言设置通用代码">
					<a id="sysLookup_set" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="语言设置"> 语言设置</a>
				</sec:accesscontrollist>
			</div>
		</div>
		<table id="sysLookup"></table>
		<div id="sysLookupPager"></div>
	</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bs3centralcontrol/appliaction/js/AppList.js" type="text/javascript"></script>
<script src="avicit/platform6/bs3centralcontrol/lookuptype/js/SysLookupType.js" type="text/javascript"></script>
<script src="avicit/platform6/bs3centralcontrol/lookuptype/js/SysLookup.js"	type="text/javascript"></script>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript" ></script>
<script type="text/javascript">
	var sysLookupType;
	var sysLookup;
	var lookup_validFlag = {1:"有效",0:"无效"};
	var appid = "";
	var isInit = true;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="sysLookupType.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="sysLookupType.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}

	$(document).ready(
			function() {
				var searchMainNames = new Array();
				var searchMainTips = new Array();
				searchMainNames.push("lookupType");
				searchMainTips.push("代码类型");
				searchMainNames.push("lookupTypeName");
				searchMainTips.push("代码名称");
				$('#sysLookupType_keyWord').attr('placeholder',
						'输入' + searchMainTips[0] + '或' + searchMainTips[1]);

				var sysLookupTypeGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '应用ID',
					name : 'sysApplicationId',
					hidden : true,
					width : 150,
					formatter : formatValue
				},{
					label : '代码类型',
					name : 'lookupType',
					width : 150
				},{
					label : '代码类型名称',
					name : 'lookupTypeName',
					width : 150
				},{
					label : '代码类型描述',
					name : 'lookupTypeDesc',
					width : 150
				}, {
					label : '是否为系统初始 Y 是 N 否',
					name : 'systemFlag',
					hidden : true,
					width : 150
				}, {
					label : '是否有效',
					name : 'validFlag',
					width : 150,
					edittype : "custom",
					editoptions : {
						custom_element : selectElem,
						custom_value : selectValue,
						forId : 'PLATFORM_VALID_FLAG',
						value : lookup_validFlag
					}
				}, {
					label : '所属模块',
					name : 'belongModule',
					hidden : true,
					width : 150
				}, {
					label : '使用级别',
					name : 'usageModifier',
					width : 150
				} ];
				
				
				var sysLookupGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '通用代码ID',
					name : 'sysLookupTypeId',
					hidden : true,
					width : 150
				},  {
					label : '<span style="color:#ff0000"> * </span>代码编码',
					name : 'lookupCode',
					editable : true,
					edittype : "text",
					width : 150
				}, {
					label : '<span style="color:#ff0000"> * </span>代码名称',
					name : 'lookupName',
					editable : true,
					edittype : "text",
					width : 150
				},{
					label : '<span style="color:#ff0000"> * </span>显示顺序',
					name : 'displayOrder',
					editable : true,
					edittype : 'custom',
					editoptions : {
						custom_element : spinnerElem,
						custom_value : spinnerValue,
						min : 0,
						max : 999999999999,
						step : 1,
						precision : 0
					},
					width : 150
				},{
					label : '代码描述',
					name : 'lookupDesc',
					editable : true,
					edittype : "text",
					width : 150
				},{
					label : '是否有效 ',
					name : 'validFlag',
					value: "1",
					width : 150,
					hidden : true
				}, {
					label : '是否有效',
					name : 'validFlagAlias',
					value: "有效",
					width : 150,
					edittype : "custom",
					editable : true,
					editoptions : {
						custom_element : selectElem,
						custom_value : selectValue,
						forId : 'validFlag',
						value : lookup_validFlag
					}
				},{
					label : '是否是系统初始值 Y 是 N 否',
					name : 'systemFlag',
					hidden : true,
					width : 150
				} ];
				sysAppTree = new AppList('jqGridApp','0','searchDialog','form','keyWord');

		        sysAppTree.setOnSelect(function(appId){
		        	appid = appId;
		        	if(isInit){
		        		sysLookupType = new SysLookupType('sysLookupType', '${url}',
							'form', sysLookupTypeGridColModel, 'searchDialog',
							function(pid) {
								sysLookup = new SysLookup('sysLookup', '${surl}',
										"formSub", sysLookupGridColModel,
										'searchDialogSub', pid, null,
										"sysLookup_keyWord");
							}, function(pid) {
								sysLookup.reLoad(pid);
							}, searchMainNames, "sysLookupType_keyWord", appid);
		        		isInit = false;
		        	}else{
						sysLookupType.switchApp(appid);
		        	}
		        });
				
				//主表操作
				//添加按钮绑定事件
				$('#sysLookupType_insert').bind('click', function() {
					sysLookupType.insert();
				});
				//编辑按钮绑定事件
				$('#sysLookupType_modify').bind('click', function() {
					sysLookupType.modify();
				});
				//删除按钮绑定事件
				$('#sysLookupType_del').bind('click', function() {
					sysLookupType.del();
				});
				//打开高级查询框
				$('#sysLookupType_searchAll').bind('click', function() {
					sysLookupType.openSearchForm(this, $('#sysLookupType'));
				});
				//关键字段查询按钮绑定事件
				$('#sysLookupType_searchPart').bind('click', function() {
					sysLookupType.searchByKeyWord();
				});
				$('#sysLookupType_set').bind('click', function() {
					sysLookupType.openLanguageForm();
				});
				$('#sysLookup_set').bind('click', function() {
					sysLookup.openLanguageForm();
				});
                //导入、导出的事件绑定
                $('#sysLookupType_Import').bind('click', function() {
                    sysLookupType.doimport();
                });
                $('#sysLookupType_Export').bind('click', function() {
                    sysLookupType.doexport();
                });
                $('#sysLookupType_Import_Excel').bind('click', function() {
                    sysLookupType.doImportExcel();
                });
				//子表操作
				//添加按钮绑定事件
				$('#sysLookup_insert').bind('click', function() {
					sysLookup.insert();
				});
				//编辑按钮绑定事件
				$('#sysLookup_save').bind('click', function() {
					sysLookup.save();
				});
				//删除按钮绑定事件
				$('#sysLookup_del').bind('click', function() {
					sysLookup.del();
				});
				//打开高级查询
				$('#sysLookup_searchAll').bind('click', function() {
					sysLookup.openSearchForm(this, $('#sysLookup'));
				});
				//关键字段查询按钮绑定事件
				$('#sysLookup_searchPart').bind('click', function() {
					sysLookup.searchByKeyWord();
				});
				

			});
	
	function closeL(){
		sysLookupType.closeDialog('chooseL');
	};
	
	function closeLook(){
		sysLookup.closeDialog('chooseL');
	};
</script>
</html>