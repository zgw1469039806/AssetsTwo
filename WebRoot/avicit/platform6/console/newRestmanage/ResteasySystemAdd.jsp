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
<!-- ControllerPath = "platfrom6/tablecol/resteasysystem/resteasySystemController/operation/Add/null" -->
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
					<th width="10%"><label for="systemName">系统名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="systemName" id="systemName" /></td>
					<th width="10%"><label for="orgId">所属单位:</label></th>
					<td width="39%"  colspan="3">
						<select class="form-control" name="orgId" id="orgId" title="" isNull="true" />
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="systemDesc">系统描述:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="systemDesc" id="systemDesc" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="status">系统状态:</label></th>
					<td width="39%"  colspan="3">
						<select class="form-control" name="status" id="status">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
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
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn  typeb btn-sm" role="button"
						title="保存" id="resteasySystem_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="resteasySystem_closeForm">返回</a></td>
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
			parent.resteasySystem.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.resteasySystem.save($('#form'),"insert");
		}
	
		$(document).ready(function () {
			$.ajax({  
	            url: 'platform/platfrom6/newrestmanage/controller/resteasyOrgController/operation/listAll',  
	            data : {
				 	id : ""
				},
			    type : 'post',
	            dataType: "json",  
	            success: function (data) { 
	            	$("#orgId").append("<option>" + "</option>");
	                $.each(data, function (index, units) {  
	                    $("#orgId").append("<option value="+units.id+">" + units.orgName + "</option>");  
	                });  
	            },  

	            error: function (XMLHttpRequest, textStatus, errorThrown) {  
	                alert("error");  
	            }  
	        }); 
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
			
			parent.resteasySystem.formValidate($('#form'));
			//保存按钮绑定事件
			$('#resteasySystem_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#resteasySystem_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																				
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>