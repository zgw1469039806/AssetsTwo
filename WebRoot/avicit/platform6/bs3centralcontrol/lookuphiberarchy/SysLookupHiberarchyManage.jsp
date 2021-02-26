<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
 String importlibs = "common,table,tree,form";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,title:'应用列表',collapsible:false" style="width:260px;">
		<div id="tableToolbarM" class="toolbar">
			<div class="toolbar-left">
				<div class="input-group  input-group-sm">
					<input class="form-control" placeholder="输入名称查询" type="text"
						id="appSearchInput" name="txt"> <span
						class="input-group-btn">
						<button id="appSearch" class="btn btn-default" type="button">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</span>
				</div>
			</div>
		</div>
		<div id='mdiv' style="overflow: unset;">
			<table id="jqGridApp"></table>
		</div>
	</div>
	<div data-options="region:'center'">
		<ul id="_ztree" class="ztree"></ul>
	</div>
	<div data-options="region:'east',split:true,width:fixwidth(.6),collapsible:false"
		>
		<div id="tableToolbar" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_demoSingletree_save_" permissionDes="保存">
					<a href="javascript:;" id="sysLookupHiberarchy_save"
						class="btn btn-primary form-tool-btn typeb btn-sm" title="保存"><i
						class="glyphicon glyphicon-floppy-disk"></i> 保存</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_demoSingletree_insert_"
					permissionDes="添加平级节点">
					<a href="javascript:;" id="sysLookupHiberarchy_insert"
						class="btn btn-primary form-tool-btn btn-sm" title="添加平级节点"><i
						class="fa fa-plus"></i> 添加平级节点</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_demoSingletree_insertsub_"
					permissionDes="添加子节点">
					<a href="javascript:;" id="sysLookupHiberarchy_insertSub"
						class="btn btn-primary form-tool-btn btn-sm" title="添加子节点"><i
						class="fa fa-plus"></i> 添加子节点</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_demoSingletree_del_" permissionDes="删除">
					<a href="javascript:;" id="sysLookupHiberarchy_del"
						class="btn btn-primary form-tool-btn btn-sm" title="删除"><i
						class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
		</div>

		<form id='form'>
			<input type="hidden" name="id" id="id" /> <input type="hidden"
				name="version" id="version" /> <input type="hidden" name="parentId"
				id="parentId" />
			<table class="form_commonTable" width="100%">
				<tr>
					<th width="15%"><label for="lookupType" id="hidelookuptype">系统代码类型:</label></th>
					<td width="78%"><input class="form-control input-sm"
						type="text" name="lookupType" id="lookupType" /></td>
				</tr>
				<tr>
					<th><label for="systemFlag">使用级别:</label></th>
					<td><select class="form-control input-sm"
						name="systemFlag" id="systemFlag">
							<option value="0">公共使用</option>
							<option value="1">私有使用</option>
					</select></td>
				</tr>
				<tr>
					<th><label for="validFlag">有效标识:</label></th>
					<td><select class="form-control input-sm"
						name="validFlag" id="validFlag">
							<option value="1">有效</option>
							<option value="0">无效</option>
					</select></td>
				</tr>
				<tr>
					<th><label for="sysLanguageCode">多语言 :</label></th>
					<td><input class="form-control input-sm"
						type="text" name="sysLanguageCode" id="sysLanguageCode"
						disabled="disabled" /></td>
				</tr>
				<tr>
					<th><label for="typeValue">系统代码名称:</label></th>
					<td><input class="form-control input-sm"
						type="text" name="typeValue" id="typeValue" /></td>
				</tr>
				<tr>
					<th><label for="typeKey">系统代码值:</label></th>
					<td><input class="form-control input-sm"
						type="text" name="typeKey" id="typeKey" /></td>
				</tr>
				<tr>
					<th><label for="orderBy">排序:</label></th>
					<td>
						<div class="input-group input-group-sm spinner"
							data-trigger="spinner">
							<input class="form-control" type="text" name="orderBy"
								id="orderBy" data-min="0" data-max="999999999999" data-step="1"
								data-precision="0"> <span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i
									class="glyphicon glyphicon-triangle-top"></i></a> <a
								href="javascript:;" class="spin-down" data-spin="down"><i
									class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th><label for="remark">备注:</label></th>
					<td><textarea class="form-control input-sm"
							rows="3" name="remark" id="remark"></textarea></td>
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
	<!-- 模块js -->
	<script
		src="avicit/platform6/bs3centralcontrol/appliaction/js/AppList.js"
		type="text/javascript"></script>
	<script
		src="avicit/platform6/bs3centralcontrol/lookuphiberarchy/js/SysLookupHiberarchy.js"
		type="text/javascript"></script>
	<script type="text/javascript">
	var appid = "";
	var sysLookupHiberarchy;
	$(document).ready(function(){
		sysAppTree = new AppList('jqGridApp','1','searchDialog','form','keyWord');
		
		sysAppTree.setOnSelect(function(appId){
			appid = appId;
			sysLookupHiberarchy = new SysLookupHiberarchy('_ztree','${url}','form','txt','searchbtn',appid);
			sysLookupHiberarchy.formvaliad(); //form表单校验
		});
		
	    //sysLookupHiberarchy.init();
		$('.date-picker').datepicker();
		$('.time-picker').datetimepicker({
		    closeText:'确定',//关闭按钮文案
			oneLine:true,//单行显示时分秒
			showButtonPanel:true,//是否展示功能按钮面板
			showSecond:false,//是否可以选择秒，默认否
			beforeShow: function(selectedDate) {
				if($('#'+selectedDate.id).val()==""){
					$(this).datetimepicker("setDate", new Date());
					$('#'+selectedDate.id).val('');
				}
			}
		});
		//禁止用户手动输入时间绑定事件
		$('.date-picker').on('keydown',nullInput);
		$('.time-picker').on('keydown',nullInput);
		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        		//按钮绑定事件
        $('#sysLookupHiberarchy_save').bind('click', function(){
        	sysLookupHiberarchy.save();
        });
	    $('#sysLookupHiberarchy_insert').bind('click',function(){
	    	sysLookupHiberarchy.insert();
	    });
	    $('#sysLookupHiberarchy_insertSub').bind('click',function(){
	    	sysLookupHiberarchy.insertSub();
	    });
	    $('#sysLookupHiberarchy_del').bind('click',function(){
	    	sysLookupHiberarchy.del();
	    });
	});
</script>
</body>
</html>