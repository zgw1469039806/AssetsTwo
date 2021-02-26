<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value="<c:out value='${dynTemItemDTO.id}'/>" />
			<input type="hidden" name="version" value="<c:out  value='${dynTemItemDTO.version}'/>"/>
			<table class="form_commonTable">
				<tr>
					<th width="15%">
						<label for="temId">模板表ID:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="temId"  id="temId" value="<c:out value='${dynTemItemDTO.temId}'/>">
   					</td>
					<th width="15%">
						<label for="tiUserName">候选人姓名:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="tiUserName"  id="tiUserName" value="<c:out value='${dynTemItemDTO.tiUserName}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="tiUserDept">候选人部门:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="tiUserDept"  id="tiUserDept" value="<c:out value='${dynTemItemDTO.tiUserDept}'/>">
   					</td>
					<th>
						<label for="tiOpinion">候选人意见:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="tiOpinion" id="tiOpinion" data-min="-9999999999999999999999" data-max="9999999999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynTemItemDTO.tiOpinion}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="tiShouldInvestNum">应投数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="tiShouldInvestNum" id="tiShouldInvestNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynTemItemDTO.tiShouldInvestNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="tiActualInvestNum">实投数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="tiActualInvestNum" id="tiActualInvestNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynTemItemDTO.tiActualInvestNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="tiLoginNum">登陆数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="tiLoginNum" id="tiLoginNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynTemItemDTO.tiLoginNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="tiSceneNum">实到数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="tiSceneNum" id="tiSceneNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynTemItemDTO.tiSceneNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="tiStartDate">开始时间:</label></th>
					<td>
						<div class="input-group input-group-sm">
							<input class="form-control date-picker" type="text" name="tiStartDate" id="tiStartDate" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${dynTemItemDTO.tiStartDate}'/>">
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							<span class="input-group-addon"  onclick="clearCommonSelectValue(this)"><i class="fa fa-close"></i></span>
						</div>
   					</td>
					<th>
						<label for="tiEndDate">结束时间:</label></th>
					<td>
						<div class="input-group input-group-sm">
							<input class="form-control date-picker" type="text" name="tiEndDate" id="tiEndDate" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${dynTemItemDTO.tiEndDate}'/>">
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
							<span class="input-group-addon"  onclick="clearCommonSelectValue(this)"><i class="fa fa-close"></i></span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="tiState">0-使用中 1-暂停 2-删除:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="tiState" id="tiState" data-min="-9999999999999999999999" data-max="9999999999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynTemItemDTO.tiState}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="tiText">表格JSON:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="tiText"  id="tiText" value="<c:out value='${dynTemItemDTO.tiText}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="tiUserSex">0- 女 1-男:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="tiUserSex" id="tiUserSex" data-min="-9999999999999999999999" data-max="9999999999999999999999" data-step="1" data-precision="0" value="<c:out value='${dynTemItemDTO.tiUserSex}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="tiUserPost">职务:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="tiUserPost"  id="tiUserPost" value="<c:out value='${dynTemItemDTO.tiUserPost}'/>">
   					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 50px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="dynTemItem_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="dynTemItem_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		//遮罩
		var maskId = null;
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
			parent.dynTemItem.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
  		 	$('#dynTemItem_saveForm').addClass('disabled').unbind("click");	
			parent.dynTemItem.save($('#form'),"edit");
		}
		//清空日期值
		function clearCommonSelectValue(element) {
			$(element).siblings("input").val("");
		}
		$(document).ready(function () {
			initDateSelect();
			parent.dynTemItem.formValidate($('#form'));
			//保存按钮绑定事件
			$('#dynTemItem_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#dynTemItem_closeForm').bind('click', function(){
				closeForm();
			});
			
		});
	</script>
</body>
</html>
