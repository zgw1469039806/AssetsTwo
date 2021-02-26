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
<!-- ControllerPath = "platfrom6/tablecol/resteasysystem/resteasySystemController/toResteasySystemManage" -->
<title>服务授权管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div id="north1" data-options="region:'north',split:true,title:''" style="height:300px;overflow-x:hidden;">
		<div id="toolbar_resteasySystem" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_resteasySystem_button_add"
					permissionDes="主表添加">
					<a id="resteasySystem_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm btn-point" role="button"
						title="添加"><i class="icon icon-add"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_resteasySystem_button_edit"
					permissionDes="主表编辑">
					<a id="resteasySystem_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="icon icon-edit"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_resteasySystem_button_delete"
					permissionDes="主表删除">
					<a id="resteasySystem_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="icon icon-delete"></i> 删除</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_resteasyOrg_button"
					permissionDes="单位注册管理">
					<a id="resteasyOrg" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="单位注册管理"><i class="icon icon-zhuce"></i> 单位注册管理</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_resteasyAuth_button"
					permissionDes="服务授权管理">
					<a id="resteasyAuth" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="服务授权管理"><i class="icon icon-quanxian"></i> 服务授权管理</a>
				</sec:accesscontrollist>
			</div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 240px">
					<input type="text" name="resteasySystem_keyWord"
						id="resteasySystem_keyWord" style="width: 240px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="resteasySystem_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="resteasySystem_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="resteasySystem"></table>
		<div id="resteasySystemPager"></div>
	</div>
	<div id= "north2" data-options="region:'center',split:true,title:'用户管理',onResize:function(a,b){resizeSouth(a,b);}" style="padding:0px;">
		<div id="toolbar_resteasyUser" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_resteasyUser_button_add"
					permissionDes="子表添加">
					<a id="resteasyUser_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm btn-point" role="button"
						title="添加"><i class="icon icon-add"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_resteasyUser_button_edit"
					permissionDes="子表编辑">
					<a id="resteasyUser_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="icon icon-edit"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_resteasyUser_button_delete"
					permissionDes="子表删除">
					<a id="resteasyUser_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="icon icon-delete"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 240px">
					<input type="text" name="resteasyUser_keyWord"
						id="resteasyUser_keyWord" style="width: 240px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="resteasyUser_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="resteasyUser_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="resteasyUser"></table>
		<div id="resteasyUserPager"></div>
	</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form">
		<table class="form_commonTable">
			<tr>
				<th width="12%"><label for="orgId">所属单位:</label></th>
				<td width="37%" >
					<select class="form-control" name="orgId" id="orgId" title="" isNull="true" onchange="selectOnchang(this)"/>
				</td>
				<th width="12%"><label for="id">系统名称:</label></th>
				<td width="37%">
					<select class="form-control" name="id" id="id" title="" isNull="true" />
				</td>
			</tr>
			<tr>
				<th width="12%">系统描述:</th>
				<td width="37%"><input title="系统描述"
					class="form-control input-sm" type="text" name="systemDesc"
					id="systemDesc" /></td>
				<th width="12%">系统状态:</th>
				<td width="37%"><select class="form-control" name="status" id="status">
						<option ></option>
						<option value="1">有效</option>
						<option value="0">无效</option>
					</select></td>
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
				<th width="14%">用户名:</th>
				<td width="35%"><input title="用户名称"
					class="form-control input-sm" type="text" name="userName"
					id="userName" /></td>
				<th width="14%">BASEKEY:</th>
				<td width="35%"><input title="用户秘钥   由名称和密码MD5计算"
					class="form-control input-sm" type="text" name="baseKey"
					id="baseKey" /></td>
			</tr>
			<tr>
				<th width="14%">状态:</th>
				<td width="35%"><select class="form-control" name="status" id="status">
						<option ></option>
						<option value="1">有效</option>
						<option value="0">无效</option>
					</select></td>
			</tr>
			<tr>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script
	src="avicit/platform6/console/newRestmanage/js/ResteasySystem.js"
	type="text/javascript"></script>
