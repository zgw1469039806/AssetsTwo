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
<!-- ControllerPath = "ims/portal/stat/mobilecommandextend/mobileCommandExtendController/operation/Edit/id" -->
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
			<input type="hidden" name="version"
				value="<c:out  value='${mobileCommandExtendDTO.version}'/>" /> <input
				type="hidden" name="id"
				value="<c:out  value='${mobileCommandExtendDTO.id}'/>" />
			<table class="form_commonTable">
				<tr style = "display:none ">
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="commandId">COMMAND_ID:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="commandId" id="commandId"
						value="<c:out  value='${mobileCommandExtendDTO.commandId}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="methodName">METHOD_NAME:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="methodName" id="methodName"
						value="<c:out  value='${mobileCommandExtendDTO.methodName}'/>" /></td>
				</tr>
				<tr>
					<th width="1%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="className">类名:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="className" id="className"
						value="<c:out  value='${mobileCommandExtendDTO.className}'/>" /></td>

					
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="保存" id="mobileCommandExtend_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="mobileCommandExtend_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		function closeForm() {
			parent.mobileCommandExtend.closeDialog("edit");
		}
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}
			//限制保存按钮多次点击
			$('#mobileCommandExtend_saveForm').addClass('disabled');
			parent.mobileCommandExtend.save($('#form'), "eidt");
		}

		$(document).ready(function() {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine : true,//单行显示时分秒
				closeText : '确定',//关闭按钮文案
				showButtonPanel : true,//是否展示功能按钮面板
				showSecond : false,//是否可以选择秒，默认否
			});

			parent.mobileCommandExtend.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mobileCommandExtend_saveForm').bind('click', function() {
				saveForm();
			});
			//返回按钮绑定事件
			$('#mobileCommandExtend_closeForm').bind('click', function() {
				closeForm();
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
		});
	</script>
</body>
</html>