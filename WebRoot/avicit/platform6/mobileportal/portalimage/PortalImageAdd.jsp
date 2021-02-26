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
			<input type="hidden" name="id" value = '${versionId}'/>
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="imageName">图片名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="imageName" id="imageName" /></td>

					<th width="10%"><label for="imageOrder">显示顺序:</label></th>
					<td width="39%">
						<div class="input-group input-group-sm spinner"
							data-trigger="spinner">
							<input class="form-control" type="text" name="imageOrder"
								id="imageOrder" data-min="0"
								data-max="<%=Math.pow(10, 16) - 1%>" data-step="1"
								data-precision="0"> <span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i
									class="glyphicon glyphicon-triangle-top"></i></a> <a
								href="javascript:;" class="spin-down" data-spin="down"><i
									class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>
				</tr>
				<tr style="display:none;">
					<th width="10%"><label for="imagePath">图片路径:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="imagePath" id="imagePath" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="attachment">附件</label></th>
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
		var versionId = '${versionId}';
		function closeForm() {
			parent.portalImage.closeDialog('insert');
		}
		function uploadForm() {
			if(document.getElementById("attachment").children[1].firstChild.children.length == 0){ 
				layer.alert('请上传附件！', {
					icon : 7,
					title : "警告",
					area : [ '400px', '' ]
				});
				return;
			}

			//验证附件密级
			var files = $('#attachment').uploaderExt('getUploadFiles');
			for (var i = 0; i < files.length; i++) {
				var name = files[i].name;
				var secretLevel = files[i].secretLevel;
				//这里验证密级
			}
			
			callback(form.id.value);
		}

		// 保存表单
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
				
			}
			
			//限制保存按钮多次点击
			$('#saveButton').addClass('disabled');
			parent.portalImage.save($('#form'), versionId);
			closeForm();
			
		}

		//上传附件
		function callback(id) {
			$("#id").val(id);
			$('#attachment').uploaderExt('doUpload', id);
		}
		//附件上传完后执行
		function afterUploadEvent() {
			saveForm();
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
				saveType:'MobileDisk',
				secretLevel : 'PLATFORM_FILE_SECRET_LEVEL',
                tableName : 'portal_image',
				fileNumLimit: 1,
				afterUpload : afterUploadEvent,
				accept : { title: 'Images',
				       extensions: 'jpg,jpeg,png',
				       mimeTypes: 'image/jpg,image/jpeg,image/png'}
			});


			//绑定表单验证规则
			parent.portalImage.formValidate($('#form'));

			//保存按钮绑定事件
			$('#saveButton').bind('click', function() {
				uploadForm();
			});

			//返回按钮绑定事件
			$('#returnButton').bind('click', function() {
				closeForm();
			});

		});
	</script>
</body>
</html>