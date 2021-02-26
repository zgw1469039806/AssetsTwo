<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>事件参数注册</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="dbid" value="${dto.dbid}" /> <input type="hidden" name="thirdPartyDbid" value="${dto.thirdPartyDbid}" />
			<table class="form_commonTable">
				<tr>
					<th width="15%"><span class="remind">*</span>常量名:</th>
					<td width="85%"><input title="常量名" class="easyui-validatebox" data-options="required:true,validType:'maxLength[50]'" type="text" name="name" id="name" value="${dto.name}" /></td>
				</tr>
				<tr>
					<th>常量值:</th>
					<td><input title="常量值" class="easyui-validatebox" data-options="validType:'maxLength[250]'" type="text" name="initExpr" id="initExpr" value="${dto.initExpr}" /></td>
				</tr>
				<tr>
					<th><span class="remind">*</span>排序:</th>
					<td><input title="排序" class="easyui-numberbox" data-options="required:true,validType:'maxLength[10]'" type="text" name="orderBy" id="orderBy" value="${dto.orderBy}" /></td>
				</tr>
				<tr>
					<th>描述:</th>
					<td><textarea title="描述" class="textareabox" rows="3" cols="1" name="remark" id="remark">${dto.remark}</textarea></td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a title="保存" id="saveButton" class="easyui-linkbutton primary-btn" onclick="saveForm();" href="javascript:void(0);">保存</a> <a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		$.extend($.fn.validatebox.defaults.rules, {
			maxLength : {
				validator : function(value, param) {
					return param[0] >= value.length;

				},
				message : '请输入最多 {0} 字符.'
			}
		});
		function closeForm() {
			parent.myEventList.closeDialog();
		}

		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.myEventList.insertOrUpdateProperties(serializeObject($('#form')));
		}
	</script>
</body>
</html>