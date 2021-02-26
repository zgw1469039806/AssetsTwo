<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</head>

<body class="easyui-layout" fit="true" style="visibility:hidden;">
<div data-options="region:'north',split:true,title:''" style="height: 300px; padding:0px;">
	<table id="dg"  class="easyui-datagrid"  url="platform/restmanage/system/list.json"  fit="true" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" selectOnCheck="false" checkOnSelect="true" striped="true">
		<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true" width="50">id</th>
				<th data-options="field:'systemName',required:true,align:'center'"  width="100">系统名称</th>
				<th data-options="field:'orgName',required:true,align:'center'"  width="100">所属单位</th>
				<th data-options="field:'systemDesc',required:true,align:'center'"  width="100">系统描述</th>
				<th data-options="field:'status',required:true,align:'center'"  width="100"  formatter="formatStatus">系统状态</th>
			</tr>
		</thead>
	</table>
	</div>
	<!-- CRUD工具栏 -->
	<div id="toolbar">
		<table>
		<tr>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newSys()">添加</a></td> 
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editSys()">编辑</a></td>  
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteSys()">删除</a></td> 
		<td><input id="q_systemName" name="systemName" class="easyui-validatebox"    onfocus="{this.value='';this.style.color='#000'}"   style="color:#808080"></td> 
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="querySys()">查询</a></td> 
		</tr>
		</table>
	</div>
	
	<!-- CU表单 -->
	<div id="dlg" class="easyui-dialog" style="width: 400px; height: 280px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post" novalidate>
			<div class="fitem">
				<span class="remind">*</span>
				<label>系统名称:</label> <input name="systemName" class="easyui-validatebox"  style="width:166px" required="true">
			</div>
			<div class="fitem">
				<span class="remind">*</span>
				<label>所属单位:</label> 
				<select id="orgId" name="orgId" class="easyui-combobox"   data-options="valueField:'id', textField:'orgName', width:166,editable:false,panelHeight:'auto'"></select>
			</div>
			<div class="fitem">
				<span class="remind">*</span>
				<label>系统描述:</label> <input name="systemDesc" class="easyui-validatebox" required="true" style="width:166px">
			</div>
			<div class="fitem">
				<span class="remind">*</span>
				<label>有效标识:</label> 
				<select  id="system_status"   name="status" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="1" selected>有效</option>
								<option value="0">无效</option>
				</select>
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveSys()" >保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')" >返回</a>
	</div>
	
	
	<div data-options="region:'center',split:true,title:''" style="padding:0px;">
	<table id="dguser"  class="easyui-datagrid"  url="platform/restmanage/user/list.json?systemId=-1"  fit="true" toolbar="#toolbaruser" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" selectOnCheck="false" checkOnSelect="true" striped="true" >
		<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true" width="50">id</th>
				<th data-options="field:'userName',required:true,align:'center'"  width="100">用户名</th>
				<th data-options="field:'baseKey',required:true,align:'center'"  width="100">BASHKEY</th>
				<th data-options="field:'status',required:true,align:'center'"  width="50"  formatter="formatStatus">状态</th>
			</tr>
		</thead>
	</table>
	</div>
	
	<!-- CRUD工具栏 -->
	<div id="toolbaruser">
		<table>
		<tr>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添加</a></td> 
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser()">删除</a></td>
		<td><input id="q_userName" name="userName" class="easyui-validatebox"   onfocus="{this.value='';this.style.color='#000'}"  style="color:#808080"></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryUser()">查询</a></td>
		</tr>
		</table>
	</div>
	
	<!-- CU表单 -->
	<div id="dlguser" class="easyui-dialog" style="width: 400px; height: 400px; padding: 10px 20px" closed="true" buttons="#dlguser-buttons">
		<form id="fmuser" method="post" novalidate>
			<div class="fitem">
				<span class="remind">*</span>
				<label>用户名称:</label> <input name="userName" class="easyui-validatebox" required="true"  style="width:166px">
			</div>
			<div class="fitem">
			    <span class="remind">*</span>
				<label>用户密码:</label> <input name="userPassword"  type="password" class="easyui-validatebox" required="true"  style="width:166px">
			</div>
			<div class="fitem">
				<span class="remind">*</span>
				<label>所属单位:</label> 
				<select id="orgIduser" name="orgId" class="easyui-combobox"   data-options="valueField:'id', textField:'orgName', width:166,editable:false,panelHeight:'auto'"></select>
			</div>
			<div class="fitem">
			    <span class="remind">*</span>
				<label>所属系统:</label> 
				<select id="systemIduser" name="systemId" class="easyui-combobox" data-options="valueField:'id', textField:'systemName', width:166,editable:false,panelHeight:'auto'">
				</select>
			</div>
			<div class="fitem">
			    <span class="remind">*</span>
				<label>是否授权:</label> 
				<select name="type" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="1" selected>是</option>
								<option value="0">否</option>
				</select>
			</div>
			<div class="fitem">
			    <span class="remind">*</span>
				<label>有效标识:</label> 
				<select name="status" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="1" selected>有效</option>
								<option value="0">无效</option>
				</select>
			</div>
		</form>
	</div>
	<div id="dlguser-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveUser()" >保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlguser').dialog('close')" >返回</a>
	</div>
	
	
	<!-- button js event -->
	<script type="text/javascript">
	var curSysId = "-1";
		function formatStatus(val,row){    
		    if (val ==1){    
		        return '有效';    
		    } else {    
		        return '无效';    
		    }    
		} 
		
		document.ready = function () {
			document.body.style.visibility = 'visible';
		}
		
		
		$('#dg').datagrid({
        	onClickRow:function(index,data)
        	{
        		var row=$('#dg').datagrid('getSelected');
        		var value=$('#q_userName').val();
        		if(value=='请输入用户名称...'){
        			value='';
        		}
        		if(row){
        			var systemId=row.id;
        			curSysId = row.id;
        			url = 'platform/restmanage/user/list.html';
    				$.post(url, {
    					systemId:systemId,
    					userName : value
    				}, function(result) {
    					$('#dguser').datagrid('loadData',result);
    				}, 'json');
        		}
        	}
        })
		var url;
		
		//System  js begin
		
		function querySys() {
			var value=$('#q_systemName').val();
			url = 'platform/restmanage/system/list.html';
			$.post(url, {
				systemName : value
			}, function(result) {
				$('#dg').datagrid('loadData',result);
			}, 'json');
		}
		
		function newSys() {
			$('#dlg').dialog('open').dialog('setTitle', '添加系统');
			$('#fm').form('clear');
			$('#fm').form('load',{
				status:'1'
			});
			$.post('platform/restmanage/org/listAll.html', {
			}, function(result) {
				//$("#orgId").combobox("loadData", result);
				 $('#orgId').combobox({  
					 data: result,  
                     onLoadSuccess: function () { //加载完成后,设置选中第一项  
                         var val = $(this).combobox('getData');  
                         for (var item in val[0]) {  
                             if (item == 'id') {  
                                 $(this).combobox('select', val[0][item]);  
                             }  
                         }  
                     }  
                 });  
				
				
			}, 'json');
			url = 'platform/restmanage/system/add.html';
		}
		
		function editSys() {
			var row = $('#dg').datagrid('getChecked');
			if (row.length==1) {
				$('#dlg').dialog('open').dialog('setTitle', '编辑系统');
				$.post('platform/restmanage/org/listAll.html', {
				}, function(result) {
					//$("#orgId").combobox("loadData", result);
					$('#orgId').combobox({  
						 data: result,  
	                     onLoadSuccess: function () { //加载完成后,设置选中第一项  
	                    	 $('#fm').form('load', row[0]);
	                     }  
	                 });  
					
				}, 'json');
				
				url = 'platform/restmanage/system/edit.html?id=' + row[0].id;
			}else{
				$.messager.show({
					title : '错误',
					msg : '请选择一条记录!'
				});
			}
		}
		
		function saveSys() {
			$('#fm').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.success) {
						$.messager.show({
							 title : '提示',
							 msg : '操作成功！'
						});
						$('#dlg').dialog('close'); 
						$('#dg').datagrid('reload'); 
					} else {
						$.messager.show({
							title : '错误',
							msg : result.msg
						});
					}
				}
			});
		}
		
		function deleteSys() {
			url='platform/restmanage/system/delete.html';
			var row = $('#dg').datagrid('getChecked');
			if (row.length==1) {
				$.messager.confirm('',
						'确认删除吗?',
						function(r) {
							if (r) {
								$.post(url, {
									id : row[0].id
								}, function(result) {
									if (result.success) {
										$.messager.show({
											 title : '提示',
											 msg : '操作成功！'
										});
										$('#dg').datagrid('reload');
										
										url = 'platform/restmanage/user/list.html';
					    				$.post(url, {
					    					systemId:'-1',
					    					userName : ''
					    				}, function(result) {
					    					$('#dguser').datagrid('loadData',result);
					    				}, 'json');
										
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
					msg : '请选择一条记录!'
				});
			}
		}
		
		//User js begin
		
		$(function(){  
	        $('#orgIduser').combobox({  
	            onSelect:function(record){  
	                $.post('platform/restmanage/system/listByorg.json?orgId='+record.id+'&random='+Math.random(), {
	    			}, function(result) {
	    				$("#systemIduser").combobox("loadData", result);
	    			}, 'json');
	            }  
	        });  
		});  
	
		function queryUser() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				url = 'platform/restmanage/user/list.html?systemId='+row.id;
			}else{
				url = 'platform/restmanage/user/list.html';
			}
			
			var value=$('#q_userName').val();
			
			$.post(url, {
				userName : value
			}, function(result) {
				$('#dguser').datagrid('loadData',result);
			}, 'json');
		}
		
		function newUser() {
			var orgId='';
			$('#dlguser').dialog('open').dialog('setTitle', '添加用户');
			$('#fmuser').form('clear');
			$('#fmuser').form('load',{
				type:'1',
				status:'1'
			});


			$.post('platform/restmanage/org/listAll.html?&random='+Math.random(), {
			}, function(result) {
				//$("#orgIduser").combobox("loadData", result).combobox('clear');
				
				$('#orgIduser').combobox({  
					data: result,  
                    onLoadSuccess: function () { //加载完成后,设置选中第一项  
                    	
                    	
                        var val = $(this).combobox('getData');  
                        for (var item in val[0]) {  
                            if (item == 'id') {  
                                $(this).combobox('select', val[0][item]);  
                                orgId=val[0][item];
                            }  
                        }
                    }  
                });  
			}, 'json');
			
			
			$.post('platform/restmanage/system/listByorg.html?orgId='+orgId+'&random='+Math.random(), {
			}, function(result1) {
				//$("#systemIduser").combobox("loadData", result);
				$('#systemIduser').combobox({  
					data: result1,  
                    onLoadSuccess: function () { //加载完成后,设置选中第一项  
                    	
                        var val1 = $(this).combobox('getData');  
                    	for (var item1 in val1[0]) {  
                        	if (item1 == 'id') {
                            	$(this).combobox('select', val1[0][item1]);  
                       		}  
                    	}  
                    }  
                });  
				
			}, 'json');
			
			url = 'platform/restmanage/user/add.html';
		}
		
		function editUser() {
			var row = $('#dguser').datagrid('getChecked');
			if (row.length==1) {
				$('#dlguser').dialog('open').dialog('setTitle', '编辑用户');
				$('#fmuser').form('clear');
				
				$.post('platform/restmanage/org/listAll.html?&random='+Math.random(), {
				}, function(result) {
					//$("#orgIduser").combobox("loadData", result);
					
					$('#orgIduser').combobox({  
						data: result,  
	                    onLoadSuccess: function () { //加载完成后,设置选中第一项  
	                        
	                    	$.post('platform/restmanage/system/listByorg.html?orgId='+row[0].orgId+'&random='+Math.random(), {
	        				}, function(result) {
	        					//$("#systemIduser").combobox("loadData", result);
	        					
	        					$('#systemIduser').combobox({  
	        						data: result,  
	        	                    onLoadSuccess: function () { //加载完成后,设置选中第一项  
	        	                        $('#fmuser').form('load', row[0]);
	        	                    }  
	        	                });  
	        				}, 'json');
	                    	
	                    } 					
	                });  
					
				}, 'json');
				
				url = 'platform/restmanage/user/edit.html?id=' + row[0].id;
			}else{
				$.messager.show({
					title : '错误',
					msg : '请选择一条记录!'
				});
			}
		}
		
		function saveUser() {
			$('#fmuser').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.errorMsg) {
						$.messager.show({
							title : 'Error',
							msg : result.errorMsg
						});
					} else {
						$.messager.show({
							 title : '提示',
							 msg : '操作成功！'
						});
						
						$('#dlguser').dialog('close'); 
						
						reloadUserDg();
					}
				}
			});
		}
		
		function deleteUser() {
			url='platform/restmanage/user/delete.html';
			var row = $('#dguser').datagrid('getChecked');
			if (row.length==1) {
				$.messager.confirm('',
						'确认删除吗?',
						function(r) {
							if (r) {
								$.post(url, {
									id : row[0].id
								}, function(result) {
									if (result.success) {
										$.messager.show({
											 title : '提示',
											 msg : '操作成功！'
										});
										reloadUserDg();
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
					msg : '请选择一条记录!'
				});
			}
		}
		
		function reloadUserDg(){
			url = 'platform/restmanage/user/list.html?systemId='+curSysId;
			$.post(url, {
			}, function(result) {
				$('#dguser').datagrid('loadData',result);
			}, 'json');
		}
		
</script>
</body>
</html>