<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3 class="modal-title">
			<strong> 设置布局 </strong>
		</h3>
	</div>
	<div class="modal-body"><div id="layoutContent"></div></div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">
			关闭</button>
		<button type="button" class="btn btn-primary" onclick="saveLayout('portal_area');">保存</button>
	</div>
</body>
</html>