<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>

<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>

<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<title>添加移交项</title>
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
		 $("#handEffectiveDate").datebox("setValue",parserColumnTime("${workHand.handEffectiveDate}").format("yyyy-MM-dd"));
		 $("#backDate").datebox("setValue",parserColumnTime("${workHand.backDate}").format("yyyy-MM-dd"));
		 $("#handDate").datebox("setValue",parserColumnTime("${workHand.handDate}").format("yyyy-MM-dd"));
	});
</script>
</head>

<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id="workhandForm" method="post">
			<table class="form_commonTable">
				<tr>
					<th width="12%">移交人:</th>
					<td width="38%"><input class="easyui-validatebox" name="workOwnerName" id="workOwnerName" readonly="readonly" value="${workHand.workOwnerName }"/></td>
					<th width="12%">移交部门:</th>
					<td width="38%"><input class="easyui-validatebox" name="workOwnerDeptName" id="workOwnerDeptName" readonly="readonly" value="${workHand.workOwnerDeptName }"/></td>
				</tr>
				<tr>
					<th width="12%">默认接受人:</th>
					<td width="38%"><input class="easyui-validatebox" name="receptUserName" id="receptUserName" readonly="readonly" value="${workHand.receptUserName }"/></td>
					<th width="12%">接受部门:</th>
					<td width="38%"><input class="easyui-validatebox" id="receptDeptName" name="receptDeptName" readonly="readonly" value="${workHand.receptDeptName }"/></td>
				</tr>
				<tr>
					<th width="12%">生效日期:</th>
					<td width="38%"><input name="handEffectiveDate" id="handEffectiveDate" class="easyui-datebox" data-options="editable:false,readonly:true"/></td>
					<th width="12%">返回日期:</th>
					<td width="38%"><input name="backDate" id="backDate" class="easyui-datebox" data-options="editable:false,readonly:true"/></td>
				</tr>
				<tr>
					<th width="12%">登记日期:</th>
					<td width="38%"><input name="handDate" id="handDate" class="easyui-datebox" data-options="editable:false,readonly:true"/></td>
					<th width="12%">是否有效:</th>
					<td width="38%"><select name="validFlag" class="easyui-combobox" data-options="{readonly:true,required:true,panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel}">
							<option <c:if test="${workHand.validFlag == '1' }">selected</c:if> value="1">有效</option>
							<option <c:if test="${workHand.validFlag == '0' }">selected</c:if> value="0">无效</option>
					</select></td>
				</tr>
				<tr>
					<th width="12%">移交原因:</th>
					<td colspan="3"><input name="handReason" id="handReason" class="easyui-validatebox" value="${workHand.handReason }" readonly="readonly"/></td>
					<!-- <textarea name="handReason" rows="3" class="textareabox" readonly="readonly"></textarea> -->
				</tr>
				<tr>
					<th width="12%">到期后自动注销:</th>
					<td colspan="3">
						<input type="checkbox" id="expireAutoCancel" name="expireAutoCancel" <c:if test="${workHand.expireAutoCancel == '1' }">checked</c:if>  readonly="readonly"/>
				</tr>
			</table>
		</form>
		<small style="font-size:12px;">若配置按模块移交，则优先根据模块接受人进行移交。其他情况还是移交给默认接受人。</small>
		<table class="form_commonTable" id="modules">
			<c:forEach var="item" items="${modelList }">
				<tr>
					<th width="12%">按模块移交:</th>
					<td width="30%"><input value="${item.modelName }" class="easyui-validatebox" name="modelId" readonly="readonly"/></td>
					<th width="12%">接受人:</th>
					<td width="30%"><input value="${item.receptUserName }" class="easyui-validatebox" name="userId" readonly="readonly"/></td>
					<td width="16%">
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>