<script
	src="avicit/platform6/console/newRestmanage/js/ResteasyUser.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var resteasySystem;
	var resteasyUser;
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="resteasySystem.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}

	$(document).ready(function() {
				$.ajax({  
		            url: 'platform/platfrom6/newrestmanage/controller/resteasyOrgController/operation/listAll',  
		            data : {
					 	id : ""
					},
				    type : 'post',
		            dataType: "json",  
		            success: function (data) {  
		            	$("#orgId").append("<option ></option>");
		                $.each(data, function (index, units) {  
		                    $("#orgId").append("<option value="+units.id+">" + units.orgName + "</option>");  
		                });
		            },  
		
		            error: function (XMLHttpRequest, textStatus, errorThrown) {  
		                alert("error");  
		            }  
		        });
				$.ajax({  
		            url: 'platform/platform6/newrestmanage/controller/resteasySystemController/operation/listAll',  
		            data : {
					 	id : ""
					},
				    type : 'post',
		            dataType: "json",  
		            success: function (data) {  
		            	$("#id").append("<option></option>");  
		                $.each(data, function (index, units) {  
		                    $("#id").append("<option value="+units.id+">" + units.systemName + "</option>");  
		                });
		            },  
		
		            error: function (XMLHttpRequest, textStatus, errorThrown) {  
		                alert("error");  
		            }  
		        });
				
				function formatStatus(cellvalue, options, rowObject) {
					if (cellvalue =="1"){    
				        return '有效';    
				    } else {    
				        return '无效';    
				    }  
				}
				var searchMainNames = new Array();
				var searchMainTips = new Array();
				searchMainNames.push("systemName");
				searchMainTips.push("系统名称");
				$('#resteasySystem_keyWord').attr('placeholder',
						'请输入' + searchMainTips[0]);
				var searchSubNames = new Array();
				var searchSubTips = new Array();
				searchSubNames.push("userName");
				searchSubTips.push("用户名");
				$('#resteasyUser_keyWord').attr('placeholder',
						'请输入' + searchSubTips[0]);
				var resteasySystemGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				},{
					label : '系统名称',
					name : 'systemName',
					width : 150
				}, {
					label : '所属单位',
					name : 'orgId',
					width : 150
				}, {
					label : '系统描述',
					name : 'systemDesc',
					width : 150
				}, {
					label : '系统状态',
					name : 'status',
					width : 150,
					formatter:formatStatus
				} ];
				var resteasyUserGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '用户名',
					name : 'userName',
					width : 150
				}, {
					label : '用户密码',
					name : 'userPassword',
					width : 150,
					hidden : true
				}, {
					label : 'BASEKEY',
					name : 'baseKey',
					width : 150
				}, {
					label : '状态',
					name : 'status',
					width : 150,
					formatter:formatStatus
				}, {
					label : '所属系统',
					name : 'systemId',
					width : 150,
					hidden : true
				}, {
					label : '用户类型   1系统间调用   0平台自己调用',
					name : 'type',
					width : 150,
					hidden : true
				} ];

				resteasySystem = new ResteasySystem('resteasySystem', '${url}',
						'form', resteasySystemGridColModel, 'searchDialog',
						function(pid) {
							resteasyUser = new ResteasyUser('resteasySystem','resteasyUser',
									'${surl}', "formSub",
									resteasyUserGridColModel,
									'searchDialogSub', pid, searchSubNames,
									"resteasyUser_keyWord");
						}, function(pid) {
							resteasyUser.reLoad(pid);
						}, searchMainNames, "resteasySystem_keyWord");
				//主表操作
				//添加按钮绑定事件
				$('#resteasySystem_insert').bind('click', function() {
					resteasySystem.insert();
				});
				//编辑按钮绑定事件
				$('#resteasySystem_modify').bind('click', function() {
					resteasySystem.modify();
				});
				//删除按钮绑定事件
				$('#resteasySystem_del').bind('click', function() {
					resteasySystem.del();
				});
				//单位注册按钮事件
				$('#resteasyOrg').bind('click', function() {
					resteasySystem.orgRegist();
				});
				//服务授权按钮事件
				$('#resteasyAuth').bind('click', function() {
					resteasySystem.restAuth();
				});
				//打开高级查询框
				$('#resteasySystem_searchAll').bind('click', function() {
					resteasySystem.openSearchForm(this, $('#resteasySystem'));
				});
				//关键字段查询按钮绑定事件
				$('#resteasySystem_searchPart').bind('click', function() {
					resteasySystem.searchByKeyWord();
				});
				//子表操作
				//添加按钮绑定事件
				$('#resteasyUser_insert').bind('click', function() {
					resteasyUser.insert();
				});
				//编辑按钮绑定事件
				$('#resteasyUser_modify').bind('click', function() {
					resteasyUser.modify();
				});
				//删除按钮绑定事件
				$('#resteasyUser_del').bind('click', function() {
					resteasyUser.del();
				});
				//打开高级查询
				$('#resteasyUser_searchAll').bind('click', function() {
					resteasyUser.openSearchForm(this, $('#resteasyUser'));
				});
				//关键字段查询按钮绑定事件
				$('#resteasyUser_searchPart').bind('click', function() {
					resteasyUser.searchByKeyWord();
				});

			});
			function selectOnchang(obj){ 
				var value = obj.options[obj.selectedIndex].value;
				$.ajax({  
		            url: 'platform/platform6/newrestmanage/controller/resteasySystemController/operation/listAll',  
		            data : {
					 	id : value
					},
				    type : 'post',
		            dataType: "json",  
		            success: function (data) { 
		            	$("#id").empty();
		            	$("#id").append("<option></option>");
		                $.each(data, function (index, units) {  
		                    $("#id").append("<option value="+units.id+">" + units.systemName + "</option>");  
		                });
		                $('#id').val('');
		            },  
		
		            error: function (XMLHttpRequest, textStatus, errorThrown) {  
		                alert("error");  
		            }  
		        });
			}
			//南侧拖拽修改改变时修改表格自适应
			function resizeSouth(width,height){
				var windowHeight = $(window).height();
				var topTableHeight = windowHeight - height
				$("#north1").height(topTableHeight-5);
				$('#resteasyUser').setGridHeight(height-145);
				$('#resteasySystem').setGridHeight(topTableHeight-120);
			}
</script>
</html>