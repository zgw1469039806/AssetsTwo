<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<!-- ControllerPath = "assets/device/assetssdequipcollect/assetsSdequipCollectController/operation/sub/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" />
			<input type="hidden" name="levelUpId" id="levelUpId"/>
			<table class="form_commonTable">
				<tr>
																																				   									 																							 																									<th width="10%">
						    						  	<label for="name">供应商名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="name"  id="name" />
													   </td>
													 					    					   									 																							 																									<th width="10%">
						    						  	<label for="address">供应商地址:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="address"  id="address" />
													   </td>
													 					    					   									 																							 																									<th width="10%">
						    						  	<label for="contact">联系人:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="contact"  id="contact" />
													   </td>
													 					    					   									 																							 																									<th width="10%">
						    						  	<label for="contactNumber">联系电话:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="contactNumber"  id="contactNumber" />
													   </td>
															</tr>
								<tr>
													 					    					   									 																							 																									<th width="10%">
						    						  	<label for="businessScope">经营范围:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="businessScope"  id="businessScope" />
													   </td>
													 					    					   									 									 									 									 									 																							 																									<th width="10%">
						    						  	<label for="status">供应商状态：0:正常状态 2:停用:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="status"  id="status" />
													   </td>
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
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存" id="assetsSupplier_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsSupplier_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
			function closeForm(){
			parent.assetsSupplier.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	          $("#levelUpId").val(parent.assetsSupplier.pid);
	          //限制保存按钮多次点击
   			  $('#assetsSupplier_saveForm').addClass('disabled');
			  parent.assetsSupplier.save($('#form'),"insert");
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
			
			parent.assetsSupplier.formValidate($('#form'));
			//保存按钮绑定事件
			$('#assetsSupplier_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#assetsSupplier_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																																																																																																																			
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>