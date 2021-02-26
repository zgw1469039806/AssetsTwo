<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
<!-- ControllerPath = "platfrom6/tablecol/resteasysystem/resteasySystemController/operation/Edit/id" -->
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
			<input type="hidden" name="id"
				value='<c:out  value='${resteasyUserDTO.id}'/>' /> 
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="userName">用户名:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="userName" id="userName"
						value='<c:out  value='${resteasyUserDTO.userName}'/>' /></td>
					<th width="10%"><label for="userPassword">用户密码:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="password" name="userPassword" id="userPassword"
						value='<c:out  value='${resteasyUserDTO.userPassword}'/>' /></td>
				</tr>
				<tr>
					<th width="10%" style="display:none"><label for="systemId">所属系统:</label></th>
					<td width="39%" style="display:none">
						<select class="form-control" name="systemId" id="systemId" title="" isNull="true" />
					</td>
					<th width="10%"><label for="type">是否授权:</label></th>
					<td width="39%"><select class="form-control" name="type" id="type">
						<option value="0">是</option>
						<option value="1">否</option>
					</select></td>
					<th width="10%"><label for="status">状态:</label></th>
					<td width="39%"><select class="form-control" name="status" id="status">
						<option value="1">有效</option>
						<option value="0">无效</option>
					</select></td>
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
						class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
						title="保存" id="resteasyUser_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="resteasyUser_closeForm">返回</a></td>
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
			parent.resteasyUser.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.resteasyUser.save($('#form'),"eidt");
		}
	
		document.ready = function () {
			$.ajax({  
	            url: 'platform/platform6/newrestmanage/controller/resteasySystemController/operation/listAll',  
	            data : {
				 	id : ""
				},
			    type : 'post',
	            dataType: "json",  
	            success: function (data) {  
	                $.each(data, function (index, units) {  
	                    $("#systemId").append("<option value="+units.id+">" + units.systemName + "</option>");  
	                });
	                $('#systemId').val('${resteasyUserDTO.systemId}');
	            },  

	            error: function (XMLHttpRequest, textStatus, errorThrown) {  
	                alert("error");  
	            }  
	        });
			$("#type").val('${resteasyUserDTO.type}');
			$("#status").val('${resteasyUserDTO.status}');
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.resteasyUser.formValidate($('#form'));
			//保存按钮绑定事件
			$('#resteasyUser_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#resteasyUser_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																		
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		};
	</script>
</body>
</html>