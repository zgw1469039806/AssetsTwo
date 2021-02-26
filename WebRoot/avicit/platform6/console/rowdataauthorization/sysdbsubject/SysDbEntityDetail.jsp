<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "shujushouquan/sysdbsubject/sysDbSubjectController/operation/Edit/id" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id"
				value="<c:out  value='${sysDbEntityDTO.id}'/>" /> <input
				type="hidden" name="version"
				value="<c:out  value='${sysDbEntityDTO.version}'/>" /> <input
				type="hidden" name="subjectid" id="subjectid"
				value="<c:out  value='${sysDbEntityDTO.subjectid}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="20%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="tableName">表名称:</label></th>
					<td width="79%"><input class="form-control input-sm"
						type="text" name="tableName" id="tableName"
						value="<c:out  value='${sysDbEntityDTO.tableName}'/>" /></td>
				</tr>
				<tr>
					<th width="20%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="tableComments">表描述:</label></th>
					<td width="79%"><input class="form-control input-sm"
						type="text" name="tableComments" id="tableComments"
						value="<c:out  value='${sysDbEntityDTO.tableComments}'/>" /></td>
				</tr>
				<tr>
					<th width="20%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="mapperForTab">表对应mapper.xml:</label></th>
					<td width="79%"><input class="form-control input-sm"
						type="text" name="mapperForTab" id="mapperForTab"
						value="<c:out  value='${sysDbEntityDTO.mapperForTab}'/>" /></td>
				</tr>
				<tr>
					<th width="20%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="exemethods">执行方法:</label></th>
					<td width="79%"><input class="form-control input-sm"
						type="text" name="exemethods" id="exemethods"
						value="<c:out  value='${sysDbEntityDTO.exemethods}'/>" /></td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		$(document).ready(function() {
			parent.sysDbEntity.formValidate($('#form'));
		});
		//form控件禁用
		setFormDisabled();
		$(document).keydown(function(event) {
			event.returnValue = false;
			return false;
		});
	</script>
</body>
</html>