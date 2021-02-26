<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.quartz.dto.Job"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head><% 
String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div region="center" border="false" style="padding-right: 20px;">
   <form id="form" fit="true">
		<table class="form_commonTable">
			<tr>
				<th><label for="name">名称:</label></th>
				<td><input id="name" name="name" class="form-control input-sm"/></td>
			</tr>
			<tr>
				<th><label for="description">描述:</label></th>
				<td><textarea id="description" class="form-control input-sm" name="description" rows="3" ></textarea></td>
			</tr>
		</table>
	</form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存" id="sysJobCalendar_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="sysJobCalendar_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
</body>
<script type="text/javascript">
function closeForm(){
	parent.sysJobCalendar.closeDialog("insert");
}
function saveForm(){
	var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
	 parent.sysJobCalendar.save($('#form'),"insert");
}
$(document).ready(function () {
	parent.sysJobCalendar.formValidate($('#form'));
	//保存按钮绑定事件
	$('#sysJobCalendar_saveForm').bind('click', function(){
		saveForm();
	}); 
	//返回按钮绑定事件
	$('#sysJobCalendar_closeForm').bind('click', function(){
		closeForm();
	});
});

</script>
</html>
