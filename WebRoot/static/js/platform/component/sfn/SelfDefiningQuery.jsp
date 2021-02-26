<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>高级查询</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<link href="static/js/platform/component/sfn/DefiningQuery.css" type="text/css" rel="stylesheet">
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,title:'查询字段',collapsible:false" style="width:200px;height:0; overflow:hidden;">
	 	<table id="selfDefGrid" class="easyui-datagrid"
				data-options="
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					striped:true
					">
				<thead>
					<tr>
						<th data-options="field:'name',align:'center'" width="220">字段</th>
						<th data-options="field:'field',hidden:true" width="220"></th>
					</tr>
				</thead>
			</table>
 	</div>
 	<div data-options="region:'center'" style="padding:0px;width:200px;height:0;">   
 		<div class="easyui-layout" data-options="fit:true">
 			<div data-options="region:'north'" style="background:#ffffff;padding:0px;overflow: hidden;">
 				<div id="selfDefQuryButtons" class="datagrid-toolbar">
				 	<table>
				 		<tr>
							<!-- <td><a class="easyui-linkbutton" id='add' iconCls="icon-add" plain="true" href="javascript:void(0);">添加条件</a></td> -->
							<td><a class="easyui-linkbutton" id='add1' iconCls="icon-edit" plain="true"  href="javascript:void(0);">添加条件</a></td>
							<td><a class="easyui-linkbutton" id='del' iconCls="icon-remove" plain="true" href="javascript:void(0);">删除</a></td>
							<td><a class="easyui-linkbutton" id='query' iconCls="icon-search" plain="true" href="javascript:void(0);">查询</a></td>
							<!-- <td><a class="easyui-linkbutton" id='cal' iconCls="icon-remove" plain="true" title='计算表达式' href="javascript:void(0);">计算</a></td> -->
						</tr>
				 	</table>
			 	</div>
 			</div>   
			<div data-options="region:'center',title:'查询规则'" style="background:#ffffff;padding:0px;">
		 		<ul id="selfDefTree" class="easyui-tree">正在加载应用列表...</ul>
			</div>
			<div data-options="region:'east',title:'查询表达式',split:true" style="width:250px;background:#f5fafe;">
				<div id='myParser'></div>
			</div>
 		</div>
    </div>
    <div id="selfDefRule" data-options="iconCls:'icon-search',resizable:false,modal:true,buttons:'#searchBtns'" style="width:356px; height:216px;display:none;">
        <form id="uiFormDemo">
            <table class="form_commonTable">
    			<tr>
    				<th width="10%">查询条件列:</th>
    				<td width="30%">
    				<span id="ruleName">字段</span></td>
    			</tr>
    			<tr>
    				<th width="10%">逻辑运算符:</th>
    				<td width="30%">
    					<input name="ruleOpt" id="ruleOpt" class="easyui-combobox"  data-options="editable:false,panelHeight:'10px',valueField: 'key',textField: 'value',onShowPanel:comboboxOnShowPanel"/>
    				</td>
    			</tr>
    			<tr>
    				<th width="10%">查询条件值:</th>
    				<td width="30%">
    					<div id='d_string' class="dnf-none">
    						<input id="d_string_v" class="easyui-validatebox" type="text" name="ruleValue"/>
    					</div>
    					<div id='d_datetime' class="dnf-none">
    						<input id="d_datetime_v" class="easyui-datetimebox" editable="false" style="width:150px;" />
    					</div>
    					<div id='d_date' class="dnf-none">
    						<input id="d_date_v" class="easyui-datebox" editable="false" style="width:150px;" />
    					</div>
    					
    					<div id='d_number' class="dnf-none">
    						<input id="d_number_v" class="easyui-numberbox" data-options="precision:2" style="width:150px;" />
    					</div>
    					
    					<div id='d_dict' class="dnf-none">
    						<input name="syslogType" id="d_dict_v" class="easyui-combobox" data-options="
									valueField:'lookupCode',
									textField:'lookupName',
									editable:false,
									panelHeight:'auto'
								"/>
    					</div>
    					<div id='d_role' class="dnf-none">
    						<input class="inputbox" type="hidden" id="roleId"/>
							<input class="easyui-validatebox"  name="roleName"   id="roleName"  readOnly="readOnly" style="width:149px;"/>
    					</div>
    					<div id='d_dept' class ="dnf-none">
    						<input class="inputbox" type="hidden" id="deptId"/>
							<input class="easyui-validatebox" id="deptName"  readOnly="readOnly"/>
    					</div>
    					<div id='d_user' class ="dnf-none">
    						<input class="inputbox" type="hidden" id="userId"/>
							<input class="easyui-validatebox" id="userName" readOnly="readOnly"/>
    					</div>
    					<div id='d_group' class ="dnf-none">
    						<input class="inputbox" type="hidden" id="groupId"/>
							<input class="easyui-validatebox" id="groupName"  readOnly="readOnly"/>
    					</div>
    					<div id='d_post' class ="dnf-none">
    						<input class="inputbox" type="hidden" id="postId"/>
							<input class="easyui-validatebox" id="postName"  readOnly="readOnly"/>
    					</div>
    				</td>
    			</tr>
    		</table>
        </form>
        <div id="searchBtns" class="datagrid-toolbar foot-formopera">
        	<table class="tableForm" border="0" cellspacing="1" width='100%'>
                <tr>
                    <td align="right">
                        <a title="保存" id="ruleBtns_ensure" class="easyui-linkbutton primary-btn"  href="javascript:void(0);">确定</a>
	                    <a title="返回" id="ruleBtns_cancel" class="easyui-linkbutton" href="javascript:void(0);">取消</a>
                    </td>
                </tr>
            </table>
        </div>
   	</div>
<script src="static/js/platform/component/sfn/DefiningQuery.js" type="text/javascript"></script>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script type="text/javascript">
	$(function(){
		var s=parent.selfDefQury
		 if(s){
			 defQury.init(s);
		 }else{
			 alert('父页面缺少对象【selfDefQury】');
		 }
	});
</script>
</body>
</html>