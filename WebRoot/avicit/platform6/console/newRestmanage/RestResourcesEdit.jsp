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
<!-- ControllerPath = "platfrom6/tablecol/resteasyresources/resteasyResourcesController/operation/Edit/id" -->
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
			<input type="hidden" name="id" value='<c:out  value='${resteasyResourcesDTO.id}'/>' />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="restUrl">URL地址:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="restUrl" id="restUrl"
						value='<c:out  value='${resteasyResourcesDTO.restUrl}'/>' /></td>
					<th width="10%"><label for="urlDesc">地址描述:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="urlDesc" id="urlDesc"
						value='<c:out  value='${resteasyResourcesDTO.urlDesc}'/>' /></td>
				</tr>
				<tr>
					<th width="10%"><label for="orgId">所属单位:</label></th>
					<td width="39%" >
						<select class="form-control" name="orgId" id="orgId" title="" isNull="true" onchange="selectOnchang(this)"/>
					</td>
					<th width="10%"><label for="systemId">所属系统:</label></th>
					<td width="39%">
						<select class="form-control" name="systemId" id="systemId" title="" isNull="true" />
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="status">状态:</label></th>
					<td width="39%"><select class="form-control" name="status" id="status">
							<option ></option>
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
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="保存" id="resteasyResources_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="resteasyResources_closeForm">返回</a></td>
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
			parent.restResourceManage.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.restResourceManage.save($('#form'),"eidt");
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
	                $.each(data, function (index, units) {  
	                    $("#orgId").append("<option value="+units.id+">" + units.orgName + "</option>");  
	                });
	                $('#orgId').val('${resteasyResourcesDTO.orgId}');
	            },  

	            error: function (XMLHttpRequest, textStatus, errorThrown) {  
	                alert("error");  
	            }  
	        });
			$.ajax({  
	            url: 'platform/platform6/newrestmanage/controller/resteasySystemController/operation/listAll',  
	            data : {
				 	id : "${resteasyResourcesDTO.orgId}"
				},
			    type : 'post',
	            dataType: "json",  
	            success: function (data) {  
	                $.each(data, function (index, units) {  
	                    $("#systemId").append("<option value="+units.id+">" + units.systemName + "</option>");  
	                });
	                $('#systemId').val('${resteasyResourcesDTO.systemId}');
	            },  

	            error: function (XMLHttpRequest, textStatus, errorThrown) {  
	                alert("error");  
	            }  
	        });
			$('#status').val('${resteasyResourcesDTO.status}');
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.restResourceManage.formValidate($('#form'));
			//保存按钮绑定事件
			$('#resteasyResources_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#resteasyResources_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																												
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
			
			//添加验证规则：url校验
			jQuery.validator.addMethod("alnum", function(value, element){
				return this.optional(element) ||/(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?/.test(value);
			}, "请输入正确格式的url");
		});
		function selectOnchang(obj){ 
			var value = obj.options[obj.selectedIndex].value;
			$.ajax({  
	            url: 'platform/platform6/newrestmanage/controller/resteasySystemController/operation/listAll',  
	            data : {
				 	id : value
				},
			    type : 'post',
	            dataType: "json",  
	            success: function (data) { 
	            	$("#systemId").empty();
	                $.each(data, function (index, units) {  
	                    $("#systemId").append("<option value="+units.id+">" + units.systemName + "</option>");  
	                });
	                $('#systemId').val('${resteasyResourcesDTO.systemId}');
	            },  

	            error: function (XMLHttpRequest, textStatus, errorThrown) {  
	                alert("error");  
	            }  
	        });
		}
	</script>
</body>
</html>