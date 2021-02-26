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
<script src="static/js/platform/component/jQuery/jquery-easyui-1.3.5/extend/easyui.fieldset.extentd.js" type="text/javascript"></script>


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
    <div data-options="region:'center',split:true,border:false">

		<form id="fm" method="post" novalidate>
		<div id="tableInfo" style="overflow:hidden;position: relative;">
		<table class="form_commonTable">
		<tr>
		<th width="15%">
		<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
									<span class="required-icon"></span>
		</span>
		版本号:</th>
		<td width="85%"><input id="versionValue"   name="versionValue" class="easyui-validatebox"   data-options="required:true,validType:['isBlank','length[0,32]']"   ></td>
		</tr>
		<tr>
		<th>
		<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
		</span>
		备注:</th>
		<td><input id="versionDesc"  name="versionDesc" class="easyui-validatebox"   ></td>
		</tr>
		<tr>
		<th>
		表英文名称:</th>
		<td><input  class="easyui-validatebox"   value="${cbbtable.tableName }" disabled="true" ></td>
		</tr>
		</table>
		</div>
			
		<div id="colInfo" style="overflow:hidden;position: relative;">
				<table class="form_commonTable"  >
				<tr>
					<td  width="25%" align="center"></td>
					<td  width="25%" align="center"><B>字段英文名</B></td>
					<td  width="25%" align="center"></td>
					<td  width="25%" align="center"><B>字段中文名</B></td>
				</tr>
				<c:forEach items="${cbbcol}"   var="item"  varStatus="status">
				<tr>
				<td  width="25%" align="center"></td>
				<td  width="25%" align="center">${item.colName }</td>
				<td  width="25%" align="center"></td>
				<td  width="25%" align="center">${item.colLabel }</td>
				</tr>
				</c:forEach>
				</table>	
		</div>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;">
	<div id="dlg-buttons1" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
	<table class="tableForm" border="0" cellspacing="1" width='100%'>
			<tr>	
				<td align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton primary-btn" onclick="saveWithValidateUnique()" >保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:parent.dlg_close_only('addversion')" >返回</a>
				</td>
			</tr>
	</table>
	</div>
	</div>
	
<script type="text/javascript">

var baseurl = '<%=request.getContextPath()%>';
var url;
var tableId = '<%=tableId%>';

$("#tableInfo").lqfieldset({  
    title:"基本信息",
    collapsible:false,  
    collapsed:false,  
    checkboxToggle:false  
});  

$("#colInfo").lqfieldset({  
    title: "字段信息",
    collapsible:true,  
    collapsed:false,  
    checkboxToggle:false  
});  

$(function(){
	
	$.extend($.fn.validatebox.defaults.rules, {
        isBlank: {
            validator: function (value, param) { return $.trim(value) != '' },
            message: '不能为空，全空格也不行'
        }
 	});
	
	
});


function saveWithValidateUnique(){
	var versionValue = $("#versionValue").val();
	 var pattern=/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;  
	 if(pattern.test(versionValue)){  
			$.messager.show({
				title : '提示',
				msg : '版本号包含非法字符，请检查！'
			});
	        return false;     
	 }   
	 $.ajax({
		 url:'platform/eform/tabledefine/'+encodeURI(versionValue)+'/'+tableId+'/validateVersion.json',
		 type : 'get',
		 success : function(r){
			 if (r.msg){
				 $.messager.alert('错误',r.msg,'error');
			 }else{
				 url = 'platform/eform/tabledefine/addversion.json?tableId=${tableId}&ids='+escape('${ids}');
				 if(r.isUnique=='true'){
					 if($('#fm').form('validate')){
						 $.post(url, {
								str : JSON.stringify(serializeObject($('#fm')))
								}, function(result){
										$.messager.show({
											title : '提示',
											msg : '保存成功！'
										});
										parent.dlg_close('addversion');
								}, 'json');
					 }
				 }else{
					 if($('#fm').form('validate')){
						 $.messager.confirm('请确认', '您所填写的版本号已经存在，是否要覆盖原版本', function(b) {
								if (b) {
									$.post(url, {
										str : JSON.stringify(serializeObject($('#fm')))
										}, function(result){
												$.messager.show({
													title : '提示',
													msg : '保存成功！'
												});
												parent.dlg_close('addversion');
										}, 'json');
								}
								
							});
					 }
				 } 
			 }
		 }
	 });
}


function saveCol() {
	 url = 'platform/eform/tabledefine/addversion.json?tableId=${tableId}&ids='+escape('${ids}');
	if($('#fm').form('validate')){
				if (b) {
					$.post(url, {
						str : JSON.stringify(serializeObject($('#fm')))
						}, function(result){
								$.messager.show({
									title : '提示',
									msg : '保存成功！'
								});
								parent.dlg_close('addversion');
						}, 'json');
				}
				
	
	}
}


</script>



</body>
</html>