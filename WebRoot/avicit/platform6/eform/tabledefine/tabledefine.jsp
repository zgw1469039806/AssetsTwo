<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>菜单管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>

<%
	long timestamp = System.currentTimeMillis();
	String appId = SessionHelper.getApplicationId();
%>
<script>

var Common = {
	    TxtFormatter: function (value, rec, index) {
	        if (value == 'Y') {
	            return "是";
	        }
	        return "否";
	    },
	    
	    ColTypeFormatter: function (value, rec, index) {
	        if (value == 'VARCHAR2') {
	            return "字符串";
	        }
	        if (value == 'DATE') {
	            return "日期时间";
	        }
	        if (value == 'NUMBER') {
	            return "数字型";
	        }
	        if (value == 'BLOB') {
	            return "二进制大对象";
	        }
	        if (value == 'CLOB') {
	            return "字符大对象";
	        }
	    },

		LookUpFormatter: function (value, rec, index){
			//return Platform6.fn.lookup.formatLookupType(value, demoBusinessTrip.traffic);
		},
	    
	    BpmFormatter: function(value,rowData,rowIndex){
			return "<span class='icon-edit' onclick='javascript: bpmObj(\""+ rowData.ID +"\");'></span>";
		},
		
		LookupFormatter: function(value,rowData,rowIndex){
			if (typeof(value)=="string")
				return "<a onclick='javascript:openLookupDetail(\""+value+"\");'>"+value+"</a>";
			else
				return "";
		}
	    
	    
	};

$(document).ready(function(){ 

	$.extend($.fn.validatebox.defaults.rules, {
            isBlank: {
                validator: function (value, param) { return $.trim(value) != '' },
                message: '不能为空，全空格也不行'
            }
     });

	
	$('#searchdlg').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchUser();
		}
	});
	
	$('#dlg').css('display','block').dialog({
		title:'添加表'
	});
	
	$('#searchdlg').css('display','block').dialog({
		title:'查询表'
	});
	
	$('#dg1').datagrid({  
	    rowStyler:function(index,row){  
	        if (row.colName=='ID'||row.colName=='VERSION'||row.colName=='CREATION_DATE'||row.colName=='CREATED_BY'||row.colName=='LAST_UPDATED_BY'||row.colName=='LAST_UPDATE_DATE'||row.colName=='LAST_UPDATE_IP'||row.colName=='ORG_IDENTITY'){  
	            return 'color:blue';  
	        }  
	    }  
	});  
	
})

</script>

</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'west',split:true,title:'表信息维护'" style="width:680px;padding:0px;height:0; overflow:hidden; font-size:0;"  >

	 <table id="dg"  class="easyui-datagrid"  url="platform/eform/tabledefine/list.json" fit="true" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" autoRowHeight="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true" width="50">id</th>
				<th data-options="field:'tableName',required:true,align:'center'"  width="80">表英文名</th>
				<th data-options="field:'tableTitle',required:true,align:'center'"  width="80">模块名称</th>
				<th data-options="field:'tableIsCreated',required:true,align:'center'"  width="35"  formatter="Common.TxtFormatter">是否创建</th>
				<th data-options="field:'tableIsUpload',required:true,align:'center'"  width="35"  formatter="Common.TxtFormatter">是否附件</th>
				<th data-options="field:'tableIsBpm',required:true,align:'center'"  width="35"  formatter="Common.TxtFormatter">是否流程</th>
				<th data-options="field:'subTableName',required:true,align:'center'"  width="35">子表名</th>
				<th data-options="field:'subColumnName',required:true,align:'center'"  width="40">子表外键</th>
				<th data-options="field:'attribute08',required:true,align:'center'"  width="20"  >版本</th>
			</tr>
		</thead>
	</table>
	<!-- CRUD工具栏 -->
	<div id="toolbar">
		<table>
		<tr>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添加表</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑表</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser()">删除表</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="createUser()">创建表</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-trash" plain="true" onclick="dropUser()">废弃表</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="customUser()">自定按钮</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryUser()">查询</a></td>
		</tr>
		<tr>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newVersion()">添加版本</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteVersion()">查看/删除版本</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-run" plain="true" onclick="useVersion()">启用版本</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-design" plain="true" onclick="initdesignUser()">表单设计</a></td>
		<!-- <td><a id="moduleButton" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-template" plain="true" onclick="chooseUser()">模板</a></td> -->
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-design" plain="true" onclick="updatept()">632升级633</a></td>
		</tr>
		</table>
	</div>
	</div>
	
	
	<!-- SEARCH表单 start-->
	 <div id="searchdlg"  data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"  style="width: 350px;height:150px; visible: hidden;display: none;" title="查询表信息" closed="true" >  	
	    	
	    		<table  class="form_commonTable">
	    			<tr>
	    				<td width="12%">表英文名:</td> 
	    				<td width="38%"><input id="q_tableName" name="tableName" class="easyui-validatebox"  ></td>
	    			</tr>	
	    		</table>
	    	
	    	
	    <div id="searchBtns" class="datagrid-toolbar foot-formopera">
        	<table class="tableForm" border="0" cellspacing="1" width='100%'>
                <tr>
                    <td align="right">
                       <a class="easyui-linkbutton primary-btn" iconCls="" plain="false"  onclick="searchUser();" href="javascript:void(0);" >查询</a>
	    			   <a class="easyui-linkbutton" iconCls="" plain="false" onclick="clearUser();" href="javascript:void(0);" >清空</a>
	    			   <a class="easyui-linkbutton" iconCls="" plain="false" onclick="javascript:$('#searchdlg').dialog('close')"  href="javascript:void(0);" >返回</a>
	    			</td>
                </tr>
            </table>
        </div>
	    </div>
	 <!-- SEARCH表单 end-->
	
	
	

