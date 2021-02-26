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
<!-- ControllerPath = "avicit/platform6/bootstrapmsecure/mobileserviceinfo/controller/NewMobileServiceInfoController/toMobileServiceInfoManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div id="mobileServiceInfo1" data-options="region:'west',split:true" style="width:520px">

		<div data-options="region:'north',onResize:function(a){$('#mobileServiceInfo').setGridWidth(a);$(window).trigger('resize');}">
			<div id="toolbar_mobileServiceInfo" class="toolbar">
				<div class="toolbar-left">
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceInfo_button_add"
						permissionDes="主表添加">
						<a id="mobileServiceInfo_insert" href="javascript:void(0)"
							class="btn btn-default form-tool-btn btn-sm" role="button"
							title="添加"><i class="fa fa-plus"></i> 添加</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceInfo_button_edit"
						permissionDes="主表编辑">
						<a id="mobileServiceInfo_modify" href="javascript:void(0)"
							class="btn btn-default form-tool-btn btn-sm" role="button"
							title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceInfo_button_delete"
						permissionDes="主表删除">
						<a id="mobileServiceInfo_del" href="javascript:void(0)"
							class="btn btn-default form-tool-btn btn-sm" role="button"
							title="删除"><i class="fa fa-trash-o"></i> 删除</a>
					</sec:accesscontrollist>
				</div>
				<div class="toolbar-right">
					<div class="input-group form-tool-search" style="width: 125px">
						<input type="text" name="mobileServiceInfo_keyWord"
							id="mobileServiceInfo_keyWord" style="width: 125px;"
							class="form-control input-sm" placeholder="请输入查询条件"> <label
							id="mobileServiceInfo_searchPart"
							class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn">
						<a id="mobileServiceInfo_searchAll" href="javascript:void(0)"
							class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
							<span class="caret"></span>
						</a>
					</div>
				</div>
			</div>
			<table id="mobileServiceInfo"></table>
			<div id="mobileServiceInfoPager"></div>
		</div>
		<div data-options="region:'center',onResize:function(a){$('#mobileServiceHeaders').setGridWidth(a);$(window).trigger('resize');}">
			<div id="toolbar_mobileServiceHeaders" class="toolbar">
				<div class="toolbar-left">
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceHeaders_button_add"
						permissionDes="子表添加">
						<a id="mobileServiceHeaders_insert" href="javascript:void(0)"
							class="btn btn-default form-tool-btn btn-sm" role="button"
							title="添加"><i class="fa fa-plus"></i> 添加</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceHeaders_button_edit"
						permissionDes="子表编辑">
						<a id="mobileServiceHeaders_modify" href="javascript:void(0)"
							class="btn btn-default form-tool-btn btn-sm" role="button"
							title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceHeaders_button_delete"
						permissionDes="子表删除">
						<a id="mobileServiceHeaders_del" href="javascript:void(0)"
							class="btn btn-default form-tool-btn btn-sm" role="button"
							title="删除"><i class="fa fa-trash-o"></i> 删除</a>
					</sec:accesscontrollist>
				</div>
				<!-- <div class="toolbar-right">
					<div class="input-group form-tool-search" style="width: 125px">
						<input type="text" name="mobileServiceHeaders_keyWord"
							id="mobileServiceHeaders_keyWord" style="width: 125px;"
							class="form-control input-sm" placeholder="请输入查询条件"> <label
							id="mobileServiceHeaders_searchPart"
							class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn">
						<a id="mobileServiceHeaders_searchAll" href="javascript:void(0)"
							class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
							<span class="caret"></span>
						</a>
					</div>
				</div> -->
			</div>
			<table id="mobileServiceHeaders"></table>
			<div id="mobileServiceHeadersPager"></div>
		</div>
	</div>
	<div data-options="region:'center',split:true,onResize:function(a){$('#mobileServiceInfo1').setGridWidth(a);$(window).trigger('resize');}">
	
			<div data-options="region:'north',border:false,split:true,onResize:function(a){$('#mobileCommandInfo').setGridWidth(a);$(window).trigger('resize');}">
				<div id="toolbar_mobileCommandInfo" class="toolbar" >
					<div class="toolbar-left" >
						<sec:accesscontrollist hasPermission="3"
							domainObject="formdialog_mobileCommandInfo_button_add"
							permissionDes="主表添加">
							<a id="mobileCommandInfo_insert" href="javascript:void(0)"
								class="btn btn-default form-tool-btn btn-sm" role="button"
								title="添加"><i class="fa fa-plus"></i> 添加</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3"
							domainObject="formdialog_mobileCommandInfo_button_edit"
							permissionDes="主表编辑">
							<a id="mobileCommandInfo_modify" href="javascript:void(0)"
								class="btn btn-default form-tool-btn btn-sm" role="button"
								title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3"
							domainObject="formdialog_mobileCommandInfo_button_delete"
							permissionDes="主表删除">
							<a id="mobileCommandInfo_del" href="javascript:void(0)"
								class="btn btn-default form-tool-btn btn-sm" role="button"
								title="删除"><i class="fa fa-trash-o"></i> 删除</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3"
											   domainObject="formdialog_mobileCommandInfo_button_import"
											   permissionDes="主表删除">
							<a id="mobileCommandInfo_imp" href="javascript:void(0)"
							   class="btn btn-default form-tool-btn btn-sm" role="button"
							   title="导入"><i class="fa fa-trash-o"></i> 导入</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3"
											   domainObject="formdialog_mobileCommandInfo_button_export"
											   permissionDes="导出">
							<a id="mobileCommandInfo_exp" href="javascript:void(0)"
							   class="btn btn-default form-tool-btn btn-sm" role="button"
							   title="导出"><i class="fa fa-trash-o"></i> 导出</a>
						</sec:accesscontrollist>
					</div>

					<div class="toolbar-right">
						<div class="input-group form-tool-search" style="width:125px">
							<input type="text" name="mobileCommandInfo_keyWord" id="mobileCommandInfo_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
							<label id="mobileCommandInfo_searchPart" class="icon icon-search form-tool-searchicon"></label>
						</div>
						<div class="input-group-btn form-tool-searchbtn">
							<a id="mobileCommandInfo_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
						</div>
					</div>
				</div>
				<table id="mobileCommandInfo"></table>
				<div id="mobileCommandInfoPager"></div>
			</div>
			<div data-options="region:'center',border:false,split:true" class="easyui-layout" fit="true" >
			<div data-options="region:'center',border:false,split:true,onResize:function(a){$('#mobileCommandHeaders').setGridWidth(a);$(window).trigger('resize');}">
				<div id="toolbar_mobileCommandHeaders" class="toolbar">
					<div class="toolbar-left">
						<sec:accesscontrollist hasPermission="3"
							domainObject="formdialog_mobileCommandHeaders_button_add"
							permissionDes="子表添加">
							<a id="mobileCommandHeaders_insert" href="javascript:void(0)"
								class="btn btn-default form-tool-btn btn-sm" role="button"
								title="添加"><i class="fa fa-plus"></i> 添加</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3"
							domainObject="formdialog_mobileCommandHeaders_button_edit"
							permissionDes="子表编辑">
							<a id="mobileCommandHeaders_modify" href="javascript:void(0)"
								class="btn btn-default form-tool-btn btn-sm" role="button"
								title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3"
							domainObject="formdialog_mobileCommandHeaders_button_delete"
							permissionDes="子表删除">
							<a id="mobileCommandHeaders_del" href="javascript:void(0)"
								class="btn btn-default form-tool-btn btn-sm" role="button"
								title="删除"><i class="fa fa-trash-o"></i> 删除</a>
						</sec:accesscontrollist>
					</div>
					<!-- <div class="toolbar-right">
						<div class="input-group form-tool-search" style="width: 125px">
							<input type="text" name="mobileCommandHeaders_keyWord"
								id="mobileCommandHeaders_keyWord" style="width: 125px;"
								class="form-control input-sm" placeholder="请输入查询条件"> <label
								id="mobileCommandHeaders_searchPart"
								class="icon icon-search form-tool-searchicon"></label>
						</div>
						<div class="input-group-btn form-tool-searchbtn">
							<a id="mobileCommandHeaders_searchAll" href="javascript:void(0)"
								class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
								<span class="caret"></span>
							</a>
						</div>
					</div> -->
				</div>
				<table id="mobileCommandHeaders"></table>
				<div id="mobileCommandHeadersPager"></div>
			</div>
			<div data-options="region:'east',border:false,split:true,onResize:function(a){$('#mobileCommandExtendjqGrid').setGridWidth(a);$(window).trigger('resize');}" style="width:300px">
				<div id="tableToolbar" class="toolbar">
					<div class="toolbar-left">
						<sec:accesscontrollist hasPermission="3"
							domainObject="formdialog_mobileCommandExtend_button_add"
							permissionDes="添加">
							<a id="mobileCommandExtend_insert" href="javascript:void(0)"
								class="btn btn-primary form-tool-btn btn-sm" role="button"
								title="添加"><i class="fa fa-plus"></i> 添加</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3"
							domainObject="formdialog_mobileCommandExtend_button_edit"
							permissionDes="编辑">
							<a id="mobileCommandExtend_modify" href="javascript:void(0)"
								class="btn btn-primary form-tool-btn btn-sm" role="button"
								title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3"
							domainObject="formdialog_mobileCommandExtend_button_delete"
							permissionDes="删除">
							<a id="mobileCommandExtend_del" href="javascript:void(0)"
								class="btn btn-primary form-tool-btn btn-sm" role="button"
								title="删除"><i class="fa fa-trash-o"></i> 删除</a>
						</sec:accesscontrollist>
					</div>
					<!-- <div class="toolbar-right">
						<div class="input-group form-tool-search" style="width: 125px">
							<input type="text" name="mobileCommandExtend_keyWord"
								id="mobileCommandExtend_keyWord" style="width: 125px;"
								class="form-control input-sm" placeholder="请输入查询条件"> <label
								id="mobileCommandExtend_searchPart"
								class="icon icon-search form-tool-searchicon"></label>
						</div>
						<div class="input-group-btn form-tool-searchbtn">
							<a id="mobileCommandExtend_searchAll" href="javascript:void(0)"
								class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
								<span class="caret"></span>
							</a>
						</div>
					</div> -->
				</div>
				<table id="mobileCommandExtendjqGrid"></table>
				<div id="jqGridPager"></div>
			</div>
			</div>
		</div>

			
	</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form">
		<table class="form_commonTable">
			<tr>
				<th width="10%">服务名称:</th>
				<td width="39%"><input title="服务名称"
					class="form-control input-sm" type="text" name="serviceName"
					id="serviceName" /></td>
			</tr>
			<tr>
				<th width="10%">服务基本地址:</th>
				<td width="39%"><input title="服务基本地址"
					class="form-control input-sm" type="text" name="serviceBaseurl"
					id="serviceBaseurl" /></td>
			</tr>
		</table>
	</form>
