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
<!-- ControllerPath = "ys/sysprofileoption/sysProfileOptionController/operation/Edit/id" -->
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
				<input type="hidden" name="id" value='<c:out  value='${sysProfileOptionValueDTO.id}'/>' />
				<input type="hidden" name="version" value='<c:out  value='${sysProfileOptionValueDTO.version}'/>' />
				<input type="hidden" name="sysProfileOptionsId" value='<c:out  value='${sysProfileOptionValueDTO.sysProfileOptionsId}'/>' />
				<table class="form_commonTable">
					<tr>
						<th width="10%"><label for="profileLevelCode">级别:</label></th>
						<td width="39%"><select class="form-control input-sm" type="text" name="profileLevelCode" id="profileLevelCode">
						<option value="">请选择</option>
						</select></td>
						<th width="10%"><label for="levelValueAlias">级别值</label></th>
						<td width="39%">
							<div class="input-group  input-group-sm">
								<input class="form-control input-sm" type="hidden" name="levelValue" id="levelValue" value='<c:out  value='${sysProfileOptionValueDTO.levelValue}'/>'/>
								<input class="form-control input-sm" type="text" name="levelValueAlias" id="levelValueAlias" value='<c:out  value='${sysProfileOptionValueDTO.levelValueAlias}'/>' />
								<span class="input-group-addon"> <i class="glyphicon glyphicon-equalizer"></i>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<th width="10%"><label for="profileOptionValue">配置文件值:</label></th>
						<td width="39%"><input class="form-control input-sm" type="text" name="profileOptionValue" id="profileOptionValue" value='<c:out  value='${sysProfileOptionValueDTO.profileOptionValue}'/>'/>
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
						class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
						title="保存" id="sysProfileOptionValue_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="sysProfileOptionValue_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script src="avicit/platform6/console/profile/js/profileCommonSelect.js" type="text/javascript"></script>
	<script type="text/javascript">
			function closeForm(){
			parent.sysProfileOptionValue.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	          $("#sysProfileOptionsId").val(parent.sysProfileOptionValue.pid);
			  parent.sysProfileOptionValue.save($('#form'),"eidt");
		}
	
		document.ready = function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			var profileLevelCodeOption =  parent.sysProfileOption.getOption();
			for(var i = 0; i < profileLevelCodeOption.length; i++){
				if('<c:out  value='${sysProfileOptionValueDTO.profileLevelCode}'/>' ==profileLevelCodeOption[i].key ){
					$("#profileLevelCode").append("<option selected=\"true\" value=\""+profileLevelCodeOption[i].key+"\">"+profileLevelCodeOption[i].name +" </option>");
				}else{
					$("#profileLevelCode").append("<option value=\""+profileLevelCodeOption[i].key+"\">"+profileLevelCodeOption[i].name +" </option>");
				}
			}
			
			$("#profileLevelCode").on('change', function(e){
				$("#levelValue").val("");
				$("#profileOptionValue").val("");
				$("#levelValueAlias").val("");
			});
			
			$("#levelValueAlias").on('focus', function(e) {
				var code = $( "select#profileLevelCode option:checked" ).val();
				if(code != null && code != ""){
					if(code == "1"){
						new ProfileCommonSelect({
							type : 'siteSelect',
							idFiled : 'levelValue',
							textFiled : 'levelValueAlias'
						});
						this.blur();
					}else if(code == "2"){
						new ProfileCommonSelect({
							type : 'appSelect',
							idFiled : 'levelValue',
							textFiled : 'levelValueAlias'
						});
						this.blur();
					}else if(code == "3"){
						new H5CommonSelect({
							type : 'roleSelect',
							idFiled : 'levelValue',
							textFiled : 'levelValueAlias'
						});
						this.blur();
					}else if(code == "4"){
						new H5CommonSelect({
							type : 'userSelect',
							idFiled : 'levelValue',
							textFiled : 'levelValueAlias'
						});
						this.blur();
					}else if(code == "5"){
						new H5CommonSelect({
							type : 'deptSelect',
							idFiled : 'levelValue',
							textFiled : 'levelValueAlias'
						});
						this.blur();
					}
				}else{
					layer.msg('请先选择级别！');
				}
				this.blur();
			});
			
			parent.sysProfileOptionValue.formValidate($('#form'));
			//保存按钮绑定事件
			$('#sysProfileOptionValue_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#sysProfileOptionValue_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																														
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		};
	</script>
</body>
</html>