<!-- 字段详细信息 -->
<div data-options="region:'center',split:true,title:'字段详细信息(蓝色字体字段代表系统默认字段)'" style="padding:0px;height:0; overflow:hidden; font-size:0;">
	
	 <table id="dg1"  class="easyui-datagrid"  url="platform/eform/tabledefine/listcolumn.json" data-options=" 
	 fit:true, 
	 toolbar:'#toolbar1' ,
	 pagination:false,
	 rownumbers:true, 
	 fitColumns:true,
	 singleSelect: true,
	 checkOnSelect: true,
	 selectOnCheck: false,
	 autoRowHeight:false,
	 striped:true,
	 onLoadSuccess:cellTip">
		<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true" width="50">id</th>
				<th data-options="field:'colName',required:true,align:'center'"  width="100"  >字段英文名</th>
				<th data-options="field:'colLabel',required:true,align:'center'"  width="100">字段中文名</th>
				<th data-options="field:'colType',required:true,align:'center'"  width="100"  formatter="Common.ColTypeFormatter">字段类型</th>
				<th data-options="field:'colLength',required:true,align:'center'"  width="80">字段长度</th>
				<th data-options="field:'colIsSearch',required:true,align:'center'"  width="120" formatter="Common.TxtFormatter">是否查询字段</th>
				<th data-options="field:'colIsMust',required:true,align:'center'"  width="80" formatter="Common.TxtFormatter">是否必填</th>
				<th data-options="field:'colIsTabVisible',required:true,align:'center'"  width="120" formatter="Common.TxtFormatter">是否列表显示</th>
				<th data-options="field:'attribute01',required:true,align:'center'" width="100"  formatter="Common.LookupFormatter">通用代码</th>
			</tr>
		</thead>
	</table>
	<!-- CRUD工具栏 -->
	<div id="toolbar1">
		<table>
		<tr>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newCol()">添加字段</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editCol()">编辑字段</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteCol()">删除字段</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-lookup" plain="true" onclick="newlookup()">关联通用代码</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="delLookup()">取消关联通用代码</a></td>
		<!--  
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newIndex()">创建索引</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="dropIndex()">废弃索引</a></td>
		-->
		</tr>
		</table>
	</div>
	<!-- 通用代码详细页 -->
	<div id="dglookupdetail" class="easyui-dialog" style="width: 600px; height: 500px;" closed="true" buttons="#dlg-buttons2">
		<div class="easyui-layout" data-options="fit:true"> 
		
		<div data-options="region:'center',split:true,title:''" style="padding:0px;height:0; overflow:hidden; font-size:0;">
			<table id="codeList" class="easyui-datagrid"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: false,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					idField :'id',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					striped:true
					" width="100%">
				<thead>
					<tr>
						<th data-options="field:'lookupName',align:'center'" width="320">系统代码名称</th>
		        		<th data-options="field:'lookupCode',align:'center'" width="220">系统代码值</th>
						<th data-options="field:'displayOrder',align:'center'" width="120">排序</th>
						<th data-options="field:'lookupDes',align:'center'" width="220">描述</th>
					</tr>
				</thead>
			</table>
		</div>
		</div>
	</div>
	<!-- 通用代码详细页返回按钮 -->
	<div id="dlg-buttons2">
		<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:$('#dglookupdetail').dialog('close')" >返回</a>
	</div>
	
