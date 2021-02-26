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
				<th width="15%"><label for="name">事件名称:</label></th>
				<td width="85%"><input class="form-control input-sm"
									   type="text" name="name" id="name" /></td>
			</tr>
			<tr>
				<th><label for="path">事件类路径:</label></th>
				<td><input class="form-control input-sm"
									   type="text" name="path" id="path" />
				</td>
			</tr>
			<tr>
				<th><label for="type">类型:</label></th>
				<td>
					<select id="type" name="type" class="form-control input-sm" title=""
							data-options="" style="">
						<option value="流程事件监听">流程事件监听</option>
						<option value="流程路由条件">流程路由条件</option>
						<option value="流程动作监听">流程动作监听</option>
						<option value="流程自定义选人">流程自定义选人</option>
						<option value="流程启动条件">流程启动条件</option>
					</select>
				</td>
			</tr>
			<tr>
				<th><label for="orderBy">排序:</label></th>
				<td>
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
				<th><label for="remark">描述:</label></th>
				<td><input class="form-control input-sm"
									   type="text" name="remark" id="remark" />
				</td>
			</tr>
			<tr>
				<th>说明：</th>
				<td>
					<p style="color:#CC3333">类型选择后不能修改，只有流程事件监听类型的事件可以添加参数</p>
					<p>流程事件监听：包括全局和人工节点的前置事件、后置事件以及超时事件，流转线上的流转事件，需要实现接口"EventListener" <a href="avicit/platform6/bpmconsole/eventManage/EventListener.jsp" target="_blank">demo</a></p>
					<p>流程路由条件：包括流转线上的路由条件，需要实现接口"RouteConditionInterface" <a href="avicit/platform6/bpmconsole/eventManage/Condition.jsp" target="_blank">demo</a></p>
					<p>流程动作监听：包括全局和人工节点的各个动作的预处理、后处理事件，需要实现接口"PrecessingInterface" <a href="avicit/platform6/bpmconsole/eventManage/PrecessingInterface.jsp" target="_blank">demo</a></p>
					<p>流程自定义选人：包括候选人自定义选人以及特殊权限操作人自定义选人，需要继承抽象类"UserSelect" <a href="avicit/platform6/bpmconsole/eventManage/UserSelect.jsp" target="_blank">demo</a></p>
					<p>流程启动条件：指全局流程启动条件，需要实现接口"ProcessConditionInterface" <a href="avicit/platform6/bpmconsole/eventManage/ProcessConditionInterface.jsp" target="_blank">demo</a></p>
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
		<table class="tableForm" style="border:0;cellspacing:1;width:100%">
			<tr>
				<td width="50%" style="padding-right:4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="保存" id="bpmEvent_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="bpmEvent_closeForm">返回</a></td>
			</tr>
		</table>
	</div>
</div>
<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
	function closeForm() {
		parent.bpmEvent.closeDialog("insert");
	}
	function saveForm() {
		var isValidate = $("#form").validate();
		if (!isValidate.checkForm()) {
			isValidate.showErrors();
			return false;
		}
		//限制保存按钮多次点击
		$('#bpmEvent_saveForm').addClass('disabled').unbind("click");
		parent.bpmEvent.save($('#form'), "insert");
	}

	$(document).ready(function() {
		parent.bpmEvent.formValidate($('#form'));
		//保存按钮绑定事件
		$('#bpmEvent_saveForm').bind('click', function() {
			saveForm();
		});
		//返回按钮绑定事件
		$('#bpmEvent_closeForm').bind('click', function() {
			closeForm();
		});
	});
</script>
</body>
</html>
