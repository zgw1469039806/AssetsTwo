<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>按钮管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>

<%
	long timestamp = System.currentTimeMillis();
	String appId = SessionHelper.getApplicationId();
%>
<script>
var editIndex = -1;
var newRowCount = 0;
var op_indexed = [
	    		    {indexedid:'Y',indexedname:'是'},
	    		    {indexedid:'N',indexedname:'否'}
	    		];



var Common = {
	    TxtFormatter: function (value, rec, index) {
	        if (value == 'Y') {
	            return "是";
	        }
	        return "否";
	    }
}


function showAdd()
{
	newRowCount++;
	var myDatagrid=$('#dg');
	myDatagrid.datagrid('endEdit',editIndex);
	if(editIndex != -1){
		$.messager.alert('提示','不能添加，请确保上一条数据填写完整','warning');
		return;
	}
	myDatagrid.datagrid('insertRow',{
		index: 0,
		row:{isPage:'N',buttonOrder:'0',buttonIcon:'icon-edit',isDefault:'N'}
		});	
	myDatagrid.datagrid('selectRow', 0).datagrid('beginEdit',0);
	editIndex=0;
			
	// 有效无效的下拉框
	var ed = myDatagrid.datagrid('getEditor',{index:editIndex,field: 'isPage'});
	$(ed.target).combobox('loadData', op_indexed);
	
	//选择图标
	var ed = myDatagrid.datagrid('getEditor',{index: editIndex, field: 'buttonIcon'});
	$(ed.target).attr('disabled', true);
	$(ed.target).attr('id','buttonIcon'+newRowCount)
	var img = $('<span/>').addClass("input-right-icon");
	var div = $('<div/>').addClass("selector-div selector-div-bg");
	$(ed.target).wrap(div);
	$(ed.target).after(img);
	img.click(function(){
		var dlg = new CommonDialog("buttonIcon","600","400","avicit/platform6/eform/tabledefine/buttonIconChoose.jsp?id=buttonIcon"+newRowCount,"选择页");
		dlg.show();
	});
};


function dgOnClickRow(index,rowData){
	newRowCount++;
	var myDatagrid=$('#dg');
	var row = myDatagrid.datagrid('getSelected');
	if (row.isDefault!='Y'){
		myDatagrid.datagrid('endEdit', editIndex);
		if(editIndex==-1)
		{
			myDatagrid.datagrid('beginEdit', index);  
			editIndex=index;
			
			var ed = myDatagrid.datagrid('getEditor',{index:editIndex,field: 'isPage'});
			$(ed.target).combobox('loadData', op_indexed);
			
			//选择图标
			var ed = myDatagrid.datagrid('getEditor',{index: editIndex, field: 'buttonIcon'});
			$(ed.target).attr('disabled', true);
			$(ed.target).attr('id','buttonIcon'+newRowCount)
			var img = $('<span/>').addClass("input-right-icon");
			var div = $('<div/>').addClass("selector-div selector-div-bg");
			$(ed.target).wrap(div);
			$(ed.target).after(img);
			
			img.click(function(){
				var dlg = new CommonDialog("buttonIcon","600","400","avicit/platform6/eform/tabledefine/buttonIconChoose.jsp?id=buttonIcon"+newRowCount,"选择页");
				dlg.show();
			});
		}
		else
		{
			$.messager.alert('提示','不能编辑，请确保上一条数据填写完整','warning');
		}
	}
};


function onCheck(rowIndex,rowData){
	if (rowData.id){
		$("#scriptButton").linkbutton('enable');
	}else{
		$("#scriptButton").linkbutton('disable');
	}
}

function dgOnAfterEdit(rowIndex, rowData, changes)
{
	//成功完成编辑，包括校验
	editIndex=-1;
};

function dgOnLoadSuccess(data)
{
	$('#dg').datagrid('doCellTip',   
			{   
				onlyShowInterrupt:true,   
				position:'bottom',
				tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
			}); 
	
	if(editIndex != -1){
		$('#dgRole').datagrid('cancelEdit',editIndex);
		editIndex = -1;
	}
};

</script>
</head>

