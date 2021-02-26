<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</head>

<body class="easyui-layout"  fit="true">
<div data-options="region:'center',split:true,border:false" style="padding:0px;overflow:hidden;">
		<form id="fmdoc" method="post" novalidate>
				<div class="fitem"><label>数据源名称:</label> <input name="datasourceName" style="width:260px;"  class="easyui-validatebox" required="true"></div>
				<div class="fitem"><label>显示名称:</label> <input name="displayName" style="width:260px;"  class="easyui-validatebox" required="true"></div>
				
			<div class="fitem">
				<label>权限控制:</label> 
				<select id="authId" name="sysroleFk" class="easyui-combobox"   data-options="valueField:'id', textField:'roleName', width:260,editable:false,panelHeight:'auto'"></select>
			</div>		
				
				
			<div class="fitem">
				<label>有效标识:</label> 
				<select name="status" class="easyui-combobox" data-options="width:260,editable:false,panelHeight:'auto'">
								<option value="1">有效</option>
								<option value="0">无效</option>
				</select>
			</div>
				<div class="fitem"><label>简要描述:</label> <input name="datasourceDesc" class="easyui-validatebox"    data-options="multiline:true" style="height:60px" required="true"></div>
				<div class="fitem"><label>文档路径:</label> <input name="docPath" class="easyui-validatebox"    data-options="multiline:true" style="height:60px" required="true"></div>
		</form>
		
	<div id="dlg-buttons"  class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
	<table class="tableForm" border="0" cellspacing="1" width='100%'>
		<tr>	
		<td align="right">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveDoc()" >保存</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:parent.dlg_close_only('insert')" >返回</a>
		</td>
		</tr>
		</table>
	</div>
	
	</div>
	<!-- button js event -->
	<script type="text/javascript">
	
		var url;
		
		$(function(){
		
			$.post('platform/search/connection/listAuth.html', {
			}, function(result) {
				$("#authId").combobox("loadData", result);
			}, 'json');
		
			$('#fm').form('clear');
			url = 'platform/search/adddoc.html';
		
		});
		
		function saveDoc() {
			$('#fmdoc').form('submit', {
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
						parent.dg_reload('dg');
						parent.dlg_close_only('insert');
					}
				}
			});
		}
		
		
	</script>
	
	<style type="text/css">
#fmdoc {
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
	width: 260px;
}
</style>
</body>
</html>