</div>
<!-- 子表高级查询 -->
 <%--<div id="searchDialogSub" style="overflow: auto; display: none">--%>
	<%--<form id="formSub">--%>
		<%--<input type="hidden" name="deptid" id="deptid" />--%>
		<%--<table class="form_commonTable">--%>
			<%--<tr>--%>
				<%--<th width="10%">header键名称:</th>--%>
				<%--<td width="39%"><input title="header键名称"--%>
					<%--class="form-control input-sm" type="text" name="headerName"--%>
					<%--id="headerName" /></td>--%>
				<%--<th width="10%">header值:</th>--%>
				<%--<td width="39%"><input title="header值"--%>
					<%--class="form-control input-sm" type="text" name="headerValue"--%>
					<%--id="headerValue" /></td>--%>
			<%--</tr>--%>
			<%--<tr>--%>
			<%--</tr>--%>
		<%--</table>--%>
	<%--</form>--%>
<%--</div>--%>

<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
	<form id="formSub">
		<input type="hidden" name="deptid" id="deptid"/>
		<table class="form_commonTable">
			<tr>
				<th width="10%">方法URL地址:</th>
				<td width="39%">
					<input title="方法URL地址" class="form-control input-sm" type="text" name="methodUrl" id="methodUrl" />
				</td>
			</tr>
			<tr>
				<th width="10%">方法类型</th>
				<td width="39%">
					<%--<input title="方法类型GET||POST" class="form-control input-sm" type="text" name="methodType" id="methodType" />--%>
					<select class="form-control input-sm"
							name="methodType" id="methodType"
							data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						<option value="">请选择</option>
						<option value="GET">GET</option>
						<option value="POST">POST</option>
					</select>
				</td>
			</tr>
			<tr>
				<th width="10%">方法名称:</th>
				<td width="39%">
					<input title="方法名称" class="form-control input-sm" type="text" name="methodName" id="methodName" />
				</td>
			</tr>
			<tr>
				<th width="10%">方法备注:</th>
				<td width="39%">
					<input title="方法备注" class="form-control input-sm" type="text" name="methodShowName" id="methodShowName" />
				</td>
			</tr>
			<tr>
			</tr>
		</table>
	</form>
