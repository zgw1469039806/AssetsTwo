<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>岗位管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>

<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
var editIndex = -1;
var validComboData=[{lookupCode:"3",lookupName:'无效'},{lookupCode:"1",lookupName:'正常'}];

$(document).ready(function(){ 
	
	$('#searchPositionDialog').dialog('close');
	$('#searchUserDialog').dialog('close');
	
	
	$('#searchUserDialog').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchUser();
		}
	});
	
	$('#searchPositionDialog').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchPosition();
		}
	});
});

/**
 * 加载群组信息
 */
function loadPositionInfo(){
	$("#dgPosition").datagrid("options").url ="platform/sysposition/sysPositionController/getSysPositionVoList.json";
	$('#dgPosition').datagrid("reload", {});
	$("#dgPosition").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');		
};

function loadSearchPositionInfo( positionName, positionCode){
	$("#dgPosition").datagrid("options").url ="platform/sysposition/sysPositionController/getSysPositionVoList.json";
	$('#dgPosition').datagrid("reload", 
			{
				positionName: positionName, 
				positionCode: positionCode
			}
	);
	$("#dgPosition").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
};


var selectId ="";
function dgPositionOnClickRow(index,rowData){
	var myDatagrid=$('#dgPosition');
	myDatagrid.datagrid('endEdit', editIndex);
	if(editIndex==-1){
		myDatagrid.datagrid('beginEdit', index);  
		editIndex=index;
		// 获取群组中的用户列表
		selectId=rowData.id;
	    loadUserInfo(rowData.id);
	}
	else
	{
		$.messager.alert('提示','不能编辑，请确保上一条数据填写完整','warning');
	}
	
    
}

function dgPositionOnAfterEdit(rowIndex, rowData, changes)
{
	//成功完成编辑，包括校验
	editIndex=-1;
} 

function dgPositionOnLoadSuccess(data)
{
	if(editIndex != -1){
		$('#dgPosition').datagrid('cancelEdit',editIndex);
		editIndex = -1;
	}
}

function formatcombobox(value){
	if(value ==null ||value == ''){
		return '';
	}
	for(var i =0 ,length = validComboData.length; i<length;i++){
				
		if(validComboData[i].lookupCode == value){
						
			return validComboData[i].lookupName;
		}
	}
}

/*增加一条记录*/

function showAddPosition()
{
	
	
	var myDatagrid=$('#dgPosition');
	myDatagrid.datagrid('endEdit',editIndex);
	if(editIndex != -1){
		$.messager.alert('提示','不能添加，请确保上一条数据填写完整','warning');
		return;
	}
	myDatagrid.datagrid('insertRow',{
		index: 0,
		row:{id:"", orderBy: '0'}
		});	
	myDatagrid.datagrid('selectRow', 0).datagrid('beginEdit',0);
	editIndex=0;
	// 清空用户
	loadUserInfo(null);
	
}


function savePosition()
{
	var myDatagrid=$('#dgPosition');
	myDatagrid.datagrid('endEdit',editIndex);
	
	if(editIndex!=-1)
	{
		$.messager.alert('提示','不能保存，请确保上一条数据填写完整','warning');
		return;
	}
	
	var rows = myDatagrid.datagrid('getChanges');
	var data =JSON.stringify(rows);
	if(rows.length > 0)
	{
		 $.ajax({
			 url:'platform/sysposition/sysPositionController/saveSysPositionVo.json',
			 data : {datas : data},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				if(r.result==0){
					 loadPositionInfo();
					 $.messager.show({
						 title : '提示',
						 msg : '保存成功'
					 });
				 }else{
					 $.messager.alert('提示',r.msg,'warning');
				 } 
			 }
		 });
	 } 
}

