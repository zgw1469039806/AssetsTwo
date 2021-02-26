<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>

<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
<title>添加流程表单</title>
<style>
body td {
	font-family: Microsoft Yahei, sans-serif, Arial, Helvetica;
	font-size: 12px;
	padding-left: 0.5em;
}
</style>
<script type="text/javascript">
	var baseurl = '<%=request.getContextPath()%>';
	$(function() {

	});
</script>
</head>

<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<form id="form1" method="post">
			<input name="validFlag" id="validFlag" style="display:none;" value="1" /> <input name="appId" id="appId" style="display:none;" value="1" /> <input name="formType" id="formType" style="display:none;" value="URI" />
			<table class="form_commonTable">
				<tr>
					<th width="20%"><span class="remind">*</span>表单代码:</th>
					<td width="80%"><input class="easyui-validatebox" id="formCode" name="formCode" required="true" /></td>
				</tr>
				<tr>
					<th width="20%"><span class="remind">*</span>表单名称:</th>
					<td width="80%"><input class="easyui-validatebox" id="formName" name="formName" required="true" /></td>
				</tr>
				<tr>
					<th width="20%"><span class="remind">*</span>PC表单URL:</th>
					<td width="80%"><input class="easyui-validatebox" id="formUrl" name="formUrl" required="true"/></td>
				</tr>
				<tr>
					<th width="20%">移动表单URL:</th>
					<td width="80%"><input class="easyui-validatebox" id="formUrlMobile" name="formUrlMobile" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>

