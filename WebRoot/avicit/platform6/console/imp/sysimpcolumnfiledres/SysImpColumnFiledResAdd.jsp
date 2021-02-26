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
<!-- ControllerPath = "platform6/modules/system/imp/sysimpcolumnfiledres/sysImpColumnFiledResController/operation/Add/null" -->
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
			<table class="form_commonTable">
				<tr>
																																		 																	 													<th width="10%">
						    						  	<label for="sheetid">sheetId:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="sheetid"  id="sheetid" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="columnTitle">列标题:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="columnTitle"  id="columnTitle" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="columnIndex">列序号:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="columnIndex"  id="columnIndex" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="field">字段属性:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="field"  id="field" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="fieldDesc">字段名称:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="fieldDesc"  id="fieldDesc" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="required">是否必填:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="required"  id="required" />
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="remark">备注:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="remark"  id="remark" />
													   </td>
																														   									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 																	 													<th width="10%">
						    						  	<label for="checkType">格式校验 1：数值 2：日期 3:邮箱 4：手机 5：ip地址:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="checkType"  id="checkType" />
													   </td>
															</tr>
								<tr>
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
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="sysImpColumnFiledRes_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="sysImpColumnFiledRes_closeForm">返回</a>
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
			parent.sysImpColumnFiledRes.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	        //限制保存按钮多次点击
  		 	$('#sysImpColumnFiledRes_saveForm').addClass('disabled');	
			parent.sysImpColumnFiledRes.save($('#form'),"insert");
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
			
			parent.sysImpColumnFiledRes.formValidate($('#form'));
			//保存按钮绑定事件
			$('#sysImpColumnFiledRes_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#sysImpColumnFiledRes_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																																																																																																								
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>