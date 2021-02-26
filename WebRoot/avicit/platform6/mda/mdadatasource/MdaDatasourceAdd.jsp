<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<% 
String importlibs = "common,form";
%>
<% 
String datetime=new SimpleDateFormat("yyyy-MM-dd").format(new Date()); 
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/mda/mdadatasource/mdaDatasourceController/operation/Add/null" -->
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
														<!--===========数据源名称添加校验============  id="useridAlias" -->																 									 									 									 									 									 									 									 																	 													<th width="10%">
						    						  	<label for="name"><i class="required">*</i>数据源名称:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm required" style="color: black;" type="text" name="name"  id="name" />
													   </td>
																														   									 																	 													<th width="10%">
						    						    <label for="useridAlias">用户:</label></th>
						    							<td width="39%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="userid" name="userid" value="${CURRENT_LOGINUSER.id }">
							      <input readonly="readonly" class="form-control" placeholder="请选择用户" type="text" name="useridAlias" value="${CURRENT_LOGINUSER.no }">
							      <span class="input-group-addon">
							           <i class="glyphicon glyphicon-user"></i>
							       </span>
							    </div>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="createtime">创建时间:</label></th>
						    							<td width="39%">
														    <div class="input-group input-group-sm">
									                	      <input class="form-control date-picker" type="text" name="createtime" id="createtime" value="<%=datetime %>" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									              	     <input class="form-control date-picker"  type="hidden" name="lastmodifytime" id="lastmodifytime" value="<%=datetime %>" />
									              	        </div>
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="status">状态:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="true" lookupCode="MDA_STATUS" defaultValue="1" />
						    						   </td>
															</tr>
								<%-- <tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="status">状态:</label></th>
						    							<td width="39%">
															<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="true" lookupCode="MDA_STATUS" />
						    						   </td>
																														   									 						</tr> --%>
					</table>
			</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存" id="mdaDatasource_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="mdaDatasource_closeForm">返回</a>
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
			parent.mdaDatasource.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.mdaDatasource.save($('#form'),"insert");
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
			
			parent.mdaDatasource.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mdaDatasource_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#mdaDatasource_closeForm').bind('click', function(){
				closeForm();
			});
			
			$('#useridAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'userid',textFiled:'useridAlias'});
					    this.blur();
					}); 
																																																																						
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>