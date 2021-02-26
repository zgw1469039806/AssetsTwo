<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
	<title>添加流程表单</title>
	<style>
		body td{
			font-family: Microsoft Yahei,sans-serif,Arial,Helvetica;
			font-size: 12px;
			padding-left: 0.5em;
		}
	</style>
</head>

<body class="easyui-layout" fit="true">
     <div region="center" border="false" style="overflow: hidden;">
       <form id="form1" method="post">
       	<input name="id" id="id"  type="hidden" value="${bpmForms.id }" />
        <table class="form_commonTable">
        	<tr>
				<th width="20%"><span class="remind">*</span>表单代码:</th>
				<td width="80%"><input class="easyui-validatebox" id="formCode" name="formCode" required="true" value="${bpmForms.formCode }"/></td>
			</tr>
			<tr>
				<th width="20%"><span class="remind">*</span>表单名称:</th>
				<td width="80%"><input class="easyui-validatebox" id="formName" name="formName" required="true" value="${bpmForms.formName }"/></td>
			</tr>
			<tr>
				<th width="20%"><span class="remind">*</span>PC表单URL:</th>
				<td width="80%"><input class="easyui-validatebox" id="formUrl" name="formUrl" required="true" value="${bpmForms.formUrl }"/></td>
			</tr>
			<tr>
				<th width="20%">移动表单URL:</th>
				<td width="80%"><input class="easyui-validatebox" id="formUrlMobile" name="formUrlMobile" required="true" value="${bpmForms.formUrlMobile }"/></td>
			</tr>
			</table>
		</form>
	</div>
	
</body>
</html>

