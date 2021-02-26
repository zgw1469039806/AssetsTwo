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

<%
String tableId=(String)request.getParameter("tableId");
%>

<script>

$(document).ready(function(){ 

	$.extend($.fn.validatebox.defaults.rules, {
            isBlank: {
                validator: function (value, param) { return $.trim(value) != '' },
                message: '不能为空，全空格也不行'
            }
     });
	
})

</script>

</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,title:''" style="padding:0px;height:0; overflow:hidden; font-size:0;">
	
	<table id="dg"  class="easyui-datagrid"  url="platform/eform/tabledefine/listversion.json?tableId=${tableId}"  data-options=" 
	 	fit: true,
		border: false,
		rownumbers: true,
		animate: true,
		collapsible: false,
		fitColumns: true,
		autoRowHeight: false,
		idField :'id',
		singleSelect: true,
		checkOnSelect: true,
		selectOnCheck: false,
		striped:true,
	 	toolbar:'#toolbar'">
		<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true" width="50">id</th>
				<th data-options="field:'versionValue',required:true,align:'center'"  width="100">版本号</th>
				<th data-options="field:'versionDesc',required:true,align:'center'"  width="100">备注</th>
			</tr>
		</thead>
	</table>
	
	<!-- CRUD工具栏 -->
	<div id="toolbar">
		<table>
		<tr>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser()">删除</a></td>
		<td><a class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="closeForm();" href="javascript:void(0);">返回</a></td>
		</tr>
		</table>
	</div>
	
	</div>
	<div data-options="region:'east',title:'版本字段'" style="width:500px;background:#f5fafe;height:0; overflow:hidden; font-size:0;">
		<table id='dgcol' class="easyui-datagrid"
       	 		data-options="
        		fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				method:'get',
				striped:true">
		    <thead>   
		        <tr> 
		        	<th data-options="field:'colName',required:true,align:'center'"  width="100">字段英文名</th>
					<th data-options="field:'colLabel',required:true,align:'center'"  width="100">字段中文名</th>
					<th data-options="field:'colType',required:true,align:'center'"  width="100"  formatter="Common.ColTypeFormatter">字段类型</th>
					<th data-options="field:'colLength',required:true,align:'center'"  width="80">字段长度</th>
		        </tr>   
		    </thead>   
		</table>  
	</div>
<script type="text/javascript">

var baseurl = '<%=request.getContextPath()%>';
var url;

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


function  deleteUser(){
	url='platform/eform/tabledefine/deleteversion.json?tableId=${tableId}';
	var myDatagrid=$('#dg');
	var rows = myDatagrid.datagrid('getChecked');
	var ids = [];
	var l =rows.length;
	if(l>0){
		for(;l--;){
			ids.push(rows[l].versionValue);
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
								$('#dg').datagrid('reload'); 
								$('#dgcol').datagrid('loadData',[]);
								parent.reloaddg();
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
			msg : '请选择版本信息!'
		});
	}
	
}

function closeForm(){
	if(parent != null){
		parent.dlg_close_only("deleteversion");
	}
}

$(function(){
	
	$.extend($.fn.validatebox.defaults.rules, {
        isBlank: {
            validator: function (value, param) { return $.trim(value) != '' },
            message: '不能为空，全空格也不行'
        }
 	});
	

	$('#dg').datagrid({
		onClickRow:function(index,data)
		{	
			var row=$('#dg').datagrid('getSelected');
			if(row){
				var tableId="<%=tableId%>";
				var version = data.versionValue;
				url = 'platform/eform/tabledefine/getColumnByVersion.json';
				$.post(url, {
					tableId:tableId,version:version
				}, function(result) {
					$('#dgcol').datagrid('loadData',result);
				}, 'json');
			}
		},
		onLoadSuccess:function(data)
		{
			$('#dg').datagrid('doCellTip',   
					{   
						onlyShowInterrupt:true,   
						position:'right',
						tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
					}); 
		
		}
	});
	
});


</script>



</body>
</html>