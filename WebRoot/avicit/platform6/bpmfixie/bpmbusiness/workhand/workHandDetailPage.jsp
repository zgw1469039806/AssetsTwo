<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<title>委托详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form' enctype="multipart/form-data">
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">委托人:</th>
					<td class="disabled" width="z%"><input title="委托人"
						class="easyui-validatebox" type="text" name="workOwnerName" 
						id="workOwnerName" readonly="readonly" value='${workHand.workOwnerName}'/></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">委托人部门:</th>
					<td class="disabled" width="39%"><input title="委托人部门"
						class="easyui-validatebox" type="text" name="workOwnerDeptName" 
						id="workOwnerDeptName" readonly="readonly" value='${workHand.workOwnerDeptName}'/></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">默认受托人:</th>
					<td class="disabled" width="39%"><input title="默认受托人"
						class="easyui-validatebox" type="text" name="receptUserName" 
						id="receptUserName" readonly="readonly" value='${workHand.receptUserName}'/></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">受托人部门:</th>
					<td class="disabled" width="39%"><input title="受托人部门"
						class="easyui-validatebox" type="text" name="receptDeptName" 
						id="receptDeptName" readonly="readonly" value='${workHand.receptDeptName}'/></td>	
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">起始日期:</th>
					<td class="disabled" width="39%"><input title="起始日期"
						class="easyui-validatebox" type="text" name="handEffectiveDate" 
						id="handEffectiveDate" readonly="readonly" value='${workHand.handEffectiveDateStr}'/></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">截止日期:</th>
					<td class="disabled" width="39%"><input title="截止日期"
						class="easyui-validatebox" type="text" name="backDate" id="backDate"
						readonly="readonly" value='${workHand.backDateStr}'/></td>	
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="handAcceptedTask">委托已有待办事宜:</label></th>
					<td width="39%"><input type="checkbox"       groupCtrlSpan
						class="form-control input-sm" id="handAcceptedTask"
						name="handAcceptedTask" disabled="disabled"
						<c:if test="${workHand.handAcceptedTask=='1'}">checked="checked"</c:if> />
					</td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="expireAutoCancel">到期后自动注销:</label></th>
					<td width="39%"><input type="checkbox"
						class="form-control input-sm" id="expireAutoCancel"
						name="expireAutoCancel" disabled="disabled"
						<c:if test="${workHand.expireAutoCancel=='1'}">checked="checked"</c:if> />

					</td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">委托原因:</th>
					<td class="disabled" width="39%"><input title="委托原因"
						class="easyui-validatebox" type="text" name="handReason" id="handReason"
						readonly="readonly" value='${workHand.handReason}'/></td>
				</tr>
			</table>
		</form>
		<c:if test="${modelList!=null && modelList.size()>0}">
			<table class="form_commonTable" id="customTable">
				<tr>
					<th width="10%">自定义委托:</th>
					<td colspan="3"></td>
				</tr>
				<c:forEach var="item" items="${modelList }">
					<tr>
						<th width="10%">委托范围:</th>
						<td width="39%" class="disabled"><input value="${item.modelName }"
							class="easyui-validatebox" name="modelId" readonly="readonly" /></td>
						<th width="10%">受托人:</th>
						<td width="39%" class="disabled"><input value="${item.receptUserName }"
							class="easyui-validatebox" name="userId" readonly="readonly" /></td>

					</tr>
				</c:forEach>
			</table>
		</c:if>
	</div>
		<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
				  	<td width="50%" align="right">
						<a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a>
				  	</td>
				</tr>
			</table>
		</div>
	</div
</body>
<jsp:include
	page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<script type="text/javascript">
    $(document).ready(function () {       

    });
  //返回按钮绑定事件
	function closeForm() {
		parent.entrustGrid.closeDialog(window.name);
	}
</script>

</html>