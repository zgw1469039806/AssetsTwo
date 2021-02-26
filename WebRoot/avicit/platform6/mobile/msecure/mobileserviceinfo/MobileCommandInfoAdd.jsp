<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/msecure/mobileserviceinfo/MobileServiceInfoController/operation/sub2/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" /> <input type="hidden"
				name="serviceId" id="serviceId" value='${pid}' />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><span style="color: red;">*</span>方法URL地址:</th>
					<td width="40%"><input title="方法URL地址"
						class="inputbox easyui-validatebox"
						data-options="required:true,validType:'maxLength[200]'" style="width: 180px;"
						type="text" name="methodUrl" id="methodUrl" /></td>
					<th width="10%"><span style="color: red;">*</span>方法类型:</th>
					<td width="40%">
					<select name="methodType" id="methodType"
						class="easyui-combobox"
						data-options="width:151,editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						<option>POST</option>
						<option>GET</option>
						</select> </td>
				</tr>
				<tr>
					<th width="10%"><span style="color: red;">*</span>方法名称:</th>
					<td width="40%"><input title="方法名称"
						class="inputbox easyui-validatebox"
						data-options="required:true,validType:'maxLength[200]'" style="width: 180px;"
						type="text" name="methodName" id="methodName" /></td>
					<th width="10%"><span style="color: red;">*</span>方法备注:</th>
					<td width="40%"><input title="方法备注"
						class="inputbox easyui-validatebox"
						data-options="required:true,validType:'maxLength[200]'" style="width: 180px;"
						type="text" name="methodShowName" id="methodShowName" /></td>
				</tr>
			</table>
		</form>
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="保存" id="saveButton"
						class="easyui-linkbutton primary-btn" onclick="saveForm();"
						href="javascript:void(0);">保存</a> <a title="返回" id="returnButton"
						class="easyui-linkbutton" onclick="closeForm();"
						href="javascript:void(0);">返回</a></td>
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
		$(function() {
		});
		function closeForm() {
			parent.mobileCommandInfo.closeDialog("#insert");
		}
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.mobileCommandInfo.save(serializeObject($('#form')),
					"#insert");
		}

	</script>
</body>
</html>