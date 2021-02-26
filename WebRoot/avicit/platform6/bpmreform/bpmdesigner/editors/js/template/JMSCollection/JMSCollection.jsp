<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<HTML>
<head>
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ui-1.9.2.custom/css/base/jquery-ui-1.9.2.custom.css"/>

</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form' enctype="multipart/form-data">
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="varName">名称:</label></th>
					<td width="39%"><input title="名称" class="form-control input-sm" type="text" name="varName" id="varName" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="varInit">初始值:</label></th>
					<td width="39%"><input title="初始值" class="form-control input-sm" type="text" name="varInit" id="varInit" /></td>
				</tr>
					<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="varType">类型:</label></th>
					<td width="35%" >
						<select class="form-control input-sm"  name="varType" id="varType" title="">
							<option value="string">string</option>
							<option value="int">int</option>
							<option value="long">long</option>
							<option value="float">float</option>
							<option value="double">double</option>
							<option value="true">true</option>
							<option value="false">false</option>
							<option value="object">object</option>
						</select>
					</td>
				</tr>
			</table>
			
		</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript">
		$(function() {
			$("form").validate({
				rules: {
					varName: {
						required: true,
					},
					varInit: {
						required: true,
					},
				}
			});
			
			
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			var parentId = decodeURIComponent(flowUtils.getUrlQuery("id"));
			var parentObj = parent.$("#"+parentId).data("data-object");
			
			var act = flowUtils.getUrlQuery("act");
			if(typeof act != 'undefined' && act == "edit") {
				var idx = decodeURIComponent(flowUtils.getUrlQuery("idx"));
				var selectedData = JSON.parse(parent.$("#"+parentId).find("tbody tr:eq("+idx+") input").val());
				$("#varName").val(selectedData.varName);
				$("#varType").val(selectedData.varType);
				$("#varInit").val(selectedData.varInit);
			}
			delete parentObj.form;
			parentObj.form = $("#form");
		});
	</script>
</body>
</html>