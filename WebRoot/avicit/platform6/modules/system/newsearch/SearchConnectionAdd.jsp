<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
<!-- ControllerPath = "platfrom6/tablecol/searchconnection/searchConnectionController/operation/Add/null" -->
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
					<th width="10%"><label for="connectionName">数据库名称:</label></th>
					<td width="88%"><input class="form-control input-sm"
						type="text" name="connectionName" id="connectionName" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="connectionUrl">数据库地址:</label></th>
					<td width="88%"><input class="form-control input-sm"
						type="text" name="connectionUrl" id="connectionUrl" placeholder="jdbc:oracle:thin:@192.168.0.1:1521:ORCL"/></td>
				</tr>
				<tr>
					<th width="10%"><label for="connectionUsername">数据库用户:</label></th>
					<td width="88%"><input class="form-control input-sm"
						type="text" name="connectionUsername" id="connectionUsername" />
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="connectionPassword">数据库密码:</label></th>
					<td width="88%"><input class="form-control input-sm"
						type="text" name="connectionPassword" id="connectionPassword" />
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="connectionDriver">数据库驱动:</label></th>
					<td width="88%" colspan="3">
	                    <pt6:h5select css_class="form-control input-sm" name="connectionDriver" id="connectionDriver" title="" isNull="true" lookupCode="PLATFORM_DATASOURCE_DRIVER" />
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
					<td width="50%" style="padding-right: 4%;float:right;display:block;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="保存" id="searchConnection_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="searchConnection_closeForm">返回</a></td>
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
			parent.searchConnection.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.searchConnection.save($('#form'),"insert");
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
			
			parent.searchConnection.formValidate($('#form'));
			//保存按钮绑定事件
			$('#searchConnection_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#searchConnection_closeForm').bind('click', function(){
				closeForm();
			});
			
																																							
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>