/*删除选中数据*/
function deletePosition(){
  
	var myDatagrid=$('#dgPosition');
	
	var rows = myDatagrid.datagrid('getChecked');
	var ids = [];
	var l =rows.length;
	if (l > 0) {
		$.messager.confirm('请确认', '您确定要删除当前所选的数据？', function(b) {
			if (b) {
				
				for(;l--;){
					ids.push(rows[l].id);
			 	}
				$.ajax({
					url:'platform/sysposition/sysPositionController/deleteSysPositionVo',
				 	data:	JSON.stringify(ids),
				 	contentType : 'application/json',
				 	type : 'post',
				 	dataType : 'json',
					success : function(r) {
						
						if(r.result==0){
							loadPositionInfo();
							editIndex = -1;
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
						else
						{
							$.messager.alert('提示',r.msg,'warning');
						}
					}
				}); 
			}
		});
	} else {
		$.messager.alert('提示', '请选择要删除的记录！', 'warning');
	}
}

function showSearchPosition()
{
	$('#searchPositionDialog').dialog('open');
		
}

function hideSearchPosition()
{
	$('#searchPositionDialog').dialog('close');
}

function searchPosition()
{
	
	var positionName= $('#filter_LIKE_positionName').val();
	var positionCode= $('#filter_LIKE_positionCode').val();
	
	expSearchParams={positionName: positionName, positionCode: positionCode};
	
	loadSearchPositionInfo( positionName, positionCode);
}

function clearPosition()
{
	$('#filter_LIKE_positionName').val('');
	$('#filter_LIKE_positionCode').val('');
	
}




function loadUserInfo(positionId)
{
	//filter_EQ_ug_groupId
	if(positionId==null){
		
		$('#dgUser').datagrid("loadData", []);
		$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	}
	else{
		$("#dgUser").datagrid("options").url ="platform/sysposition/sysPositionController/getUserListByPage/null";
		$('#dgUser').datagrid("reload", {positionId: positionId});
		$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
	}
}

function changePosition()
{
	var myDatagrid=$('#dgPosition');
	var rows = myDatagrid.datagrid('getChecked');
	
	if(rows.length!=1)
	{
		$.messager.alert('提示','请选择一个岗位','warning');
		return;
	}
	
	var row=rows[0];
	var positionId=row.id;
	if(!positionId){
		$.messager.alert('提示','请先保存该岗位','warning');
		return;
	}
	var usd = new CommonDialog("userAddDialog","800","500","platform/sysposition/sysPositionController/changePosition/"+positionId,"批量换岗");
	var buttons = [{
		text:'添加',
		id : 'formSubimt',
		//iconCls : 'icon-submit',
		handler:function(){
			 var frmId = $('#userAddDialog iframe').attr('id');
			 var frm = document.getElementById(frmId).contentWindow;
			 
			 var myDatagrid=frm.$('#dgUser');
			 var rows = myDatagrid.datagrid('getChecked');
			 
			 if(rows.length==0)
			 {
				 $.messager.alert('提示',"请选择你要添加的用户",'warning');
				 return;
			 }
			 
			 var data = [];
			 
			 for(var i=0;i<rows.length;i++)
				 data.push(rows[i].id);
			 
			 $.ajax({
		        cache: false,
		        type: "POST",
		        url:'platform/sysposition/sysPositionController/doChangeUserPosition',
		        dataType:"json",
		        data: {positionId: positionId, sysUserIds: data.join(',')},
		        error: function(request) {
		        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
		        },
		        success: function(data) {
					if(data.result==0){
						
						loadUserInfo(positionId);
						
						usd.close();
						
						$.messager.show({
							title : '提示',
							msg : '添加成功！'
						});
					}else{
						$.messager.alert('提示',data.msg,'warning');
					}
		        }
		    }); 
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
	
}

function deleteUser()
{
	
	if(editIndex==-1)
	{
		$.messager.alert('提示','请选择一个角色','warning');
		return;
	}
	
	var row=$('#dgRole').datagrid('getRows')[editIndex];
	var roleId=row.id;
	
		
	var rows = $('#dgUser').datagrid('getChecked');
	var data =JSON.stringify(rows);
	
	if (rows.length > 0) {
		$.messager.confirm('请确认', '您确定要删除当前所选的数据？', function(b) {
			if (b) {
								
				$.ajax({
					url : 'platform/sysrole/sysRoleController/deleteUserRole',
					data : {
						datas : data, roleId: roleId
					},
					type : 'post',
					dataType : 'json',
					success : function(r) {
						
						if(r.result==0){
							
							loadUserInfo(roleId);
							
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
						else
						{
							$.messager.alert('提示','删除失败','warning');
						}
					}
				}); 
			}
		});
	} else {
		$.messager.alert('提示', '请选择要删除的记录！', 'warning');
	}
}

function showSearchUser()
{
	$('#filter_EQ_u_status').combobox('loadData', [{lookupCode: '', lookupName:'所有'}].concat(validComboData));
	$('#searchUserDialog').dialog("open");
}


function hideSearchUser()
{
	$('#searchUserDialog').dialog('close');
}

function searchUser()
{
	if(editIndex==-1)
	{
		$.messager.alert('提示','请选择一个岗位','warning');
		return;
	}
	
	var row=$('#dgPosition').datagrid('getRows')[editIndex];
	var positionId=row.id;
	
	
	var name= $('#filter_LIKE_u_name').val();
	var loginName= $('#filter_LIKE_u_loginName').val();
	var status= $('#filter_EQ_u_status').combobox('getValue');
	//alert(searchName+","+validFlag);
	
	loadSearchUserInfo(positionId, name, loginName,status);
}

function clearUser()
{
	$('#filter_LIKE_u_name').val('');
	$('#filter_LIKE_u_loginName').val('');
	$('#filter_EQ_u_status').combobox('select', '');
}

function loadSearchUserInfo(positionId, name, loginName,status){
		
	$("#dgUser").datagrid("options").url ="platform/sysposition/sysPositionController/getUserListByPage/null";
	$('#dgUser').datagrid("reload", {"positionId": positionId, "filter-LIKE-NAME": name,"filter-EQ-STATUS": status, "filter-LIKE-LOGIN_NAME": loginName});
	$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
	
}

var expSearchParams={};
 
function importPosition()
 {
	 var imp = new CommonDialog("importData","700","400",'platform/excelImportController/excelimport/importPosition/xls',"Excel数据导入",false,true,false);
	 imp.show();
 }


function closeImportData(){
	$("#importData").dialog('close');
}

/**
 * 导出岗位(客户端数据)
 */
function exportClientData(){
	$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
        if (r) {
            //封装参数
            var columnFieldsOptions = getGridColumnFieldsOptions('dgPosition');
            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
            var rows = $('#dgPosition').datagrid('getRows');
            var datas = JSON.stringify(rows);
            var myParams = {
                dataGridFields: dataGridFields,//表头信息集合
                datas: datas,//数据集
                hasRowNum : true,//默认为Y:代表第一列为序号
                sheetName: 'sheet1',//如果该参数为空，默认为导出的Excel文件名
                unContainFields : 'ID',
                fileName: '平台岗位导出数据'//导出的Excel文件名
            };
            //var url = "platform/commonExcelController/exportExcelClientData";
            var url = "platform/sysposition/sysPositionController/exportClient";
            var ep = new exportData("xlsExport","xlsExport",myParams,url);
            ep.excuteExport();
        }
       });
}
/**
 * 导出岗位(服务端数据)
 */
function exportServerData(){
	$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
        if (r) {
            //封装参数
            var columnFieldsOptions = getGridColumnFieldsOptions('dgPosition');
            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
            expSearchParams = expSearchParams?expSearchParams:{};
     
            expSearchParams.dataGridFields=dataGridFields;
       
            expSearchParams.hasRowNum=true;
            expSearchParams.sheetName='sheet1';
            //expSearchParams.unContainFields='STATUS_LABEL,EMAIL';
            expSearchParams.fileName='平台岗位导出数据';
            expSearchParams.unContainFields='ID';
            var positionName= $('#filter_LIKE_positionName').val();
        	var positionCode= $('#filter_LIKE_positionCode').val();
        	
            expSearchParams.positionName =positionName;
            expSearchParams.positionCode=positionCode;
            
            var url = "platform/sysposition/sysPositionController/exportServer";

            var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
            ep.excuteExport();
        }
       });
}


</script>
</head>

<body class="easyui-layout" fit="true">

		<div data-options="region:'north',split:true,title:''" style="height: 300px; padding:0px;">
		
			<div id="toolbarPosition" class="datagrid-toolbar">
					<a id="btAddGroup"  class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="showAddPosition();" href="javascript:void(0);">添加</a>
					<a id="btSaveGroup"  class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="savePosition();" href="javascript:void(0);">保存</a>
					<a id="btChangePosition" class="easyui-linkbutton" iconCls="icon-setting"  plain="true" onclick="changePosition();" href="javascript:void(0);">批量换岗</a>
					<a id="btImportPosition" class="easyui-linkbutton" iconCls="icon-import"  plain="true" onclick="importPosition();" href="javascript:void(0);">导入岗位</a>
					<td><a class="easyui-menubutton"  data-options="menu:'#export',iconCls:'icon-export'" href="javascript:void(0);">导出岗位</a></td>
					<a id="btDeleteGroup" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="deletePosition();" href="javascript:void(0);">删除</a>
					<a id="btSearchGroup" class="easyui-linkbutton" iconCls="icon-search"  plain="true" onclick="showSearchPosition();" href="javascript:void(0);">查询</a>
			</div>
			
			<div id="export" style="width:150px;">
						<div data-options="iconCls:'icon-excel'" onclick="exportClientData();">Excel导出(客户端)</div>
						<div data-options="iconCls:'icon-excel'" onclick="exportServerData();">Excel导出(服务器端)</div>
					</div>
					
			<table id="dgPosition" class="easyui-datagrid"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					toolbar:'#toolbarPosition',
					idField :'id',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					
					pagination:true,
					pageSize:10,
					pageList:dataOptions.pageList,
					
					striped:true,
					
					url: 'platform/sysposition/sysPositionController/getSysPositionVoList.json',
					
					onClickRow: dgPositionOnClickRow,
					onAfterEdit: dgPositionOnAfterEdit,
					onLoadSuccess: dgPositionOnLoadSuccess
					">
				<thead>
					<tr>
						<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
						<th data-options="field:'positionName', halign:'center',align:'left',required:true" editor="{type:'validatebox',options:{required:true}}" width="220"><span class="red-start">*</span>岗位名称</th>
						<th data-options="field:'positionCode', halign:'center',align:'left',required:true" editor="{type:'validatebox',options:{required:true}}" width="220"><span class="red-start">*</span>岗位编码</th>
						<th data-options="field:'positionDesc', halign:'center',align:'left'" editor="{type:'text'}" width="220">描述</th>
						<th data-options="field:'orderBy',halign:'center',align:'left'" editor="{type:'numberbox',options:{required:true,min:0}}"  width="220">排序编号</th>
										
					</tr>
				</thead>
			</table>		
				
		</div>	
		
		<div id="searchPositionDialog" class="easyui-dialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" 
			style="width: 600px;height:150px; visible: hidden" title="查询岗位">
			<form id="searchGroupForm">
	    		<table>
	    			<tr>
	    				<td>岗位编码:</td><td><input type='text' class="easyui-validatebox" name="filter_LIKE_positionCode" id="filter_LIKE_positionCode"/></td>
	    				<td>岗位名称:</td><td><input type='text' class="easyui-validatebox" name="filter_LIKE_positionName" id="filter_LIKE_positionName"/></td>
	    			</tr>
	    			
	    				    			
	    		</table>
	    	</form>
	    	<div id="searchBtns">
	    		<a class="easyui-linkbutton" plain="false" onclick="searchPosition();" href="javascript:void(0);">查询</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="clearPosition();" href="javascript:void(0);">清空</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="hideSearchPosition();" href="javascript:void(0);">返回</a>
	    	</div>
	    </div>
		
		<div data-options="region:'center',split:true,title:''" style="padding:0px;">	
		
			<div id="toolbarUser" class="datagrid-toolbar">
					<a id="btSearchUser" class="easyui-linkbutton" iconCls="icon-search"  plain="true" onclick="showSearchUser();" href="javascript:void(0);">查询用户</a>
			</div>
					
			<table id="dgUser" class="easyui-datagrid"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					toolbar:'#toolbarUser',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					
					pagination:true,
					pageSize:dataOptions.pageSize,
					pageList:dataOptions.pageList,
					
					striped:true
							
					">
				<thead>
					<tr>
						<th data-options="field:'no',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">用户编号</th>
						<th data-options="field:'name',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">用户名</th>
						<th data-options="field:'nameEn',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">英文名</th>
						<th data-options="field:'loginName',halign:'center',align:'left'" editor="{type:'text'}"  width="220">登录名</th>
						<th data-options="field:'deptCode',halign:'center',align:'left'" editor="{type:'text'}"  width="220">部门编号</th>
						<th data-options="field:'deptName',halign:'center',align:'left'" editor="{type:'text'}"  width="220">所属部门</th>
						<th data-options="field:'status',halign:'center',align:'left', formatter: formatcombobox" editor="{type:'combobox',options:{required:true,panelHeight:'auto',editable:false,valueField:'lookupCode',textField:'lookupName'}}"  width="220">状态</th>
						<th data-options="field:'remark',halign:'center',align:'left'" editor="{type:'text'}"  width="220">描述</th>
						
					</tr>
				</thead>
			</table>	
		</div>
		
		<div id="searchUserDialog" class="easyui-dialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchUserBtns'" 
			style="width: 500px;visible: hidden" title="查询用户">
			<form id="searchUserForm">
	    		<table>
	    			<tr style="height:5px;">
	    			</tr>
	    			<tr>
	    				<td>用户名:</td><td><input type='text' class='easyui-validatebox' name="filter_LIKE_name" id="filter_LIKE_u_name"/></td>
	    				<td>登录名:</td><td><input type='text' class='easyui-validatebox' name="filter_LIKE_loginName" id="filter_LIKE_u_loginName"/></td>
	    			</tr>
	    			<tr style="height:5px;">
	    			</tr>
	    			<tr>
	    				<td>状态:</td><td><input id="filter_EQ_u_status" class="easyui-combobox" name="filter_EQ_u_status"  
    						 data-options="panelHeight:'auto', editable:false,valueField:'lookupCode',textField:'lookupName', data: [{lookupCode:'1', lookupName: 'aaa'}]" /> </td>
	    				
	    			</tr>
	    		</table>
	    	</form>
	    	<div id="searchUserBtns">
	    		<a class="easyui-linkbutton"  plain="false" onclick="searchUser();" href="javascript:void(0);">查询</a>
	    		<a class="easyui-linkbutton"  plain="false" onclick="clearUser();" href="javascript:void(0);">清空</a>
	    		<a class="easyui-linkbutton"  plain="false" onclick="hideSearchUser();" href="javascript:void(0);">返回</a>
	    	</div>
	    </div>
	    
	</div>
</body>
</html>