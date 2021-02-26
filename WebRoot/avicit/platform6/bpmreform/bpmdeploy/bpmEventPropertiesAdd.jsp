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
			<input type="hidden"
				name="thirdPartyDbid" id="thirdPartyDbid" value="${thirdPartyDbid}"/>
			<table class="form_commonTable">
				<tr>
					<th width="15%"><label for="name">常量名:</label></th>
					<td width="85%"><input class="form-control input-sm"
						type="text" name="name" id="name" /></td>
				</tr>
				<tr>
					<th width="15%"><label for="initExpr">常量值:</label></th>
					<td width="85%"><input class="form-control input-sm"
										   type="text" name="initExpr" id="initExpr" /></td>
				</tr>
				<tr>
					<th width="15%"><label for="orderBy">排序:</label></th>
					<td width="85%">
						<div class="input-group input-group-sm spinner"
							 data-trigger="spinner">
							<input class="form-control" type="text" name="orderBy"
								   id="orderBy"
								   data-min="-<%=Math.pow(10, 11) - Math.pow(10, -0)%>"
								   data-max="<%=Math.pow(10, 11) - Math.pow(10, -0)%>" data-step="1"
								   data-precision="0"> <span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i
										class="glyphicon glyphicon-triangle-top"></i></a> <a
								href="javascript:;" class="spin-down" data-spin="down"><i
								class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="15%"><label for="remark">描述:</label></th>
					<td width="85%"><input class="form-control input-sm"
										   type="text" name="remark" id="remark" /></td>
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
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="保存" id="bpmEventProperties_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="bpmEventProperties_closeForm">返回</a></td>
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
			parent.bpmEventProperties.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.bpmEventProperties.save($('#form'),"insert");
		}
	
		$(document).ready(function () {
			parent.bpmEventProperties.formValidate($('#form'));
			//保存按钮绑定事件
			$('#bpmEventProperties_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#bpmEventProperties_closeForm').bind('click', function(){
				closeForm();
			});
		});
	</script>
</body>
</html>