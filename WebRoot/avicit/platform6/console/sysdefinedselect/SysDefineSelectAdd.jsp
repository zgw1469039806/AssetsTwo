<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "createdefineselect/sysdefineselect/sysDefineSelectController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" id="id"/>
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="code_">编码:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="code_" id="code_" /></td>
					<th width="10%"><label for="sign_">是否系统标识:</label></th>
					<td width="39%"><pt6:h5select css_class="form-control input-sm" name="sign_" id="sign_" title="" isNull="true" lookupCode="PLATFORM_SYS_SIGN" /></td>
					
				</tr>
				<tr>
					<th width="10%"><label for="sql_">sql语句:</label></th>
					<td width="39%" colspan="4"><textarea  class="form-control input-sm" rows="3" name="sql_" id="sql_"></textarea></td>
				</tr>
				<tr>
				<th width="10%"><label for="des_">描述:</label></th>
					<td width="39%" colspan="4"><textarea class="form-control input-sm" rows="3" type="text" name="des_" id="des_" /></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%; float: right; display: block;" align="right"><a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="保存" id="sysDefineSelect_saveForm">保存</a> <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="sysDefineSelect_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
			function closeForm(){
			parent.sysDefineSelect.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.sysDefineSelect.save($('#form'),"insert");
		}
	
		$(document).ready(function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
				beforeShow: function(selectedDate) {
					if($('#'+selectedDate.id).val()==""){
						$(this).datetimepicker("setDate", new Date());
						$('#'+selectedDate.id).val('');
					}
				}
			});
			//编码唯一性校验
			jQuery.validator.addMethod("validateCode", function(value, element, param) {
				var mark = 1;
				var data = {
					'code' : value,
					'id' : $('#id').val()
				};
				$.ajax({
					url : 'console/sysdefinedselect/operation/validateCode',
					data : data,
					type : 'post',
					dataType : 'json',
					async : false,
					success : function(r) {
						if (r.flag == "success") {
							mark = 0;
						}
					}
				});
				if (mark == 1) {
					return false;
				} else {
					return true;
				}
			}, "编码已存在，请重新填写");	
			parent.sysDefineSelect.formValidate($('#form'));
			//保存按钮绑定事件
			$('#sysDefineSelect_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#sysDefineSelect_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																											
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>