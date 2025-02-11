<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>

<title>通用选角色</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessUserDialogJsInclude.jsp"></jsp:include>

<script>
var baseurl = '<%=request.getContextPath()%>';
	var orgDatajson = ${orgDatajson};
	var isMultiple = ${isMultiple};
	//面门的调用方式
// 	function eventClick(){
// 		var usd = new UserSelectDialog('roleSelectCommonDialog',700,400,getPath2() + '/platform/user/bpmSelectUserAction/roleSelectCommon?isMultiple=true','地址簿');
// 		var buttons = [{
// 			text:'确定',
// 			id : 'processSubimt',
// 			iconCls : 'icon-submit',
// 			handler:function(){
// 				var frmId = $('#roleSelectCommonDialog iframe').attr('id');
// 				var frm = document.getElementById(frmId).contentWindow;
// 				var resultData = frm.getSelectedResultDataJson();
// 				usd.close();
// 			}
// 		}];
// 		usd.createButtonsInDialog(buttons);
// 		usd.show();
// 	}
	
$(function(){
	loadOrgTree();
 	loadSelectedTable();
 	window.setTimeout("expand()", 200);
 });
/**
 * 加载组织树
 */
function loadOrgTree(){
	 $('#orgTree').tree({
 		 checkbox : true,
 		 lines : true,
 		 method : 'post',
 		 data: orgDatajson,
 		 onBeforeExpand:function(node,param){
 			var beforeExpandUrl = '/platform/user/bpmSelectUserAction/roleNoUser?';
			var para = node.attributes.para;
			if(typeof(para) == 'undefined'){
				para = '';
			}
			$('#orgTree').tree('options').url = getPath2() + beforeExpandUrl + 'appId=&orgId=' + node.id; //appId为应用ID，备用
	    }
 	 });
}
/**
 * 画表格
 */
function loadSelectedTable(){
	 $('#selectTargetDataGrid').datagrid({
			fitColumns: true,
			remoteSort: false,
			nowrap:false,
			idField:'roleId',
			loadMsg:"数据加载中.....",
			rownumbers:true,
			height : 320,
			autoRowHeight: false,
			striped: true,
			collapsible:true,
			frozenColumns:[[
             {field:'ck',checkbox:true}
			]],
			columns:[[
				{field:'roleId',title:'角色ID',width:120,align:'left',hidden : true},
				{field:'roleName',title:'角色名称',width:150,align:'left'}
			]]
		});
}
//展开树
function expand() {
		var node = $('#orgTree').tree('getSelected');
		if(node){
			$('#orgTree').tree('expand',node.target);
		}else{
			$('#orgTree').tree('expandAll');
		}
}
/**
 * 选中按钮事件
 */
function eventSelectButtonClick(){
	var nodes = $('#orgTree').tree('getChecked');
	for(var i = 0; i < nodes.length; i++){
		if(nodes[i].attributes.nodeType != "role"){
			continue;
		}
		if(getRecordIndexInTargetDataGrid(nodes[i].id) == -1){
			var record = {
		    		roleId : nodes[i].id,
		    		roleName : nodes[i].text
			};
			if(!isMultiple){
				var data = {
						total : 0,
						rows : new Array()
				};
				$('#selectTargetDataGrid').datagrid('loadData',data);
			}
			$('#selectTargetDataGrid').datagrid('appendRow',record);   		
		}
	}
}
/**
 * 移除按钮事件
 */
function eventRemoveButtonClick(){
	var datas = $('#selectTargetDataGrid').datagrid('getChecked');
	var nodes = $('#orgTree').tree('getChecked');
	for(var i = 0 ; i < datas.length; i++){
		var data = datas[i];
		var index = getRecordIndexInTargetDataGrid(data.roleId);
		$('#selectTargetDataGrid').datagrid('deleteRow', index);
		
		for(var i = 0; i < nodes.length; i++){
			if(getRecordIndexInTargetDataGrid(nodes[i].id) == -1 && nodes[i].id == data.roleId){
				$('#orgTree').tree('uncheck',nodes[i].target); 		
			}
		}
	}
}
/**
 * 移除全部按钮事件
 */
function eventRemoveAllButtonClick(){
	var data = {
			total : 0,
			rows : new Array()
	};
	$('#selectTargetDataGrid').datagrid('loadData',data);
	
	var nodes = $('#orgTree').tree('getChecked');
	for(var i = 0; i < nodes.length; i++){
		if(getRecordIndexInTargetDataGrid(nodes[i].id) == -1){
			$('#orgTree').tree('uncheck',nodes[i].target); 		
		}
	}
}
function getRecordIndexInTargetDataGrid(roleId){
	var datas = $('#selectTargetDataGrid').datagrid('getData');
	if(datas.total == 0){
		return -1;
	} else {
		for( var i = 0 ; i < datas.rows.length ; i++){
			if(roleId == datas.rows[i].roleId){
				return i;
			}
		}
	}
	return -1;
}
function getSelectedResultDataJson(){
	return $('#selectTargetDataGrid').datagrid('getData').rows;
}
</script>
<style>
	.tree{
		width : 280px;
		height: 280px;
	}
	
</style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'west',title:'所有角色',split:true,collapsible:false"  style="width:300px;overflow: auto;">
	<ul id="orgTree"> </ul>  
</div>  
<div region="center" border="false" style="overflow: hidden;">
	<table border="0" width="100%">
		<tr>
			<td height="100%" width="20%" align="center">
				<input type="button" value=" 选    中  " style="cursor:pointer;"  onclick="eventSelectButtonClick();return false;"/><br/>
				<br/>
				<input type="button" value=" 移    除  "  style="cursor:pointer;"  onclick="eventRemoveButtonClick();return false;"/><br/>
				<br/>
				<input type="button" value="全部移除"  style="cursor:pointer;"  onclick="eventRemoveAllButtonClick();return false;"/><br/>
			</td>
			<td height="100%" width="80%">
					<div id="selectTargetDataGrid"></div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
