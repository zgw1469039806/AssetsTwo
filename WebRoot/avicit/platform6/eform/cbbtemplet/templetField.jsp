<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>

<div id="fieldTool" class="datagrid-toolbar" style="display: block;">
				<table class="tableForm" id="roleSearchForm" width='100%'>
					<tr>
						<td >
							<div id="buttonArea">
								<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="templetField.insert(appId);" href="javascript:void(0);">添加字段</a>
								<a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="templetField.modify(appId);" href="javascript:void(0);">编辑字段</a>
															    <a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="templetField.del();" href="javascript:void(0);">删除字段</a>
								<a class="easyui-linkbutton" iconCls="icon-lookup" plain="true" onclick="templetField.openSyslookup(appId);" href="javascript:void(0);">关联通用代码</a>
								<a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="templetField.delLookup();" href="javascript:void(0);">取消关联通用代码</a>
								<!--  
								<a class="easyui-linkbutton" iconCls="icon-setting" plain="true" onclick="templetField.importCbb(appId);" href="javascript:void(0);">导入</a>
							    -->
							    <a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="templetField.openSearchForm();" href="javascript:void(0);">查询</a>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<table id="fieldList" class="easyui-datagrid"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					toolbar:'#fieldTool',
					idField :'id',
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
						<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
						<th data-options="field:'colName',required:true,halign:'center',align:'center'" editor="{type:'text'}" width="220">字段英文名</th>
						<th data-options="field:'colLabel',required:true,halign:'center',align:'center'" editor="{type:'text'}" width="220">字段中文名</th>
						<th data-options="field:'colType',halign:'center',align:'center'"  formatter="Common.ColTypeFormatter"  width="180">字段类型</th>
						<th data-options="field:'colLength',halign:'center',align:'center'" editor="{type:'text'}"  width="160">字段长度</th>
						<th data-options="field:'colIsSearch',halign:'center',align:'center',formatter:formatYn" editor="{type:'text'}"  width="220">是否查询字段</th>
						<th data-options="field:'colIsMust',halign:'center',align:'center',formatter:formatYn" editor="{type:'text'}"  width="220">是否必填</th>
						<th data-options="field:'colIsTabVisible',halign:'center',align:'center',formatter:formatYn" editor="{type:'text'}"  width="220">是否列表显示</th>
						<th data-options="field:'attribute01',halign:'center',align:'center'" editor="{type:'text'}"  width="420">通用代码</th>
					</tr>
				</thead>
			</table>
			<!--*****************************搜索*********************************  -->
	<div id="searchDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" style="width: 810px;height:200px;display: none;">
		<form id="form1">
    		<table class="form_commonTable">
    			<tr>
    				<th width="10%">字段名:</th>
    				<td width="40%"><input class="easyui-validatebox" type="text" name="colName"/></td>
    				<th width="10%">字段中文名:</th>
    				<td width="40%"><input class="easyui-validatebox" type="text" name="colLabel"/></td>
    			</tr>
    			
    		</table>
    	</form>
    	<div id="dlg-buttons1" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
	<table class="tableForm" border="0" cellspacing="1" width='100%'>
			<tr>	
				<td  align="right">
					<a class="easyui-linkbutton primary-btn" plain="false" onclick="templetField.searchData();" href="javascript:void(0);">查询</a>
    		<a class="easyui-linkbutton" plain="false" onclick="templetField.clearData();" href="javascript:void(0);">清空</a>
    		<a class="easyui-linkbutton" plain="false" onclick="templetField.hideSearchForm();" href="javascript:void(0);">返回</a>
				</td>
			</tr>
	</table>
	</div>
    	<!-- <div id="searchBtns">
    		<a class="easyui-linkbutton" plain="false" onclick="templetField.searchData();" href="javascript:void(0);">查询</a>
    		<a class="easyui-linkbutton" plain="false" onclick="templetField.clearData();" href="javascript:void(0);">清空</a>
    		<a class="easyui-linkbutton" plain="false" onclick="templetField.hideSearchForm();" href="javascript:void(0);">返回</a>
    	</div> -->
  </div>
  <script type="text/javascript">
  
  
  var Common = {
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
		    }
};
  
  function formatYn(value){
	  if (value == "Y"){
		  return "是";
	  }else{
		  return "否";
	  }
  }
  </script>
  