</div>
<div  style="display:none">
	<form id="impForm" role="form" method="post" enctype="multipart/form-data" >
		<input name="impFile"
			   id="impFile"  type="file" title="导入command" data-options="validType:'maxLength[200]',required:true">
	</form>
</div>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script
	src="avicit/platform6/mobile/bootstrapmsecure/mobileserviceinfo/js/MobileServiceInfo.js"
	type="text/javascript"></script>
<script
	src="avicit/platform6/mobile/bootstrapmsecure/mobileserviceinfo/js/MobileServiceHeaders.js"
	type="text/javascript"></script>
<script
	src="avicit/platform6/mobile/bootstrapmsecure/mobileserviceinfo/js/MobileCommandExtend.js"
	type="text/javascript"></script>
<script
	src="avicit/platform6/mobile/bootstrapmsecure/mobileserviceinfo/js/MobileCommandInfo.js"
	type="text/javascript"></script>
<script
	src="avicit/platform6/mobile/bootstrapmsecure/mobileserviceinfo/js/MobileCommandHeaders.js"
	type="text/javascript"></script>

<script type="text/javascript" src="static/js/platform/component/common/exportData.js"></script>
<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
<script type="text/javascript">
	var mobileServiceInfo;
	var mobileServiceHeaders;
	var mobileCommandInfo;
	var mobileCommandHeaders;
	var mobileCommandExtend;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mobileServiceInfo.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="mobileServiceInfo.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}
	function statusAlias(value, row, index) {
		if (value == "GET") {
			return "GET";
		} else
			return "POST";
	}

	$(document)
			.ready(
					function() {
						var searchMainNames = new Array();
						var searchMainTips = new Array();
						searchMainNames.push("serviceName");
						searchMainTips.push("服务名称");
						searchMainNames.push("serviceBaseurl");
						searchMainTips.push("服务基本地址");
						var searchMainC = searchMainTips.length == 2 ? '或'
								+ searchMainTips[1] : "";
						$('#mobileServiceInfo_keyWord').attr('placeholder',
								'请输入' + searchMainTips[0] + searchMainC);

						var searchSubNames = new Array();
						var searchSubTips = new Array();
						searchSubNames.push("methodUrl");
						searchSubTips.push("url");
						searchSubNames.push("methodName");
						searchSubTips.push("方法名");
						var searchSubC = searchSubTips.length == 2 ? '或'
								+ searchSubTips[1] : "";
						$('#mobileCommandInfo_keyWord').attr('placeholder',
								'请输入' + searchSubTips[0] + searchSubC);
						var mobileServiceInfoGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 75,
							hidden : true
						}, {
							label : '服务名称',
							name : 'serviceName',
							width : 150,
							formatter : formatValue
						}, {
							label : '服务基本地址',
							name : 'serviceBaseurl',
							width : 150
						} ];
						var mobileServiceHeadersGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 75,
							hidden : true
						}, {
							label : '服务id外键',
							name : 'serviceId',
							width : 150,
							hidden : true
						}, {
							label : 'header键名称',
							name : 'headerName',
							width : 150
						}, {
							label : 'header值',
							name : 'headerValue',
							width : 150
						} ];
						var mobileCommandInfoGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 75,
							hidden : true
						}, {
							label : '服务id外键',
							name : 'serviceId',
							width : 150,
							formatter : formatValue,
							hidden : true
						}, {
							label : '方法URL地址',
							name : 'methodUrl',
							width : 150
						}, {
							label : '方法类型',
							name : 'methodType',
							width : 150,
							formatter : statusAlias
						}, {
							label : '方法名称',
							name : 'methodName',
							width : 150
						}, {
							label : '方法备注',
							name : 'methodShowName',
							width : 150,

						} ];
						var mobileCommandHeadersGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 75,
							hidden : true
						}, {
							label : '方法id外键',
							name : 'commandId',
							width : 150,
							hidden : true
						}, {
							label : 'header键名称',
							name : 'headerName',
							width : 150
						}, {
							label : 'header值',
							name : 'headerValue',
							width : 150
						} ];
						var dataGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 75,
							hidden : true
						}, {
							label : 'COMMAND_ID',
							name : 'commandId',
							width : 150,
							formatter : formatValue,
							hidden : true
						}, {
							label : '类名',
							name : 'className',
							width : 150
						}, {
							label : 'METHOD_NAME',
							name : 'methodName',
							width : 150,
							hidden : true
						} ];
						mobileServiceInfo = new MobileServiceInfo(
								'mobileServiceInfo',
								'${url}',
								'form',
								mobileServiceInfoGridColModel,
								'searchDialog',
								function(pid) {
									mobileServiceHeaders = new MobileServiceHeaders(
											'mobileServiceHeaders', '${surl}',
											mobileServiceHeadersGridColModel,
											pid, "mobileServiceHeaders_keyWord");
									mobileCommandInfo = new MobileCommandInfo(
											'mobileCommandInfo',
											'${s2url}',
											mobileCommandInfoGridColModel,
                                        "formSub",'searchDialogSub',
											pid, searchSubNames,
											function(pid2) {
												mobileCommandHeaders = new MobileCommandHeaders(
														'mobileCommandHeaders',
														'${ssurl}',
														mobileCommandHeadersGridColModel,
														pid2,
														"mobileCommandHeaders_keyWord");
												mobileCommandExtend = new MobileCommandExtend(
														'mobileCommandExtendjqGrid',
														'${ss2url}',
														'mobileCommandExtend_keyWord',
														pid2, dataGridColModel);
											},
											function(pid2) {
												mobileCommandHeaders.reLoad(pid2);
												mobileCommandExtend.reLoad(pid2);
											}, "mobileCommandInfo_keyWord");
								}, function(pid) {
									mobileServiceHeaders.reLoad(pid);
									mobileCommandInfo.reLoad(pid);
								}, searchMainNames, "mobileServiceInfo_keyWord");

						//主表操作
						//添加按钮绑定事件
						$('#mobileServiceInfo_insert').bind('click',
								function() {
									mobileServiceInfo.insert();
								});
						//编辑按钮绑定事件
						$('#mobileServiceInfo_modify').bind('click',
								function() {
									mobileServiceInfo.modify();
								});
						//删除按钮绑定事件
						$('#mobileServiceInfo_del').bind('click', function() {
							mobileServiceInfo.del();
						});
						//打开高级查询框
						$('#mobileServiceInfo_searchAll').bind(
								'click',
								function() {
									mobileServiceInfo.openSearchForm(this,
											$('#mobileServiceInfo'));
								});
						//关键字段查询按钮绑定事件
						$('#mobileServiceInfo_searchPart').bind('click',
								function() {
									mobileServiceInfo.searchByKeyWord();
								});

						//子表操作
						//添加按钮绑定事件
						$('#mobileServiceHeaders_insert').bind('click',
								function() {
									mobileServiceHeaders.insert();
								});
						//编辑按钮绑定事件
						$('#mobileServiceHeaders_modify').bind('click',
								function() {
									mobileServiceHeaders.modify();
								});
						//删除按钮绑定事件
						$('#mobileServiceHeaders_del').bind('click',
								function() {
									mobileServiceHeaders.del();
								});
						/* 					//打开高级查询
											$('#mobileServiceHeaders_searchAll').bind(
													'click',
													function() {
														mobileServiceHeaders.openSearchForm(this,
																$('#mobileServiceHeaders'));
													});
											//关键字段查询按钮绑定事件
											$('#mobileServiceHeaders_searchPart').bind('click',
													function() {
														mobileServiceHeaders.searchByKeyWord();
													}); */

						//子表操作
						//添加按钮绑定事件
						$('#mobileCommandInfo_insert').bind('click',
								function() {
									mobileCommandInfo.insert();
								});
						//编辑按钮绑定事件
						$('#mobileCommandInfo_modify').bind('click',
								function() {
									mobileCommandInfo.modify();
								});
						//删除按钮绑定事件
						$('#mobileCommandInfo_del').bind('click', function() {
							mobileCommandInfo.del();
						});
                        //导入按钮绑定事件
                        $('#mobileCommandInfo_imp').bind('click', function() {
                            $('input[id=impFile]').click();
                        });
                        //导入文件上传
                        $('#impFile').bind('change', function() {
                            if (checkfiletype('impFile')) {
                                mobileCommandInfo.imp('impForm');
                            }
                            $("#impFile").val("");
                        });
                        //导出按钮绑定事件
                        $('#mobileCommandInfo_exp').bind('click', function() {
                            mobileCommandInfo.exp();
                        });
						/* 						//打开高级查询框
						 $('#mobileCommandInfo_searchAll').bind(
						 'click',
						 function() {
						 mobileCommandInfo.openSearchForm(this,
						 $('#mobileCommandInfo'));
						 });
						 //关键字段查询按钮绑定事件
						 $('#mobileCommandInfo_searchPart').bind('click',
						 function() {
						 mobileCommandInfo.searchByKeyWord();
						 }); */

						//打开高级查询
						$('#mobileCommandInfo_searchAll').bind('click', function(){
							mobileCommandInfo.openSearchForm(this,$('#mobileCommandInfo'));
						});
						//关键字段查询按钮绑定事件
						$('#mobileCommandInfo_searchPart').bind('click', function(){
							mobileCommandInfo.searchByKeyWord();
						});

						//子表操作
						//添加按钮绑定事件
						$('#mobileCommandHeaders_insert').bind('click',
								function() {
									mobileCommandHeaders.insert();
								});
						//编辑按钮绑定事件
						$('#mobileCommandHeaders_modify').bind('click',
								function() {
									mobileCommandHeaders.modify();
								});
						//删除按钮绑定事件
						$('#mobileCommandHeaders_del').bind('click',
								function() {
									mobileCommandHeaders.del();
								});
						/* 						//打开高级查询
						 $('#mobileCommandHeaders_searchAll').bind(
						 'click',
						 function() {
						 mobileCommandHeaders.openSearchForm(this,
						 $('#mobileCommandHeaders'));
						 });
						 //关键字段查询按钮绑定事件
						 $('#mobileCommandHeaders_searchPart').bind('click',
						 function() {
						 mobileCommandHeaders.searchByKeyWord();
						 }); */

						//子2表操作
						//添加按钮绑定事件
						$('#mobileCommandExtend_insert').bind('click',
								function() {
									mobileCommandExtend.insert();
								});
						//编辑按钮绑定事件
						$('#mobileCommandExtend_modify').bind('click',
								function() {
									mobileCommandExtend.modify();
								});
						//删除按钮绑定事件
						$('#mobileCommandExtend_del').bind('click', function() {
							mobileCommandExtend.del();
						});
						//查询按钮绑定事件
						/* 						$('#mobileCommandExtend_searchPart').bind('click',
						 function() {
						 mobileCommandExtend.searchByKeyWord();
						 });
						 //打开高级查询框
						 $('#mobileCommandExtend_searchAll').bind(
						 'click',
						 function() {
						 mobileCommandExtend.openSearchForm(this,
						 $('#mobileCommandExtend'));
						 });
						 */
					});
</script>
</html>