</div>
	
<script type="text/javascript">

var baseurl = '<%=request.getContextPath()%>';
var url;
var appId = "<%=appId%>";

function cellTip(data){
	
	$('#dg').datagrid('doCellTip',   
	{   
		onlyShowInterrupt:true,   
		position:'bottom',
		tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
	}); 
	
	$('#dg1').datagrid('doCellTip',   
	{   
		onlyShowInterrupt:true,   
		position:'bottom',
		tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
	}); 
};


$('#dg').datagrid({
	onClickRow:function(index,data)
	{
		var row=$('#dg').datagrid('getSelected');
		var value=$('#q_userName').val();
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
})

function clearUser(){
	$('#q_tableName').attr("value","");
}


function queryUser() {
			var tableId=$('#tableId').val();
			$('#searchdlg').dialog('open');
			//$('#searchfm').form('clear');
}



function searchUser() {
	var value=$('#q_tableName').val();
	url = 'platform/eform/tabledefine/list.json';
	$.post(url, {
		tableName : value
	}, function(result) {
		$('#dg').datagrid('loadData',result);
		//$('#searchdlg').dialog('close'); 
	}, 'json');
}

function newUser() {
	url = 'avicit/platform6/eform/tabledefine/tableAdd.jsp';
	var  dlg = new CommonDialog("insert","700","480",url,"添加表",false,true,false);
	dlg.show();
}

function editUser() {
	var row = $('#dg').datagrid('getSelected');
	if (row) {
			if(row.tableIsCreated=='Y'){
				$.messager.show({
					title : '错误',
					msg : '该表已经创建，不能编辑!'
				});
	    	}else{
				url = 'platform/eform/tabledefine/initedit?id='+row.id;
				var  dlg = new CommonDialog("update","700","480",url,"编辑表",false,true,false);
				dlg.show();
	    	}
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
		});
	}
}
	

function deleteUser() {
	url='platform/eform/tabledefine/delete.json';
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		if(row.tableIsCreated=='Y'){
				$.messager.show({
					title : '错误',
					msg : '该表已经创建，不能删除!'
				});
		}else{
			$.messager.confirm('',
					'确认删除吗?',
					function(r) {
						if (r) {
							$.post(url, {
								id : row.id
							}, function(result) {
								if (result.success) {
									$.messager.show({
										title : '提示',
										msg : '删除成功！'
									});
									$('#dg').datagrid('reload');
									$('#dg1').datagrid('reload');
								} else {
									$.messager.show({
										title : 'Error',
										msg : result.errorMsg
									});
								}
							}, 'json');
						}
			});
		}
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
		});
	}
}


function customUser(){
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		url = 'avicit/platform6/eform/tabledefine/buttonList.jsp?tableId='+row.id;
		var  dlg = new CommonDialog("update","800","480",url,"自定义按钮",false,true,false);
		dlg.show();
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
		});
	}	
}



function createUser() {
	url='platform/eform/cbbClient/createtable.json';
	var row = $('#dg').datagrid('getSelected');
	
	if (row) {
		if(row.tableIsCreated=='Y'){
			$.messager.show({
				title : '错误',
				msg : '已经创建的表不能再次被创建!'
			});
		}else{
			$.messager.confirm('',
					'确认创建表吗?',
					function(r) {
						if (r) {
							$.post(url, {
								id : row.id
							}, function(result) {
								if (result.success) {
									$.messager.show({
										title : '提示',
										msg : '创建成功！'
									});
									$('#dg').datagrid('reload');
								} else {
									$.messager.show({
										title : '错误',
										msg : result.msg
									});
								}
							}, 'json');
						}
			});
		}
		
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
		});
	}
}


