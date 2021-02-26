<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "ims/portal/stat/mobilecommandinfo/mobileCommandInfoController/operation/Edit/id" -->
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
				value="<c:out  value='${mobileCommandInfoDTO.version}'/>" /> <input
				type="hidden" name="id"
				value="<c:out  value='${mobileCommandInfoDTO.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word; display: none"><label
						for="serviceId">服务id外键:</label></th>
					<td width="39%" style="display: none"><input
						class="form-control input-sm" type="text" name="serviceId"
						id="serviceId"
						value="<c:out  value='${mobileCommandInfoDTO.serviceId}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="methodUrl">方法URL地址:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="methodUrl" id="methodUrl"
						value="<c:out  value='${mobileCommandInfoDTO.methodUrl}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="methodName">方法名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="methodName" id="methodName"
						value="<c:out  value='${mobileCommandInfoDTO.methodName}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="methodType">方法类型:</label></th>
					<td width="39%"><select class="form-control input-sm"
						name="methodType" id="methodType"
						data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel"
						value="<c:out  value='${mobileCommandInfoDTO.methodType}'/>" />
						<option value="GET" <c:if test="${mobileCommandInfoDTO.methodType == 'GET'}">selected</c:if>>GET</option>
						<option value="POST" <c:if test="${mobileCommandInfoDTO.methodType == 'POST'}">selected</c:if>>POST</option>

					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="methodShowName">方法备注:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="methodShowName" id="methodShowName"
						value="<c:out  value='${mobileCommandInfoDTO.methodShowName}'/>" />
					</td>
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
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="保存" id="mobileCommandInfo_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="mobileCommandInfo_closeForm">返回</a></td>
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
			parent.mobileCommandInfo.closeDialog("edit");
		}
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}
			//限制保存按钮多次点击
			$('#mobileCommandInfo_saveForm').addClass('disabled');
			parent.mobileCommandInfo.save($('#form'), "eidt");
		}

		document.ready = function() {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine : true,//单行显示时分秒
				closeText : '确定',//关闭按钮文案
				showButtonPanel : true,//是否展示功能按钮面板
				showSecond : false,//是否可以选择秒，默认否
			});

			parent.mobileCommandInfo.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mobileCommandInfo_saveForm').bind('click', function() {
				saveForm();
			});
			//返回按钮绑定事件
			$('#mobileCommandInfo_closeForm').bind('click', function() {
				closeForm();
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
		};
	</script>
</body>
</html>