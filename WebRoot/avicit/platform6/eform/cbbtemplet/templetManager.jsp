<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>

<html>
	<head>
	<%
		String appId = SessionHelper.getApplicationId();
	%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>模板管理</title>
		<base href="<%=ViewUtil.getRequestPath(request) %>">
		<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
		<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
		<script src="avicit/platform6/eform/cbbtemplet/js/templetField.js" type="text/javascript"></script>
		<script src="avicit/platform6/eform/cbbtemplet/js/templetTree.js" type="text/javascript"></script>
		
		
	</head>
	
	<body class="easyui-layout" fit="true">
		<div data-options="region:'west',title:'模板树',split:true" style="width:200px;background:#f5fafe;overflow-y:hidden;padding:0px;height:0; overflow:hidden; font-size:0;">
			<%@ include file ="templetTree.jsp"%>
		</div>
		<div data-options="region:'center',title:'基础字段表'" style="background:#ffffff;padding:0px;height:0; overflow:hidden; font-size:0;">
			<%@ include file ="templetField.jsp"%>
		</div>
		<div data-options="region:'east',title:' 通用代码',split:true" style="width:400px;background:#f5fafe;padding:0px;height:0; overflow:hidden; font-size:0;">
			<%@ include file ="templetCode.jsp"%>
		</div>
	</body>
	
	<script type="text/javascript">
			var tree;
			var appId = "<%=appId%>";
			var templetField;
			$(function(){
				tree = new CbbTempletTree('templetTree','searchTempletTree','contextMenu');
				tree.setOnLoadSuccess(function(){
					templetField = new CbbTempletField('fieldList','${url}','searchDialog','form1','buttonArea');
					templetField.setOnSelectRow(function(rowIndex, rowData,id){
						var url = "platform/cbbTemplet/"+id+"/"+appId+"/searchCodeByPage.json";
						$("#codeList").datagrid({url:url});

					});
					
				});
				tree.setOnSelect(function(_tree,node){
					templetField.controlButton(node.attributes.type);
					templetField.loadByTreeId(node.id,appId);
				});
				tree.init(appId);
			});
			function closeImportData(){
				$("#importData").dialog('close');
			}
			function cellTip(data){
				
				$('#codeList').datagrid('doCellTip',   
				{   
					onlyShowInterrupt:true,   
					position:'bottom',
					tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
				}); 
				
			};
		</script>
	
</html>