function dropUser() {
	url='platform/eform/cbbClient/droptable.json';
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		
		if(row.tableIsCreated=='Y'){
			
			$.messager.confirm('',
					'确认废弃表吗?',
					function(r) {
						if (r) {
							$.post(url, {
								id : row.id
							}, function(result) {
								if (result.success) {
									$.messager.show({
										title : '提示',
										msg : '废弃成功！'
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
				title : '错误',
				msg : '该表还没有创建，不能废弃!'
			});
		}
		
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
		});
	}
}


function newCol() {
	
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		url = 'avicit/platform6/eform/tabledefine/colAdd.jsp?tableId='+row.id;
		var  dlg = new CommonDialog("insert","1300","600",url,"添加字段",false,true,false);
		dlg.show();
	}else{
		$.messager.show({
			title : '提示',
			msg : '请选择表信息!'
		});
	}
}

function editCol() {
	
	var myDatagrid=$('#dg1');
	var rows = myDatagrid.datagrid('getChecked');
	var ids = [];
	var l =rows.length;
	if(l>1){
		$.messager.show({
			title : '错误',
			msg : '请选择一条字段信息!'
		});
	}else if(l==1){

		url = 'platform/eform/tabledefine/initeditcol?id='+rows[0].id;
		var  dlg = new CommonDialog("update","1300","600",url,"编辑字段",false,true,false);
		dlg.show();
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择字段信息!'
		});
	}
	
}


function deleteCol() {
	
	url='platform/eform/cbbClient/deletecolumn.json';
	
	var myDatagrid=$('#dg1');
	var rows = myDatagrid.datagrid('getChecked');
	var ids = [];
	var l =rows.length;
	if(l>0){
		for(;l--;){
			ids.push(rows[l].id);
	 	}
		$.messager.confirm('',
				'确认删除吗?',
				function(r) {
					if (r) {
						$.post(url, {
							id : JSON.stringify(ids)
						}, function(result) {
							if (result.success) {
								$.messager.show({
									title : '提示',
									msg : '删除成功！'
								});
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
								
							} else {
								$.messager.show({
									title : '错误',
									msg : result.msg
								});
							}
						}, 'json');
					}
		});
		
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择字段信息!'
		});
	}
	
}

function openLookupDetail(lookuptype){
	$('#dglookupdetail').dialog('open').dialog('setTitle', '通用代码类型：'+lookuptype);
	var url = "platform/eform/tabledefine/"+lookuptype+"/"+appId+"/getSyslookup.json";
	$("#codeList").datagrid({url:url});
}



function  newlookup(){
	var rowTable = $('#dg').datagrid('getSelected');
	var myDatagrid=$('#dg1');
	var rows = myDatagrid.datagrid('getChecked');
	var ids = [];
	var l =rows.length;
	if(l>1){
		$.messager.show({
			title : '错误',
			msg : '请选择一条字段信息!'
		});
	}else{
		var row = $('#dg1').datagrid('getSelected');
		if (row) {
			var columnId=row.id;
			var tableId = rowTable.id;
			url = 'platform/eform/tabledefine/newlookup?columnId='+columnId+'&tableId='+tableId;
			var  dlg = new CommonDialog("newlookup","800","600",url,"关联通用代码",false,true,false);
			dlg.show();
		}else{
			$.messager.show({
				title : '错误',
				msg : '请选择字段信息!'
			});
		}
	}
}

function delLookup(){
	//var rows = $('#dg1').datagrid('getSelected');

	var myDatagrid=$('#dg1');
	var rows = myDatagrid.datagrid('getChecked');
	var ids = [];
	var l =rows.length;
	if(l>0){
		for(;l--;){
			ids.push(rows[l].id);
	 	}
	//if(rows){
	  $.messager.confirm('请确认','您确定要取消当前所选字段与通用代码的关联？',function(b){
		 if(b){
			var row=$('#dg').datagrid('getSelected');
			var tableId = row.id;
				 $.ajax({
					 url:"platform/eform/tabledefine/deleteSysCode",
					 data:	{tableId:tableId,colId:JSON.stringify(ids)},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.flag == "success") {
							 reloadByRowId();
							 $.messager.show({
								 title : '提示',
								 msg : '取消成功！'
							});
						}else{
							$.messager.show({
								 title : '提示',
								 msg : r.error
							});
						}
					 }
				 });
		 } 
	  });
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择字段信息!'
		});
	}
}


