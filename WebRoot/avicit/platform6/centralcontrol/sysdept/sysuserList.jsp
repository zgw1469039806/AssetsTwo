<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script type="text/javascript">

var path="<%=ViewUtil.getRequestPath(request)%>";
var queryId="${param.id}";
var queryType="${param.type}";
var queryName="${param.name}";
/**
 * 供子页刷新用
 */
function flushData(){
	$("#dgUser").datagrid('reload');
	$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
}

/**
 * 加载用户数据
 */
function loadUserData(id,type,name){
	queryId=id;
	queryType=type;
	queryName=decodeURI(name);
	$("#selecDeptDialog").dialog('close');
	$("#queryUserDialog").dialog('close');
	
	$("#dgUser").datagrid("options").url ="platform/cc/sysdept/getUserDataByPage.json";
	$("#dgUser").datagrid('reload',{id:id,type:type});
	
	$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
}

/**
 * 重置密码
 */
function resetPassword(){
	var rows = $("#dgUser").datagrid('getChecked');
	var ids = [];
	if (rows.length > 0) {
		$.messager.confirm('请确认','您确定重置所选用户的密码？',function(b){
			if(b){
				for ( var i = 0, length = rows.length; i < length; i++) {
					ids.push(rows[i].ID);
				}
			   $.ajax({
				 url:'platform/cc/sysdept/resetPassword',
				 data : {ids : ids.join(',')},
				 type : 'post',
				 dataType : 'json',
				 success : function(data){
					 if(0==data.result){
						 $("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 $.messager.show({title : '提示',msg : '操作成功'});
					 }else{
						 $.messager.alert('提示',data.msg,'warning');
					 }
				 }
			 });
			}
		});
	}else{
		$.messager.alert('提示',"请选择用户！",'warning');
	}
}
var __uid;
function changePassword(){
	var rows = $("#dgUser").datagrid('getChecked');
	if(rows.length===0){
		$.messager.alert('提示',"请选择用户！",'warning');
	}else if (rows.length === 1) {
		var user =rows[0];
		if(user.STATUS !="1"||user.USER_LOCKED!="0"){
			$.messager.alert('提示',"请选择正常的用户！",'warning');
			return false;
		}
		__uid=user.ID;
		var path="platform/sysuser/modifypsw";
		var usd = new CommonDialog("modifypsw","700","500",path,"修改密码",false,true,false);
		usd.show();
		
	}else{
		$.messager.alert('提示',"请选择一个用户！",'warning');
	}
}
/**
 * 重置密码
 */
function resetAllPassword(){
		$.messager.confirm('请确认','您确定重置所有用户的密码？',function(b){
			if(b){
			   $.ajax({
				 url:'platform/sysdept/sysDeptController/resetAllPassword.json',
				 data : "",
				 type : 'post',
				 dataType : 'json',
				 success : function(data){
					 if(0==data.result){
						 $("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 $.messager.show({title : '提示',msg : '操作成功'});
					 }else{
						 $.messager.alert('提示',data.msg,'warning');
					 }
				 }
			 });
			}
		});
}
/**
 * 设置是否无效
 */
function setValidFlag(){
	var rows = $("#dgUser").datagrid('getChecked');
	var ids = [];
	if (rows.length > 0) {
		$.messager.confirm('请确认','您确定执行该操作？',function(b){
			if(b){
				for ( var i = 0, length = rows.length; i < length; i++) {
					ids.push(rows[i].ID);
				}
			   $.ajax({
				 url:'platform/cc/sysdept/setValidFlag',
				 data : {ids : ids.join(',')},
				 type : 'post',
				 dataType : 'json',
				 success : function(data){
					 if(0==data.result){
						 $("#dgUser").datagrid('reload');
						 $("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 $.messager.show({title : '提示',msg : '操作成功'});
					 }else{
						 $.messager.alert('提示',data.msg,'warning');
					 }
				 }
			 });
			}
		});
	}else{
		$.messager.alert('提示',"请选择用户！",'warning');
	}
}
/**
 * 查看某个人的权限
 */
function showPermisstionMenu(){
	var rows = $("#dgUser").datagrid('getChecked');
	if(rows.length===0){
		$.messager.alert('提示',"请选择用户！",'warning');
	}else if (rows.length === 1) {
		var user =rows[0];
		if(user.STATUS !="1"||user.USER_LOCKED!="0"){
			$.messager.alert('提示',"请选择正常的用户！",'warning');
			return false;
		}
		__uid=user.ID;
		var path="platform/ccShowPermissController/permissControllerInfo/"+__uid;
		var usd = new CommonDialog("showMenu","850","650",path,"查看权限",false,true,false);
		usd.show();
		
	}else{
		$.messager.alert('提示',"请选择一个用户！",'warning');
	}
}
/**
 * 用户解锁
 */
function doUnLockSysUser(){
	var rows = $("#dgUser").datagrid('getChecked');
	var ids = [];
	if (rows.length > 0) {
		$.messager.confirm('请确认','您确定执行该操作？',function(b){
			if(b){
				for ( var i = 0, length = rows.length; i < length; i++) {
					ids.push(rows[i].ID);
				}
			   $.ajax({
				 url:'platform/cc/sysdept/doUnLockSysUser',
				 data : {ids : ids.join(',')},
				 type : 'post',
				 dataType : 'json',
				 success : function(data){
					 if(0==data.result){
						 $("#dgUser").datagrid('reload');
						 $("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 $.messager.show({title : '提示',msg : '操作成功'});
					 }else{
						 $.messager.alert('提示',data.msg,'warning');
					 }
				 }
			 });
			}
		});
	}else{
		$.messager.alert('提示',"请选择用户！",'warning');
	}
}


/**
 * 移动用户部门
 */
function batchMoveDept(){
	var rows = $("#dgUser").datagrid('getChecked');
	if (rows.length > 0) {
		var usd = new CommonDialog("selecDeptDialog","350","400",path+"/avicit/platform6/centralcontrol/sysdept/selectDept.jsp","移动用户到部门",true,false,true,true,false,false);
		var buttons = [];
		buttons.push({
			text:'移动',
			id : 'saveButton',
			//iconCls : 'icon-add',
			handler:function(){
				var ifr = jQuery("#selecDeptDialog iframe")[0];
				var win = ifr.window || ifr.contentWindow;
				win.saveMoveDept(); // 调用iframe中的a函数
			}
		});
		usd.createButtonsInDialog(buttons);
		usd.show();
	}else{
		$.messager.alert('提示',"请选择用户！",'warning');
	}
}

/**
 * 保存批量移动部门
 */
function saveBatchMoveDept(deptId){
	if(""==deptId||null==deptId) $.messager.alert('提示',"获取部门为空！",'warning');
	var rows = $("#dgUser").datagrid('getChecked');
	var ids = [];
	var deptIds=[];
	if (rows.length > 0) {
		for ( var i = 0, length = rows.length; i < length; i++) {
			ids.push(rows[i].ID);
			deptIds.push(rows[i].DEPT_ID);
		}
		$.ajax({
	        cache: false,
	        type: "POST",
	        url:"platform/cc/sysdept/saveBatchMoveDept",
	        dataType:"json",
	        data:{userIds:ids.join(','),newDeptId:deptId,oldDeptIds:deptIds.join(',')},
	        error: function(request) {
	        	$.messager.alert('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
	        },
	        success: function(data) {
				if(data.result==0){
					$("#dgUser").datagrid('reload',{});
					$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
					$("#selecDeptDialog").dialog('close');
					$.messager.show({
						title : '提示',
						msg : '操作成功！',
						timeout:2000,  
				        showType:'slide'  
					});
				}else{
					$.messager.alert('提示',data.msg,'warning');
				}
	        }
	    });
	}else{
		$.messager.alert('提示',"请选择用户！",'warning');
	}
}

/**
 * 查询
 */
function searchOpen(){
	var usd = new CommonDialog("queryUserDialog","700","300","platform/cc/sysdept/toQueryUserView","查询",false,false,false);
	usd.show();
}

var expSearchParams;

//去后台查询
function searchData(searchData){
	$("#dgUser").datagrid("options").url="platform/cc/sysdept/getUserDataByPage.json";
	searchData.id=queryId;
	searchData.type=queryType;
	expSearchParams=searchData;
	$('#dgUser').datagrid('load',searchData);
	$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
}

/**
 * 添加用户
 */
function insertUser(){
	var path="platform/cc/sysuser/toAddJsp";
	/* if("dept"==queryType){
		path+="?deptId="+queryId+"&deptName="+decodeURI(queryName);
	} */
	var usd = new CommonDialog("insertUserDialog","700","500",path,"添加用户",false,true,false);
	usd.show();
}

/**
 * 编辑用户
 */
function editUser(){
	var rows = $("#dgUser").datagrid('getChecked');
	if(rows.length<=0){
		$.messager.alert('提示',"请先择用户！",'warning');
		return;
	}
	if(rows.length>1){
		$.messager.alert('提示',"一次只能编辑一条记录！",'warning');
		return;
	}
	if(rows[0].IS_CHIEF_DEPT=='0'){
		$.messager.alert('提示',"兼职部门不能编辑！",'warning');
		return;
	}
	var path="platform/cc/sysuser/toEditJsp?sysUserId="+rows[0].ID;
	var usd = new CommonDialog("editUserDialog","700","500",path,"编辑用户",false,true,false);
	usd.show();
}

/**
 * 查看锁定日志
 */
 function toLockLog(){
		var rows = $("#dgUser").datagrid('getChecked');
		if(rows.length<=0){
			$.messager.alert('提示',"请先择用户！",'warning');
			return;
		}
		if(rows.length>1){
			$.messager.alert('提示',"只能选择一条记录！",'warning');
			return;
		}
		var path="platform/cc/sysuser/toUserLockJsp?id="+rows[0].ID;
		var usd = new CommonDialog("userLockLogDialog","700","435",path,"锁定日志",false,true,false);
		usd.show();
	}

/**
 * 关闭添加页
 */
$closeAddIfram = function(){
	$("#insertUserDialog").dialog('close');
};

/**
 * 关闭编辑页
 */
$closeEditIfram = function(){
	$("#editUserDialog").dialog('close');
};

/**
 * 关闭锁定日志
 */
$closeUserLockLogDialog = function(){
	$("#userLockLogDialog").dialog('close');
};

/**
 * 导入数据从excel中
 */
function importUser(){
	var imp = new CommonDialog("importData","700","400",'platform/excelImportController/excelimport/importEmployeeInfo/xls',"Excel数据导入",false,true,false);
	imp.show();
}
function closeImportData(){
	$("#importData").dialog('close');
}

/**
 * 导出用户(客户端数据)
 */
function exportClientData(){
	$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
        if (r) {
            //封装参数
            var columnFieldsOptions = getGridColumnFieldsOptions('dgUser');
            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
            var rows = $('#dgUser').datagrid('getRows');
            var datas = JSON.stringify(rows);
            var myParams = {
                dataGridFields: dataGridFields,//表头信息集合
                datas: datas,//数据集
                hasRowNum : true,//默认为Y:代表第一列为序号
                sheetName: 'sheet1',//如果该参数为空，默认为导出的Excel文件名
                unContainFields : 'STATUS_LABEL,EMAIL',//不需要导出的列，使用','分隔即可
                fileName: '平台用户导出数据'//导出的Excel文件名
            };
            var url = "platform/cc/sysuser/exportClient";
            var ep = new exportData("xlsExport","xlsExport",myParams,url);
            ep.excuteExport();
        }
       });
}
/**
 * 导出用户(服务端数据)
 */
function exportServerData(){
	$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
        if (r) {
            //封装参数
            var columnFieldsOptions = getGridColumnFieldsOptions('dgUser');
            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
            
            expSearchParams = expSearchParams?expSearchParams:{};
            
            expSearchParams.dataGridFields=dataGridFields;
            expSearchParams.hasRowNum=true;
            expSearchParams.sheetName='sheet1';
            expSearchParams.unContainFields='STATUS_LABEL,EMAIL';
            expSearchParams.fileName='平台用户导出数据';
            
            expSearchParams.id =queryId;
            expSearchParams.type=queryType;
            
            var url = "platform/cc/sysuser/exportServer";
            var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
            ep.excuteExport();
        }
       });
}
/**
 * 删除用户
 */
function deleteUser(){
	var rows = $('#dgUser').datagrid('getChecked');
	var ids = [];
	var deptIds = [];
	var l=rows.length;
	if (rows.length > 0) {
		$.messager.confirm('请确认','您确定要删除当前所选的数据？',
			function(b){
				if(b){
					for (;l--;) {
						ids.push(rows[l].ID);
						deptIds.push(rows[l].DEPT_ID);
					}
					$.ajax({
						url : 'platform/cc/sysuser/deleteSysUser',
						data : {ids : ids.join(','), deptIds : deptIds.join(',')},
						type : 'post',
						dataType : 'json',
						success : function(result) {
							if (result.flag == "success") {
								if(result.toolTip){
									$.messager.alert('提示',result.toolTip+"已是系统资源，请先删除系统资源！",'warning');
								}else{
									$("#dgUser").datagrid('reload');
									$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
									$.messager.show({
										title : '提示',
										msg : '操作成功！',
										timeout:2000,  
								        showType:'slide'  
									});
								}
							}else{
								$.messager.alert('提示',result.msg,'warning');
							}
						}
					});
				}
			});
	} else {
		$.messager.alert('提示', '请选择要删除的记录！', 'warning');
	}
}
/**
 * 移交待办
 */
var fromUserId = null;
function transferToDo(){
	var rows = $('#dgUser').datagrid('getChecked');
	if(rows.length == 0){
		$.messager.alert("提示", "请选择用户数据！");
		return;
	}
	if(rows.length > 1){
		$.messager.alert("提示", "移交待办只能选择一条用户数据！");
		return;
	}
	$.ajax({
		url : 'platform/bpm/clientbpmdisplayaction/hasTask',
		data : {userId: rows[0].ID},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if(r.result == 0){
				$.messager.alert("提示", "该用户没有待办！");
			}else{
				fromUserId = rows[0].ID;
				var comSelector = new CommonSelector("user","userSelectCommonDialog",null,null,null,null,null,null,null,null,600,400);
				comSelector.init(false,'selectUserDialogCallBack',1); //选择人员  回填部门 */
			}
		}
	});
}
function selectUserDialogCallBack(data){
	if(data != null && data.length == 1){
		if(data[0].userId == fromUserId){
			$.messager.alert("提示", "移交人和接受人不能为同一人！");
			return;
		}
		$.ajax({
			url : 'platform/bpm/clientbpmWorkHandAction/transferAllTask',
			data : {fromUserId: fromUserId, toUserId: data[0].userId},
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if(r.result == true){
					$.messager.show({
						title : '提示',
						msg : '移交成功！'
					});
				}else{
					$.messager.alert("提示", "移交过程出错！");
				}
			}
		});
	}
}
function rowStyler(index,row){
	console.info(row.IS_CHIEF_DEPT);
		if (row.IS_CHIEF_DEPT=='0'){
			return 'color:#c0c0c0;';
		}
}
</script>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false" style="padding:0px;overflow:hidden;">
	<div id="toolbarUser" >
		<table >
			<tr>
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysuser_toolbar_insertUser" permissionDes="添加">
				<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="insertUser();" href="javascript:void(0);">添加</a></td>
				</sec:accesscontrollist>
				
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysuser_toolbar_editUser" permissionDes="编辑">
				<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser();" href="javascript:void(0);">编辑</a></td>
				</sec:accesscontrollist>
				
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysuser_toolbar_resetPassword" permissionDes="密码管理">
				<td><a id="btn-pwdMgr" href="#" class="easyui-menubutton" data-options="menu:'#psdMgr',iconCls:'icon-tools'">密码管理</a></td>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysuser_toolbar_setValidFlag" permissionDes="有(无)效设置">
				<td><a class="easyui-linkbutton" iconCls="icon-setting" plain="true" onclick="setValidFlag();" href="javascript:void(0);">有(无)效设置</a></td>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysuser_toolbar_doUnLockSysUser" permissionDes="解锁">
				<td><a class="easyui-menubutton"  data-options="menu:'#lock',iconCls:'icon-setting'" href="javascript:void(0);">解锁</a></td>
				</sec:accesscontrollist>
				
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysuser_toolbar_importUser" permissionDes="导入用户">
				<td><a class="easyui-linkbutton" iconCls="icon-import" plain="true" onclick="importUser();" href="javascript:void(0);">导入用户</a></td>
				</sec:accesscontrollist>
				
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysuser_toolbar_exportUser" permissionDes="导出用户">
				<td><a class="easyui-menubutton"  data-options="menu:'#export',iconCls:'icon-export'" href="javascript:void(0);">导出用户</a></td>
				</sec:accesscontrollist>
				
				<td><a id="btn-tools" href="#" class="easyui-menubutton" data-options="menu:'#tools',iconCls:'icon-tools'">工具</a></td>
				
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysuser_toolbar_deleteUser" permissionDes="删除">
				<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser();" href="javascript:void(0);">删除</a></td>
				</sec:accesscontrollist>
				
				<sec:accesscontrollist hasPermission="3" domainObject="ccsysuser_toolbar_searchOpen" permissionDes="查询">
				<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchOpen();" href="javascript:void(0);">查询</a></td>
				</sec:accesscontrollist>
			</tr>
		</table>
	</div>
	<div id="lock" style="width:150px;display:none;">
		<div onclick="doUnLockSysUser();">解锁</div>
		<div onclick="toLockLog();">用户锁定日志</div>
	</div>
	<div id="psdMgr" style="width:150px;display:none;">
		<div onclick="resetPassword();">重置密码</div>
		<div onclick="changePassword();">修改密码</div>
		<div onclick="resetAllPassword();">密码全部重置</div>
	</div>
	<div id="tools" style="width:150px;display:none;">
		<div onclick="batchMoveDept();">移动部门</div>
		<div onclick="transferToDo();">移交待办</div>
		<div onclick="showPermisstionMenu();">查看权限</div>
	</div>
	<div id="export" style="width:150px;display:none;">
		<div data-options="iconCls:'icon-excel'" onclick="exportClientData();">Excel导出(客户端)</div>
		<div data-options="iconCls:'icon-excel'" onclick="exportServerData();">Excel导出(服务器端)</div>
	</div>
	<table id="dgUser" class="easyui-datagrid" datapermission='ccSysUser'
			data-options=" 
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarUser',
				idField :'ID',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true,
				rowStyler: rowStyler,
				url:'platform/cc/sysdept/getUserDataByPage.json?id=${param.id}&type=${param.type}'
				">
			<thead>
				<tr>
					<th data-options="field:'ID', halign:'center',checkbox:true" width="220">id</th>
					<th data-options="field:'STATUS_LABEL',required:true,align:'center'" editor="{type:'text'}">状态</th>
					
					<th data-options="field:'NO',required:true,align:'center'" editor="{type:'text'}" width="220">用户编号</th>
					
					<th data-options="field:'NAME',required:true,align:'center'" editor="{type:'text'}" width="300">用户姓名</th>
					
					<th data-options="field:'LOGIN_NAME',align:'center',align:'center'" editor="{type:'text'}"  width="300">登录名</th>
					
					<th data-options="field:'SECRET_LEVEL_NAME',align:'center',align:'center'" editor="{type:'text'}"  width="220">密级</th>
					
					<th data-options="field:'SEX_NAME',align:'center',align:'center'" editor="{type:'text'}"  width="80">性别</th>
					<th data-options="field:'MOBILE',align:'center',align:'center'" editor="{type:'text'}"  width="220">手机</th>
					<th data-options="field:'OFFICE_TEL',align:'center',align:'center'" editor="{type:'text'}"  width="220">办公电话</th>
					<th data-options="field:'EMAIL',align:'center',align:'center'" editor="{type:'text'}"  width="220">邮件</th>
					<th data-options="field:'IS_MANAGER_NAME',align:'center',align:'center'" editor="{type:'text'}"  width="140">是否主管</th>
					<th data-options="field:'ORDER_BY',align:'center',align:'center'" editor="{type:'text'}"  width="80">排序</th>
					<th data-options="field:'DEPT_NAME',align:'center',align:'center'" editor="{type:'text'}"  width="220">主部门</th>
					<th data-options="field:'POSITION_NAME',align:'center',align:'center'" editor="{type:'text'}"  width="220">岗位</th>
				</tr>
			</thead>
	</table>
</div>
</body>
</html>