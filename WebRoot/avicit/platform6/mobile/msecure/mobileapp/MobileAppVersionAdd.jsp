<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/msecure/mobileapp/MobileAppController/operation/sub/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" /> <input type="hidden" name="appId" id="appId" value='${pid}' />
			<table class="form_commonTable">
				<tr>
					<th width="10%">版本类型:</th>
					<td width="40%"><select class="easyui-combobox" name="platformType" id="platformType" data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="ios">ios</option>
							<option value="android">android</option>
					</select></td>
					<th width="10%">应用版本号:</th>
					<td width="40%"><input title="应用版本号" class="inputbox easyui-validatebox" data-options="validType:'maxLength[50]'" style="width: 180px;" type="text" name="appVersion" id="appVersion" /></td>
				</tr>
				<tr>
					<th width="10%">版本状态:</th>
					<td width="40%"><select title="ios和android都只能有且只能有一个最新版" class="easyui-combobox" name="appStatus" id="appStatus" data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="2">最新版</option>
							<option value="1">旧版</option>
							<option value="0">禁用</option>
					</select></td>
					<th width="10%">应用下载地址:</th>
					<td width="40%"><input title="应用下载地址" class="inputbox easyui-validatebox" data-options="validType:'maxLength[255]'" style="width: 180px;" type="text" name="downloadUrl" id="downloadUrl" /></td>
				</tr>
				<tr>
					<th width="10%">应用描述:</th>
					<td width="40%"><input title="应用描述" class="inputbox easyui-validatebox" data-options="validType:'maxLength[255]'" style="width: 180px;" type="text" name="descript" id="descript" /></td>
				</tr>
			</table>
		</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="保存" id="saveButton" class="easyui-linkbutton primary-btn" onclick="saveForm();" href="javascript:void(0);">保存</a> <a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a></td>
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
			parent.mobileAppVersion.closeDialog("#insert");
		}
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.mobileAppVersion.save(serializeObject($('#form')), "#insert");
		}
	</script>
</body>
</html>