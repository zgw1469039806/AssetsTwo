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

</head>

<body class="easyui-layout" fit="true">
    <div data-options="region:'center',split:true,border:false">

		<form id="fm" method="post" novalidate>
		<table class="form_commonTable">
		<tr>
			<th  width="10%">
			    <span class="remind">*</span>
				表英文名称:
			</th>
			<td width="40%"><input name="tableName"   id="tableName"   class="easyui-validatebox"     data-options="required:true,validType:['isBlank','length[0,32]']"       <c:if test="${tableIsCreated== 'Y'}">readonly</c:if>   ><br><font color=red>(建议英文数字下划线组合方式)</font></td>
		</tr>
		<tr>
			<th  width="10%">
			    <span class="remind">*</span>
				模块名称:</th> 
				<td width="40%"><input name="tableTitle" class="easyui-validatebox"   data-options="required:true,validType:['isBlank','length[0,32]']" ></td>
		</tr>
		
		<tr>
			<th  width="10%">
			   <span class="remind">*</span>
				是否附件:
			</th>
			<td width="40%">
				<select name="tableIsUpload" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="N" >否</option>
								<option value="Y">是</option>
				</select>
			</td>
			</tr>
			
			<tr>
			<th  width="10%">
			    <span class="remind">*</span>
				是否流程:
			</th> 
			<td width="40%">
			<select name="tableIsBpm" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
								<option value="N" >否</option>
								<option value="Y">是</option>
				</select>
			</td>
			</tr>
			
			<tr>
			<th  width="10%">
				子表名:
			</th> 
			<td width="40%">
				<input name="subTableName" class="easyui-validatebox"  >
			</td>
			</tr>
			<tr>
			<th  width="10%">
				子表外键字段:
			</th> 
			<td width="40%"><input name="subColumnName" class="easyui-validatebox"    ></td>
			</tr>
			</table>
		</form>
		</div>
		<div data-options="region:'south',border:false" style="height:40px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
			<tr>	
				<td width="50%" align="right">
				<a href="javascript:void(0)" class="easyui-linkbutton primary-btn"   onclick="saveUser()" >保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:parent.dlg_close_only('update')" >返回</a>
				</td>
			</tr>
			</table>
		</div>
		</div>
		
	
<script type="text/javascript">

var baseurl = '<%=request.getContextPath()%>';
var url;
$(function(){
	
	$.post('platform/eform/tabledefine/allversion.json?tableId=${id}', {
	}, function(result) {
		$("#attribute08").combobox("loadData", result);
	}, 'json');
	
	var results=$.parseJSON('${result}');
	$('#fm').form('load', results);
	
	$.extend($.fn.validatebox.defaults.rules, {
        isBlank: {
            validator: function (value, param) { return $.trim(value) != '' },
            message: '不能为空，全空格也不行'
        }
 	});
	
});

function saveUser() {
	url = 'platform/eform/tabledefine/edit.json?id=${id}';
	if($('#fm').form('validate')){
	
		$.post(url, {
			str : JSON.stringify(serializeObject($('#fm')))
			}, function(result){
				if (result.success) {
					parent.dg_reload('dg');
					parent.dlg_close('update');
				} else {
					parent.alertSuccess('错误',result.msg);
				}
			}, 'json');
	
	}
}

</script>
</body>
</html>