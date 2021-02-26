<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/monitor/apicenter/monitorapiinfo/monitorApiInfoController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="businessDomain">业务域编码:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="businessDomain" id="businessDomain" /></td>
					<th width="10%"><label for="deptName">责任部门:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="deptName" id="deptName" /></td>
				</tr>
				<tr>
					<!-- <th width="10%"><label for="appName">应用名称:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="appName" id="appName" /></td> -->
					<th width="10%"><label for="appCode">应用编码:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="appCode" id="appCode" /></td>
					<th width="10%"><label for="appVersion">应用版本:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="appVersion" id="appVersion" /></td>
				</tr>
				<!-- <tr>
					<th width="10%"><label for="appDesc">应用描述:</label></th>
					<td width="89%" colspan="3"><input class="form-control input-sm" type="text" name="appDesc" id="appDesc" /></td>
				</tr> -->
				<tr>
					<!--  -->
					<th width="10%"><label for="techSupport">技术支持:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="apiTechSupport" id="apiTechSupport" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="appVersion">swagger信息:</label></th>
					<td width="89%" colspan="3"><textarea class="form-control" rows="10" name="apiSwaggerJson">${apiSwaggerJson}</textarea></td>
				</tr>
				<!-- <tr>
					<th width="10%"><label for="appVersion">下载模板:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="appVersion" id="appVersion" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="appVersion">上传模板:</label></th>
					<td width="39%"><input type="file" id="exampleInputFile"></td>
				</tr> -->
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right">
					   <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="monitorApiInfo_saveForm">保存</a>
					   <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="monitorApiInfo_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	
	
	<script type="text/javascript">
		function closeForm() {
			parent.monitorApiInfo.closeDialog("insert");
		}
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}
			//限制保存按钮多次点击
			$('#monitorApiInfo_saveForm').addClass('disabled');
			parent.monitorApiInfo.save($('#form'), "insert");
		}

		$(document).ready(function() {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine : true,//单行显示时分秒
				closeText : '确定',//关闭按钮文案
				showButtonPanel : true,//是否展示功能按钮面板
				showSecond : false,//是否可以选择秒，默认否
				beforeShow : function(selectedDate) {
					if ($('#' + selectedDate.id).val() == "") {
						$(this).datetimepicker("setDate", new Date());
						$('#' + selectedDate.id).val('');
					}
				}
			});

			parent.monitorApiInfo.formValidate($('#form'));
			//保存按钮绑定事件
			$('#monitorApiInfo_saveForm').bind('click', function() {
				saveForm();
			});
			//返回按钮绑定事件
			$('#monitorApiInfo_closeForm').bind('click', function() {
				closeForm();
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
			initJson();
		});
		
		function initJson(){
			/* $.getJSON("avicit/platform6/monitor/apicenter/monitorapiinfo/js/js/swagger.jso", function (data){
			      var swagger = $("#swagger");
			      swagger.empty();
			      swagger.html(data);
			  }); */
		}
	</script>
</body>
</html>