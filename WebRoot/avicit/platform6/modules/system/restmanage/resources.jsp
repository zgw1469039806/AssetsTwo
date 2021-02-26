<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</head>
<body class="easyui-layout"  fit="true">

<div data-options="region:'west',split:true,title:''" style="width:250px;padding:0px;height:0">
	<ul id="tt">正在加载数据...</ul>
</div>

<div data-options="region:'center',split:true,border:false" style="padding:0px;height:0;overflow:hidden;">
	<table id="dg"  class="easyui-datagrid"  url="platform/restmanage/resources/list.json?systemId=-1"  fit="true" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" striped="true">
		<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true" width="50">id</th>
				<th data-options="field:'restUrl',required:true,align:'center'"  width="100">URL地址</th>
				<th data-options="field:'urlDesc',required:true,align:'center'"  width="100">地址描述</th>
				<th data-options="field:'systemName',required:true,align:'center'"  width="100">所属系统</th>
				<th data-options="field:'status',required:true,align:'center'"  width="50"  formatter="formatStatus">状态</th>
			</tr>
		</thead>
	</table>
	<!-- CRUD工具栏 -->
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添加</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser()">删除</a>
	</div>
	
	<!-- CU表单 -->
	<div id="dlg" class="easyui-dialog" style="width: 400px; height: 320px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		<div class="ftitle">资源信息</div>
		<form id="fm" method="post" novalidate>
			<div class="fitem">
				<span class="remind">*</span><label>URL:</label> <input name="restUrl" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<span class="remind">*</span><label>描述:</label> <input name="urlDesc" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<span class="remind">*</span><label>所属单位:</label> 
				<select id="orgId" name="orgId" class="easyui-combobox"   data-options="valueField:'id', textField:'orgName', width:166,editable:false,panelHeight:'auto'"></select>
			</div>
			<div class="fitem">
				<span class="remind">*</span><label>所属系统:</label> 
				<select id="systemId" name="systemId" class="easyui-combobox" data-options="valueField:'id', textField:'systemName', width:166,editable:false,panelHeight:'auto'">
				</select>
			</div>
			<div class="fitem">
				<span class="remind">*</span><label>有效标识:</label> 
				<select name="status" id="status" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="1">有效</option>
								<option value="0">无效</option>
				</select>
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveUser()" >保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')" >返回</a>
	</div>
	</div>
	
	<!-- button js event -->
	<script type="text/javascript">
	var url;
	var org;
	var sys;
	
	function formatStatus(val,row){    
	    if (val ==1){    
	        return '有效';    
	    } else {    
	        return '无效';    
	    }    
	} 
	
    $(function(){  
    	
        
        $.post('platform/restmanage/system/tree.json', {}, function(json) { 
            $("#tt").tree({ 
                data : json, 
                onClick : function(node) { 
                	
                	var parent = $('#tt').tree('getParent', node.target);
					if(parent!=null){
						org=parent.id;       
						sys=node.id;
					}else{
						org=node.id;       
						sys=null;
					}
					
                    $.post('platform/restmanage/system/tree.json', { 
                        "id" : node.id
                    }, function(json) { 
                    	var children = $('#tt').tree('getChildren', node.target);
                    	for (var i = 0; i < children.length; i++) {
                    		$('#tt').tree('remove', children[i].target);
                        }
                        $('#tt').tree('append', { 
                            parent : node.target, 
                            data : json
                        }); 
                    }, "json"); 

                    url = 'platform/restmanage/resources/list.json';
        			$.post(url, {
        				systemId : node.id
        			}, function(result) {
        				$('#dg').datagrid('loadData',result);
        			}, 'json');
                    
                } 
            }); 
        }, "json"); 
        
	});  
	
	
		
		function queryUser() {
			var value=$('#q_userName').val();
			url = 'platform/restmanage/resources/list.json';
			$.post(url, {
				userName : value
			}, function(result) {
				$('#dg').datagrid('loadData',result);
			}, 'json');
		}
		
		function newUser() {
			$('#dlg').dialog('open').dialog('setTitle', '新资源');
			$('#fm').form('clear');
			$.post('platform/restmanage/org/listAll.json', {
			}, function(result) {
				//$("#orgId").combobox("loadData", result);
				$('#orgId').combobox({  
					data: result,  
                    onLoadSuccess: function () { //加载完成后,设置选中第一项  
                        if(org!=null){
                        	//$('#orgId').combobox('setValues', [org]);
                        	$(this).combobox('select', org);
                        }else{
                    		var val = $(this).combobox('getData');  
                    		for (var item in val[0]) {  
                            	if (item == 'id') {  
                                	$(this).combobox('select', val[0][item]);
                                	org=val[0][item];
                            	}  
                        	}
                        }
                    },
                    onSelect:function(record){  
                    	if(record!=null){
                    		$.post('platform/restmanage/system/listByorg.json?orgId='+record.id+'&random='+Math.random(), {
                			}, function(result) {
                				$("#systemId").combobox("loadData", result);
                			}, 'json');
                    	}
                    }  
                });  
				
			}, 'json');
			
				//$('#orgId').combobox('setValues', [org]);
				$.post('platform/restmanage/system/listByorg.html?orgId='+org+'&random='+Math.random(), {
    			}, function(result) {
    				//$("#systemId").combobox("loadData", result);
    				$('#systemId').combobox({  
    					data: result,  
                        onLoadSuccess: function () { //加载完成后,设置选中第一项
    					    //20200725：设置默认选中的值时应该获取刚请求成功的数据
                            var val = $(this).combobox('getData');
                            for (var item in val[0]) {
                                if (item == 'id') {
                                    $(this).combobox('select', val[0][item]);
                                }
                            }
                            //20200725：以下写法在新增或者编辑页面切换组织是所属系统字段显示异常
                        	/*if(sys!=null){
                            	$(this).combobox('select', sys);
                            }else{
                        		var val = $(this).combobox('getData');  
                        		for (var item in val[0]) {  
                                	if (item == 'id') {  
                                    	$(this).combobox('select', val[0][item]);
                                	}  
                            	}
                            }*/
                        }  
                    });  
    			}, 'json');
				$('#status').combobox('setValues', "1");
			url = 'platform/restmanage/resources/add.html';
		}
		
		function editUser() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				
				$('#dlg').dialog('open').dialog('setTitle', '编辑资源');
				$('#fm').form('clear');
				
				$.post('platform/restmanage/org/listAll.json?&random='+Math.random(), {
				}, function(result) {
					$("#orgId").combobox("loadData", result);
				}, 'json');
				
				$.post('platform/restmanage/system/listByorg.json?orgId='+row.orgId+'&random='+Math.random(), {
				}, function(result) {
					$("#systemId").combobox("loadData", result);
				}, 'json');
				
				$('#fm').form('load', row);
				url = 'platform/restmanage/resources/edit.html?id=' + row.id;
			}else{
				$.messager.show({
					title : '错误',
					msg : '请选择一条记录!'
				});
			}
		}
		
		function saveUser() {
			var org =$("input[name='orgId']").val();
			if(!org || org.length ===  0){
				$.messager.alert('提示','所属单位不能为空！','warning');
				return;
			}
			
			var systemId =$("input[name='systemId']").val();
			if(systemId.length ===  0){
				$.messager.alert('提示','所属系统不能为空！','warning');
				return;
			}
			
			$('#fm').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.success) {
						$('#dlg').dialog('close'); 
						url = 'platform/restmanage/resources/list.json';
	        			$.post(url, {
	        				systemId : sys
	        			}, function(result) {
	        				$('#dg').datagrid('loadData',result);
	        			}, 'json');
						//$('#dg').datagrid('reload'); 
					} else {
						$.messager.show({
							title : 'Error',
							msg : result.msg
						});
					}
				}
			});
		}
		
		function deleteUser() {
			url='platform/restmanage/resources/delete.json';
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('',
						'确认删除吗?',
						function(r) {
							if (r) {
								$.post(url, {
									id : row.id
								}, function(result) {
									if (result.success) {
										url = 'platform/restmanage/resources/list.json';
					        			$.post(url, {
					        				systemId : sys
					        			}, function(result) {
					        				$('#dg').datagrid('loadData',result);
					        			}, 'json');
										//$('#dg').datagrid('reload');
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
	</script>
	
	<style type="text/css">
#fm {
	margin: 0;
	padding: 10px 30px;
}

.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 5px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}

.fitem input {
	width: 160px;
}
</style>
</body>
</html>