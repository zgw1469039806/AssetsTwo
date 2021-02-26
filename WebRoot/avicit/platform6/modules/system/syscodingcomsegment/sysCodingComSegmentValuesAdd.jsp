<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加通用码段码值</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	//去除输入的空格
	$('#segmentName,#segmentValue').bind('input propertychange', function() {
		var newValue = $.trim($(this).val());
		if(newValue != $(this).val()){
			$(this).val(newValue);
		}
	}); 
});
</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
	<form id="formSegmentValue" method="post" action="" style="margin-top: 10px;_margin-top: 2px;">
		<input id="segmentId" name="segmentId" type="hidden" value="${segment.id}"/>
		<table id="tableComSegment" class="form_commonTable">
			<tr>
				<th width="70px"><span class="remind">*</span>码名称</th>
				<td><input id="segmentName" name="segmentName" class="easyui-validatebox" required="true" data-options="validType:'length[0,100]'" /></td>
			</tr>
			<tr>
				<th><span class="remind">*</span>码值</th>
				<td>
					<c:choose>
						<c:when test="${segment.segmentLength gt 0}">
							<input id="segmentValue" name="segmentValue" class="easyui-validatebox" required="true" data-options="invalidMessage:'码值的长度必须为${segment.segmentLength }位',validType:'length[${segment.segmentLength },${segment.segmentLength }]'" />
						</c:when>
						<c:otherwise>
							<input id="segmentValue" name="segmentValue" class="easyui-validatebox" required="true" data-options="invalidMessage:'码段长度不能大于50',validType:'length[1,50]'"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th><span class="remind">*</span>排序</th>
				<td><input id="orderBy" name="orderBy" class="easyui-numberbox" required="true" data-options="min:1,max:10000" /></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
