<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "ys/syslookuptype/sysLookupTypeController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" />
			<table class="form_commonTable">
				<tr>
					<!-- <th width="10%"><label for="sysApplicationId">应用ID:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="sysApplicationId" id="sysApplicationId" /></td>  -->
					<th width="10%"><label for="lookupType">代码类型:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="lookupType" id="lookupType" /></td>
					<th width="10%"><label for="lookupTypeName">代码名称:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="lookupTypeName" id="lookupTypeName" /></td>
				</tr>
				<tr>
					<!-- <th width="10%"><label for="systemFlag">是否为系统初始 Y 是 N 否:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="systemFlag" id="systemFlag" /></td> -->
					
					<th width="10%"><label for="validFlag">是否有效</label></th>
					<td width="39%"><pt6:h5radio css_class="radio-inline" name="validFlag" 
						title="是否有效" canUse="0" lookupCode="PLATFORM_VALID_FLAG" defaultValue='1' /></td>
					<th width="10%"><label for="usageModifier">使用级别</label></th>
					<td width="39%"><pt6:h5select css_class="form-control input-sm" name="usageModifier" id="usageModifier" title="部门类型" isNull="true" defaultValue='1' lookupCode="PLATFORM_USAGE_MODIFIER" /></td>
				</tr>
				<tr>
				
					<!-- <th width="10%"><label for="belongModule">所属模块:</label></th> 
					<td width="39%"><input class="form-control input-sm" type="text" name="belongModule" id="belongModule" /></td>  -->
					<th width="10%"><label for="lookupTypeDesc">代码描述:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="lookupTypeDesc" id="lookupTypeDesc" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" style="padding-right: 4%;float:right;display:block;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="保存" id="sysLookupType_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="sysLookupType_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
			function closeForm(){
			parent.sysLookupType.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.sysLookupType.save($('#form'),"insert");
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
			
			parent.sysLookupType.formValidate($('#form'));
			//保存按钮绑定事件
			$('#sysLookupType_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#sysLookupType_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																																				
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>