<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<!-- ControllerPath = "createdefineselect/sysdefineselect/sysDefineSelectController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="version" value='<c:out  value='${sysDefineSelectDTO.version}'/>' /> <input type="hidden" name="id" value='<c:out  value='${sysDefineSelectDTO.id}'/>' />
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="code_">编码:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="code_" id="code_" readonly="readonly" value='<c:out  value='${sysDefineSelectDTO.code_}'/>' /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="sign_">是否系统标识:</label></th>
					<td width="39%"><pt6:h5select css_class="form-control input-sm" name="sign_" id="sign_" title="" isNull="true" lookupCode="PLATFORM_SYS_SIGN" defaultValue='${sysDefineSelectDTO.sign_}' /></td>
					
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="sql_">sql语句:</label></th>
					<td width="39%" colspan="4"><textarea class="form-control input-sm" rows="3" readonly="readonly" name="sql_" id="sql_"><c:out value='${sysDefineSelectDTO.sql_}' /></textarea></td>
					
				</tr>
				<tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="des_">描述:</label></th>
					<td width="39%" colspan="4"><textarea class="form-control input-sm" readonly="readonly" rows="3" type="text" name="des_" id="des_"  /><c:out value='${sysDefineSelectDTO.des_}' /></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		document.ready = function () {
		parent.sysDefineSelect.formValidate($('#form'));
	};
	//form控件禁用
	setFormDisabled();
	$(document).keydown(function(event){  
		event.returnValue = false;
		return false;
	});  
	</script>
</body>
</html>