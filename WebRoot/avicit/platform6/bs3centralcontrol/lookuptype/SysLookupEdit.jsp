<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<!-- ControllerPath = "ys/syslookuptype/sysLookupTypeController/operation/Edit/id" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value='<c:out  value='${sysLookupDTO.id}'/>'/>
			<input type="hidden" name="version" value='<c:out  value='${sysLookupDTO.version}'/>'/>
			<input type="hidden" name="sysLookupTypeId" value='<c:out  value='${sysLookupDTO.sysLookupTypeId}'/>'/>
				 <table class="form_commonTable">
				<tr>
																						  																					  						     						  												  						     						  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="displayOrder">显示顺序:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="displayOrder" id="displayOrder" value='<c:out  value='${sysLookupDTO.displayOrder}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																																								   							  						     						  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="lookupCode">明细代码:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="lookupCode"  id="lookupCode" value='<c:out  value='${sysLookupDTO.lookupCode}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   							  						     						  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="validFlag">是否有效 1代表有效,0代表无效 默认为1:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="validFlag"  id="validFlag" value='<c:out  value='${sysLookupDTO.validFlag}'/>'/>
																	   </td>
																																								   							  						     						  												  													    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="systemFlag">是否是系统初始值 Y 是 N 否:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="systemFlag"  id="systemFlag" value='<c:out  value='${sysLookupDTO.systemFlag}'/>'/>
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
					<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存" id="sysLookup_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="sysLookup_closeForm">返回</a>
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
			parent.sysLookup.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	          $("#sysLookupTypeId").val(parent.sysLookup.pid);
			  parent.sysLookup.save($('#form'),"eidt");
		}
	
		document.ready = function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.sysLookup.formValidate($('#form'));
			//保存按钮绑定事件
			$('#sysLookup_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#sysLookup_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																	
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		};
	</script>
</body>
</html>