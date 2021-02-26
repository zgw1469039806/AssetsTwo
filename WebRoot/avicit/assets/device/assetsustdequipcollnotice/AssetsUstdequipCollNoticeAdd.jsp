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
<!-- ControllerPath = "assets/device/assetsustdequipcollnotice/assetsUstdequipCollNoticeController/operation/Add/null" -->
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
						    						  	<label for="noticeNo">单号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="noticeNo"  id="noticeNo" />
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="authorAlias">起草人:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="author" name="author">
							      <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" name="authorAlias">
							      <span class="input-group-addon">
							           <i class="glyphicon glyphicon-user"></i>
							       </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="deptAlias">起草单位:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="dept" name="dept">
							      <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" name="deptAlias" >
							      <span class="input-group-addon">
							        <i class="glyphicon glyphicon-equalizer"></i>
							      </span>
						        </div>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="releasedate">日期:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="releasedate" id="releasedate" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="tel">联系电话:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="tel"  id="tel" />
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deadline">部门上报截至日期:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="deadline" id="deadline" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="noticeYear">年度:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="noticeYear"  id="noticeYear" />
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="title">标题:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="title"  id="title" />
													   </td>
															</tr>
								<tr>
																		   									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 																	 																									<th width="10%">
						    						  	<label for="createdByDept">申请人部门:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="createdByDept"  id="createdByDept" />
													   </td>
																		   									 									 									 									 									 									 						</tr>
					</table>
			</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存" id="assetsUstdequipCollNotice_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsUstdequipCollNotice_closeForm">返回</a>
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
			parent.assetsUstdequipCollNotice.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	        //限制保存按钮多次点击
   			$('#assetsUstdequipCollNotice_saveForm').addClass('disabled');
			parent.assetsUstdequipCollNotice.save($('#form'),"insert");
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
			
			parent.assetsUstdequipCollNotice.formValidate($('#form'));
			//保存按钮绑定事件
			$('#assetsUstdequipCollNotice_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#assetsUstdequipCollNotice_closeForm').bind('click', function(){
				closeForm();
			});
			
																																														$('#authorAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'author',textFiled:'authorAlias'});
					    this.blur();
					    nullInput(e);
					}); 
																								$('#deptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'dept',textFiled:'deptAlias'});
					    this.blur();
					    nullInput(e);
					});
			    																																																																																																																																																																																																									
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>