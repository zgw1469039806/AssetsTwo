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
<!-- ControllerPath = "assets/device/documentpackage/documentPackageController/operation/Edit/id" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${documentPackageDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${documentPackageDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																																																																												 <table class="form_commonTable">
				<tr>
																																											 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdBy">创建人:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="createdBy"  id="createdBy" value="<c:out  value='${documentPackageDTO.createdBy}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByDept">创建部门:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="createdByDept"  id="createdByDept" value="<c:out  value='${documentPackageDTO.createdByDept}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="creationDate">创建时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="creationDate" id="creationDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${documentPackageDTO.creationDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="packageName">文档包名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="packageName"  id="packageName" value="<c:out  value='${documentPackageDTO.packageName}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="packageDescribe">文档包描述:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="packageDescribe"  id="packageDescribe" value="<c:out  value='${documentPackageDTO.packageDescribe}'/>"/>
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
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存" id="documentPackage_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="documentPackage_closeForm">返回</a>
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
			parent.documentPackage.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            $(isValidate.errorList[0].element).focus();
	            return false;
	        }
	        //限制保存按钮多次点击
   			$('#documentPackage_saveForm').addClass('disabled').unbind("click");
			parent.documentPackage.save($('#form'),"eidt");
		}
	
		document.ready = function () {
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
			
			parent.documentPackage.formValidate($('#form'));
			//保存按钮绑定事件
			$('#documentPackage_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#documentPackage_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																																																																																																					
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		};
	</script>
</body>
</html>