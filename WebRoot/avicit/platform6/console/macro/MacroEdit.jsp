<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="version"
				value='<c:out  value='${macroDTO.version}'/>' /> <input
				type="hidden" name="id" value='<c:out  value='${macroDTO.id}'/>' />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="macroName">宏名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="macroName" id="macroName"
						value='<c:out  value='${macroDTO.macroName}'/>' /></td>
					<th width="10%"><label for="macroExp">宏表达式：</label></th>
					<td width="39%"><input class="form-control input-sm"
						name="macroExp" id="macroExp"
						value='<c:out  value='${macroDTO.macroExp}'/>'></input></td>


				</tr>
				<tr>
					<th width="10%"><label for="macroType">宏类型:</label></th>
					<td width="19%"><select name="macroType"
						class="form-control input-sm" id="macroType" >
						<option selected="selected" disabled="disabled"  style='display: none' value=''></option> 
							<c:forEach var="value" items="${macroTypes}">
								<option value="${value}">${value}</option>
							</c:forEach>
					</select></td>
					<th width="10%"><label for="macroImpl">实现类:</label></th>
					<td width="39%"><input class="form-control input-sm"
						name="macroImpl" id="macroImpl"
						value='<c:out  value='${macroDTO.macroImpl}'/>' /></td>

				</tr>
				<tr>
					<th width="10%"><label for="macroDesc">宏描述:</label></th>
					<td width="39%"><textarea class="form-control input-sm"
							rows="3" name="macroDesc" id="macroDesc"><c:out
								value='${macroDTO.macroDesc}' />
					</textarea></td>
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
					<td width="50%"
						style="padding-right: 4%; float: right; display: block;"
						align="right"><a href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="保存" id="macro_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="macro_closeForm">返回</a></td>
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
			parent.macro.closeDialog("edit");
		}
		function saveForm(){ 
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        } 
			  parent.macro.save($('#form'),"eidt");
		}
	
		$(document).ready(function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.macro.formValidate($('#form'));
			//保存按钮绑定事件
			$('#macro_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#macro_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																														
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
		 $(function () {  
		    	$("#macroType").find("option[value='${macroDTO.macroType}']").attr("selected","selected");
		    }); 
	</script>
</body>
</html>