//模板
function chooseUser(){
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		var tableId=row.id;
		var isCreated = row.tableIsCreated;
		url = 'platform/eform/tabledefine/newtemplet?tableId='+tableId+'&isCreated='+isCreated;
		var  dlg = new CommonDialog("newtemplet","800","500",url,"模板选择",false,true,false);
		dlg.show();
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
		});
	}
}



function initdesignUser(){
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		if(row.tableIsCreated=='Y'){
			var tableId=row.id;
			url = 'platform/eform/tabledefine/initdesignversion?tableId='+tableId;
			var  dlg = new CommonDialog("initdesign","600","200",url,"选择版本",false,true,false);
			dlg.show();
		}else{
			$.messager.show({
				title : '提示',
				msg : '请先创建表!'
			});
		}
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
		});
	}
}



function designUser(tableversion,formversion){
	$('#initdesign').dialog('close');
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		if(row.tableIsCreated=='Y'){
			var tableId=row.id;
			url = 'platform/eform/formdefine/index?tableId='+tableId+'&formversion='+encodeURI(formversion)+'&tableversion='+encodeURI(tableversion);
			var  dlg = new CommonDialog("newform","800","500",url,"表单设计:"+row.tableName+"("+tableversion+"版本)",false,true,false,null,true,true);
			dlg.show();
		}else{
			$.messager.show({
				title : '提示',
				msg : '请先创建表!'
			});
		}
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
		});
	}
}



function newVersion(){
	var row = $('#dg').datagrid('getSelected');
	if (row){
	if(row.tableIsCreated=='Y'){
		
		if (row) {
			var colrow = $('#dg1').datagrid('getChecked');
			if(colrow){
				var myDatagrid=$('#dg1');
				var rows = myDatagrid.datagrid('getChecked');
				var ids = [];
				var l =rows.length;
				for(;l--;){
					ids.unshift(rows[l].id);
				}
				var tableId=row.id;
				url = 'platform/eform/tabledefine/initversion?tableId='+tableId+"&ids="+escape(JSON.stringify(ids));
				var  dlg = new CommonDialog("addversion","800","600",url,"添加版本",false,true,false);
				dlg.show();
			}else{
				$.messager.show({
					title : '提示',
					msg : '请选择字段信息!'
				});
			}
		}else{
			$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
			});
		}
	}else{
		$.messager.show({
			title : '错误',
			msg : '请先创建表!'
		});
	}
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
		});
	}
		
	
}


function useVersion(){
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		
		if(row.tableIsCreated=='Y'){
			var tableId=row.id;
			$.post('platform/eform/tabledefine/versionListSize.json', {tableId : tableId}, function(result) {
				if (result.flag) {
					url = 'platform/eform/tabledefine/inituseversion?tableId='+tableId;
					var  dlg = new CommonDialog("useversion","400","150",url,"启用版本",false,true,false);
					dlg.show();
				} else {
					$.messager.show({
						title : '错误',
						msg : '请先进行表单设计！'
					});
				}
			}, 'json');
		}else{
			$.messager.show({
				title : '提示',
				msg : '请先创建表!'
			});
		}
	}else{
		$.messager.show({
			title : '提示',
			msg : '请选择表信息!'
		});
	}
}


function deleteVersion(){
	var row = $('#dg').datagrid('getSelected');
	if (row) {
			var tableId=row.id;
			url = 'platform/eform/tabledefine/initlistversion?tableId='+tableId;
			var  dlg = new CommonDialog("deleteversion","700","500",url,"删除版本",false,true,false);
			dlg.show();
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
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

function dlg_close_new(id){
	$('#'+id).dialog('close');
	newCol();
}

function updatept(){
	
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		url = 'platform/eform/cbbClient/updatept.json';
		$.post(url, {id : row.id}, function(result) {
			if (result.success) {
				
				$.messager.show({
					title : '提示',
					msg : '操作成功！'
				});
				
			} else {
				$.messager.show({
					title : '错误',
					msg : '操作失败！'
				});
			}
		}, 'json');
		
		
		
	}else{
		$.messager.show({
			title : '错误',
			msg : '请选择表信息!'
		});
	}
	
	
}



</script>



</body>
</html>