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
// 		var usd = new UserSelectDialog('roleSelectCommonDialog',700,400,getPath2() + '/platform/user/bpmSelectUserAction/positionSelectCommon?isMultiple=true','地址簿');
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
 	if(parent && parent.getPositionLoadData){
	 	var arr = parent.getPositionLoadData();
 		if(arr){
 			for(var i = 0; i < arr.length; i++){
 				var record = {
 			    		positionId : arr[i].positionId,
 			    		positionName : arr[i].positionName,
 			    		positionCode : arr[i].positionCode
 				};
 			 	$('#selectTargetDataGrid').datagrid('appendRow',record);
 			}
 		}
 	}
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
 			var beforeExpandUrl = '/platform/user/bpmSelectUserAction/positionNoUser?';
			var para = node.attributes.para;
			if(typeof(para) == 'undefined'){
				para = '';
			}
			$('#orgTree').tree('options').url = getPath2() + beforeExpandUrl + 'appId=&orgId='+node.id; //appId为应用ID，备用
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
			idField:'positionId',
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
				{field:'positionId',title:'岗位ID',width:120,align:'left',hidden : true},
				{field:'positionCode',title:'岗位Code',width:120,align:'left',hidden : true},
				{field:'positionName',title:'岗位名称',width:150,align:'left'}
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
		if(getRecordIndexInTargetDataGrid(nodes[i].id) == -1){
			if(nodes[i].attributes.nodeType != "position"){
				continue;
			}
			var record = {
		    		positionId : nodes[i].id,
		    		positionName : nodes[i].text,
		    		positionCode : nodes[i].attributes.code
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
		var index = getRecordIndexInTargetDataGrid(data.positionId);
		$('#selectTargetDataGrid').datagrid('deleteRow', index);
		
		for(var i = 0; i < nodes.length; i++){
			if(getRecordIndexInTargetDataGrid(nodes[i].id) == -1 && nodes[i].id == data.positionId){
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
function getRecordIndexInTargetDataGrid(positionId){
	var datas = $('#selectTargetDataGrid').datagrid('getData');
	if(datas.total == 0){
		return -1;
	} else {
		for( var i = 0 ; i < datas.rows.length ; i++){
			if(positionId == datas.rows[i].positionId){
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
<div data-options="region:'west',title:'所有岗位',split:true,collapsible:false"  style="width:300px;overflow: auto;">
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
