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
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
	<form id='form' enctype="multipart/form-data">
		<table class="form_commonTable">
			<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="workOwnerName">委托人:</label></th>
				<td width="39%">
                    <input type="text" class="form-control input-sm" name="workOwnerName" id="workOwnerName" readonly="readonly" value="${workHand.workOwnerName}">
                </td>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="workOwnerDeptName">委托人部门:</label></th>
				<td width="39%">
                    <input type="text" class="form-control input-sm" name="workOwnerDeptName" id="workOwnerDeptName" readonly="readonly" value="${workHand.workOwnerDeptName }">
                </td>
			</tr>
			<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="receptUserName">默认受托人:</label></th>
				<td width="39%">
                    <input   type="text" class="form-control input-sm" id="receptUserName" name="receptUserName" readonly="readonly" value="${workHand.receptUserName }">
                </td>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="receptDeptName">受托人部门:</label></th>
				<td width="39%">
					<input type="text" class="form-control input-sm" name="receptDeptName" id="receptDeptName" readonly="readonly" value="${workHand.receptDeptName }">
				</td>
			</tr>
			<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="handEffectiveDate">起始日期:</label></th>
				<td width="39%" >
					<input name="handEffectiveDate" class="form-control input-sm" id="handEffectiveDate" data-options="editable:false,readonly:true" readonly="readonly" value="${workHand.handEffectiveDateStr }"/>
				</td>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="backDate">截止日期:</label></th>
				<td width="39%" >
                    <input name="backDate" class="form-control input-sm" id="backDate"  data-options="editable:false,readonly:true" readonly="readonly" value="${workHand.backDateStr }"/>
				</td>
			</tr>
			<tr>
                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="handAcceptedTask">委托已有待办事宜:</label></th>
                <td width="39%">
					 <input type="checkbox" class="form-control input-sm" id="handAcceptedTask" name="handAcceptedTask" disabled="disabled" <c:if test="${workHand.handAcceptedTask=='1'}">checked="checked"</c:if>/>
                </td>
                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="expireAutoCancel">到期后自动注销:</label></th>
                <td width="39%">
					 <input type="checkbox" class="form-control input-sm" id="expireAutoCancel" name="expireAutoCancel" disabled="disabled" <c:if test="${workHand.expireAutoCancel=='1'}">checked="checked"</c:if> />
					 
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="handReason">委托原因:</label></th>
                <td width="84%" colspan="3">
                    <input type="text" class="form-control input-sm" id="handReason" name="handReason" value="${workHand.handReason }" readonly="readonly">
                </td>
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
					<td width="39%"><input value="${item.modelName }" class="form-control input-sm"name="modelId" readonly="readonly"/></td>
					<th width="10%">受托人:</th>
					<td width="39%"><input value="${item.receptUserName }" class="form-control input-sm" name="userId" readonly="readonly"/></td>
					
				</tr>
			</c:forEach>
		</table>
	</c:if>
</div>
</body>
<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<style type="text/css">
    .error{
        background:#FFF7FA
        border:1px solid #CE7979
        color:#F00
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {       

    });
    
</script>

</html>