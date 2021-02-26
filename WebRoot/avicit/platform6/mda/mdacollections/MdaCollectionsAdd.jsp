<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<% 
String importlibs = "common,table,form";	
%>
<%
String datatime = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
String datetime = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); 
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/mda/mdacollections/mdaCollectionsController/operation/Add/null" -->
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
						    						<th>   	<label for="collectionName"><i class="required">*</i>索引库名称:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm required" style="color: black;" type="text" name="collectionName"   id="name" />
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="createtime">创建时间:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="createtime" id="createtime" value="<%=datetime %>" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="enabletime">启用时间:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="enabletime" id="enabletime"  value="<%=datetime %>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="disabletime">停用时间:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="disabletime" id="disabletime" value="<%=datetime %>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="status">状态:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="true" lookupCode="MDA_STATUS" defaultValue="1" />
						    						   </td>
																														   									 						</tr>
					</table>
			</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="mdaCollections_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="mdaCollections_closeForm">返回</a>
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
			parent.mdaCollections.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.mdaCollections.save($('#form'),"insert");
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
			
			parent.mdaCollections.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mdaCollections_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#mdaCollections_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																				
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>