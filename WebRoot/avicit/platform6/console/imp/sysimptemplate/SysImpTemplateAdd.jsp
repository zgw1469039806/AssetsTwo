<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<head>
<!-- ControllerPath = "demo/demoreception/demoReceptionController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="code">编码:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="code" id="code" /></td>
					<th width="10%"><label for="name">名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="name" id="name" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="swfl">事务控制方式</label></th>
					<td width="39%"><pt6:h5select
							css_class="form-control input-sm" name="swfl" id="swfl" title=""
							isNull="true" lookupCode="SWFL_CONTROL" /></td>
					<th width="10%"><label for="bz">描述:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="bz" id="bz" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="userClass">用户自定义处理类:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="userClass" id="userClass" /></td>
				</tr>
				<tr>
					<th><label for="attachment">附件</label></th>
					<td colspan="<%=2 * 2 - 1%>">
						<div id="attachment"></div>
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
						href="javascript:void(0);" title="保存" id="saveButton"
						class="btn btn-primary form-tool-btn typeb btn-sm">保存</a> <a
						href="javascript:void(0);" title="返回" id="returnButton"
						class="btn btn-grey form-tool-btn btn-sm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		// 关闭Dialog
		function closeForm() {
			parent.sysImpTemplate.closeDialog('insert');
		}

		// 保存表单
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}

			//验证附件密级
			var files = $('#attachment').uploaderExt('getUploadFiles');
			for (var i = 0; i < files.length; i++) {
				var name = files[i].name;
				var secretLevel = files[i].secretLevel;
				//这里验证密级
			}
			//限制保存按钮多次点击
			//$('#saveButton').addClass('disabled');
			parent.sysImpTemplate.save($('#form'), callback);
		}

		//上传附件
		function callback(id) {
			$("#id").val(id);
			$('#attachment').uploaderExt('doUpload', id);
		}
		//附件上传完后执行
		function afterUploadEvent() {
			parent.sysImpTemplate.closeDialog('insert');
		}

		// 加载完后初始化
		$(document).ready(function() {
			//初始化日期控件
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
			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);

			//初始化附件上传组件
			$('#attachment').uploaderExt({
				secretLevel : 'PLATFORM_FILE_SECRET_LEVEL',
				fileNumLimit: 1,
				fileCategoryList: ['xls', 'xlsx'],
				afterUpload : afterUploadEvent
			});

			//绑定表单验证规则
			parent.sysImpTemplate.formValidate($('#form'));

			//保存按钮绑定事件
			$('#saveButton').bind('click', function() {
				saveForm();
			});

			//返回按钮绑定事件
			$('#returnButton').bind('click', function() {
				closeForm();
			});

		});
	</script>
</body>
</html>