<body class="easyui-layout" fit="true">
	 <table id="dg"  class="easyui-datagrid"  url="platform/eform/custom/list.json?tableId=<%=(String)request.getParameter("tableId") %>" 
	 fit="true" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true" singleSelect="true" autoRowHeight="false" striped="true" 
	 data-options="onClickRow:dgOnClickRow,onCheck:onCheck,onAfterEdit:dgOnAfterEdit,onLoadSuccess:dgOnLoadSuccess">
		<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true" width="50">id</th>
				<th data-options="field:'buttonName',required:true,align:'center',editor:'text'"  width="25"><font color="red">*</font>按钮名称</th>
				<th data-options="field:'buttonCode',required:true,align:'center',editor:'text'"  width="25"><font color="red">*</font>按钮编码</th>
				<th data-options="field:'buttonIcon',required:true,align:'center',editor:'text'"  width="25"><font color="red">*</font>按钮图标</th>
				<th data-options="field:'remark',required:true,align:'center',editor:'text'"  width="40">备注</th>
				<th data-options="field:'buttonUrl',required:true,align:'center',editor:'text'"  width="80">跳转地址</th>
				<th data-options="field:'buttonOrder',required:true,align:'center',editor:'numberbox'"  width="25">排序</th>
				<th data-options="field:'isPage',required:true,align:'center',
						editor:{
							type:'combobox',
							options:{
								valueField:'indexedid',
								textField:'indexedname',
								data:op_indexed,
								panelHeight:'auto',
								required:true
							}
						}"  width="25"  formatter="Common.TxtFormatter"><font color="red">*</font>是否页面</th>
			</tr>
		</thead>
	</table>
	<!-- CRUD工具栏 -->
	<div id="toolbar">
		<table>
		<tr>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="showAdd()">添加</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveUser()">保存</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser()">删除</a></td>
		<td><a href="javascript:void(0)" id="scriptButton" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="addJs()">脚本</a></td>
		<td><a class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="closeForm();" href="javascript:void(0);">返回</a></td>
		</tr>
		</table>
	</div>
	
<script type="text/javascript">

var baseurl = '<%=request.getContextPath()%>';
var url;
var appId = "<%=appId%>";
var tableId='<%=(String)request.getParameter("tableId") %>';

function saveUser(){
	var myDatagrid=$('#dg');
	myDatagrid.datagrid('endEdit',editIndex);
	//alert(editIndex);
	//if(endEditing())
	//{
		//$.messager.alert('提示','不能保存，请确保上一条数据填写完整','warning');
		//return;
	//}
	var rows = myDatagrid.datagrid('getChanges');
	var data =JSON.stringify(rows);
	if(rows.length > 0)
	{
		for (var i=0;i<rows.length;i++){
			if(!rows[i].buttonName){
				$.messager.alert('提示',"按钮名称不能为空，请检查！",'warning');
				return;
			}
			if(!rows[i].buttonCode){
				$.messager.alert('提示',"按钮编码不能为空，请检查！",'warning');
				return;
			}
			if(!rows[i].buttonIcon){
				$.messager.alert('提示',"按钮图标不能为空，请检查！",'warning');
				return;
			}
		}
		 $.ajax({
			 url:'platform/eform/custom/save.json',
			 data : {tableId:tableId,data : data},
			 type : 'post',
			 dataType : 'json',
			 success : function(result){
				 if (result.success) {
						$.messager.show({
							title : '提示',
							msg : '保存成功！'
						});
						$('#dg').datagrid('reload');
				}else{
					$.messager.show({
						title : '错误',
						msg : result.msg
					});
				 } 
			 }
		 });
	 } 
}

function addJs(){
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			url = 'platform/eform/custom/initScript?id='+row.id;
			var  dlg = new CommonDialog("script","700","480",url,"编辑脚本",false,true,false);
			dlg.show();
		}else{
			$.messager.show({
				title : '错误',
				msg : '请选择按钮信息!'
			});
		}
}




function deleteUser() {

var row = $('#dg').datagrid('getSelected');


	url='platform/eform/custom/delete.json';
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		if(row.isDefault=='N'){
			$.messager.confirm('',
					'确认删除吗?',
					function(r) {
						if (r) {
							$.post(url, {
								id : row.id,
								tableId:tableId
							}, function(result) {
								if (result.success) {
									$.messager.show({
										title : '提示',
										msg : '删除成功！'
									});
									$('#dg').datagrid('reload');
								} else {
									$.messager.show({
										title : 'Error',
										msg : result.errorMsg
									});
								}
							}, 'json');
						}
			});
	}else{
		$.messager.show({
			title : '提示',
			msg : '默认按钮不能删除!'
	});
		
	}
}else{
	$.messager.show({
		title : '错误',
		msg : '请选择按钮信息!'
	});
}
}



function alertSuccess(title,msg){
	$.messager.show({
		title : title,
		msg : msg
	});
}

function dlg_close(id){
	$('#'+id).dialog('close');
	$.messager.show({
		 title : '提示',
		 msg : '保存成功！'
	});
}

function dlg_close_only(id){
$('#'+id).dialog('close');
}


function dg_reload(id){
$('#'+id).datagrid('reload'); 
}


function reloadByRowId(){
	var row=$('#dg').datagrid('getSelected');
	if(row){
		var tableId=row.id;
		url = 'platform/eform/tabledefine/listcolumn.html';
		$.post(url, {
			tableId:tableId
		}, function(result) {
			$('#dg1').datagrid('loadData',result);
		}, 'json');
	}
}

function reloaddg(){
	$('#dg').datagrid('reload'); 
}

function closeForm(){
	if(parent != null){
		parent.dlg_close_only("update");
	}
}

</script>
</body>
</html>