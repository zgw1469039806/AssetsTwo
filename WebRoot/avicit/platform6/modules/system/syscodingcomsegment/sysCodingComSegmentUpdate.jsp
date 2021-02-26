<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑通用码段</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	//去除输入的空格
	$('#segmentName').bind('input propertychange', function() {
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
	<form id="formComSegment" method="post" action="" style="margin-top: 15px;">
		<input id="id" name="id" type="hidden" value="${comSegment.id}"/>
		<input id="version" name="version" type="hidden" value="${comSegment.version}"/>
		<table class="form_commonTable">
			<tr height="30px">
				<th width="70px"><span class="remind">*</span>码段名称</th>
				<td width="210px"><input id="segmentName" name="segmentName" class="easyui-validatebox" required="true" data-options="validType:'length[0,100]'" value="${comSegment.segmentName }"/></td>
				<th width="60px">码段长度</th>
				<td width="110px"><input id="segmentLength" name="segmentLength" class="easyui-numberbox"  data-options="min:1,max:99" value="${comSegment.segmentLength }"/></td>
			</tr>
			<tr height="45px">
				<th align="right">说明</th>
				<td colspan="4">
					<textarea class="easyui-validatebox textareabox" id="segmentRemark" name="segmentRemark" data-options="required:false,validType:'length[0,2000]'" style="height:45px!important;">${comSegment.segmentRemark }</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
