<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "avicit/elect/dynElectPerson/dynElectPersonController/operation/Add/null" -->
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
			<input type="hidden" name="electId" value="${pid}" />
			<table class="form_commonTable">
				<tr>
					<th width="15%">
						<label for="electName">选举名称:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="electName"  id="electName" />
   					</td>
					<th width="15%">
						<label for="personId">候选人id:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="personId"  id="personId" />
   					</td>
				</tr>
				<tr>
					<th>
						<label for="personName">候选人名称:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="personName"  id="personName" />
   					</td>
					<th>
						<label for="ifMark">是否加星:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="ifMark"  id="ifMark" />
   					</td>
				</tr>
				<tr>
					<th>
						<label for="personDeptName">候选人部门:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="personDeptName"  id="personDeptName" />
   					</td>
					<th>
						<label for="ruleDesc">规则描述:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="ruleDesc"  id="ruleDesc" />
   					</td>
				</tr>
				<tr>
					<th>
						<label for="att01">备用字段1:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att01"  id="att01" />
   					</td>
					<th>
						<label for="att02">备用字段2:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att02"  id="att02" />
   					</td>
				</tr>
				<tr>
					<th>
						<label for="att03">备用字段3:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att03"  id="att03" />
   					</td>
					<th>
						<label for="att04">备用字段4:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att04"  id="att04" />
   					</td>
				</tr>
				<tr>
					<th>
						<label for="att05">备用字段5:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att05"  id="att05" />
   					</td>
					<th>
						<label for="att06">备用字段6:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att06" id="att06" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
				<tr>
					<th>
						<label for="att07">备用字段7:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att07" id="att07" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="att08">备用字段8:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att08" id="att08" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
				<tr>
					<th>
						<label for="att09">备用字段9:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att09" id="att09" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="att10">备用字段10:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att10" id="att10" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
				<tr>
					<th>
						<label for="major">专业:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="major"  id="major" />
   					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="dynElectPerson_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="dynElectPerson_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		//初始化时间控件
		function initDateSelect(){
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
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		}
	
		function closeForm(){
			parent.dynElectPerson.closeDialog("insert");
		}
		
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	        //限制保存按钮多次点击
  		 	$('#dynElectPerson_saveForm').addClass('disabled').unbind("click");	
			parent.dynElectPerson.save($('#form'),"insert");
		}

        //清空日期值
        function clearCommonSelectValue(element) {
            $(element).siblings("input").val("");
        }

		$(document).ready(function () {
			initDateSelect();
			parent.dynElectPerson.formValidate($('#form'));
			//保存按钮绑定事件
			$('#dynElectPerson_saveForm').bind('click', function(){
				saveForm();
			}); 
			
			//返回按钮绑定事件
			$('#dynElectPerson_closeForm').bind('click', function(){
				closeForm();
			});
			
		});
	</script>
</body>
</html>
