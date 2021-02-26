<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>错误详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="version" value="<c:out  value='${sysDataPermissionsLogDTO.version}'/>" />
			<input type="hidden" name="id" value="<c:out  value='${sysDataPermissionsLogDTO.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="2%" style="word-break: break-all; word-warp: break-word;">
						<label for="beforeSql">错误信息:</label>
					</th>
					<td width="35%" style="padding-top: 0px;">
						<textarea class="form-control input-sm" rows="20" name="beforeSql" id="beforeSql" readonly="readonly"><c:out  value='${sysDataPermissionsLogDTO.exceptionMsg}'/></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		document.ready = function() {
			
		};
		//form控件禁用
		setFormDisabled();
		$(document).keydown(function(event) {
			event.returnValue = false;
			return false;
		});
	</script>
</body>
</html>