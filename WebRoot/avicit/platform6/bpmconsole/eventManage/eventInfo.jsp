<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>事件注册</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="dbid" value="${dto.dbid}" />
			<table class="form_commonTable">
				<tr>
					<th width="15%"><span class="remind">*</span>事件名称:</th>
					<td width="85%"><input title="事件名称" class="easyui-validatebox" data-options="required:true,validType:'maxLength[50]'" type="text" name="name" id="name" value="${dto.name}" /></td>
				</tr>
				<tr>
					<th><span class="remind">*</span>事件类路径:</th>
					<td><input title="事件类路径" class="easyui-validatebox" data-options="required:true,validType:'maxLength[500]'" type="text" name="path" id="path" value="${dto.path}" /></td>
				</tr>
				<tr>
					<th><span class="remind">*</span>类型:</th>
					<td><select class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel,disabled:${type_disabled}" name="type" id="type">
							<option value="流程事件监听" <c:if test="${dto.type =='流程事件监听'}">selected</c:if>>流程事件监听</option>
							<option value="流程路由条件" <c:if test="${dto.type =='流程路由条件'}">selected</c:if>>流程路由条件</option>
							<option value="流程动作监听" <c:if test="${dto.type =='流程动作监听'}">selected</c:if>>流程动作监听</option>
							<option value="流程自定义选人" <c:if test="${dto.type =='流程自定义选人'}">selected</c:if>>流程自定义选人</option>
							<option value="流程启动条件" <c:if test="${dto.type =='流程启动条件'}">selected</c:if>>流程启动条件</option>
					</select></td>
				</tr>
				<tr>
					<th>排序:</th>
					<td><input title="排序" class="easyui-numberbox" data-options="validType:'maxLength[10]'" type="text" name="orderBy" id="orderBy" value="${dto.orderBy}" /></td>
				</tr>
				<tr>
					<th>描述:</th>
					<td><textarea title="描述" class="textareabox" rows="3" cols="1" name="remark" id="remark">${dto.remark}</textarea></td>
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
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a title="保存" id="saveButton" class="easyui-linkbutton primary-btn" onclick="saveForm();" href="javascript:void(0);">保存</a> <a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		$.extend($.fn.validatebox.defaults.rules, {
			maxLength : {
				validator : function(value, param) {
					return param[0] >= value.length;

				},
				message : '请输入最多 {0} 字符.'
			}
		});
		function closeForm() {
			parent.myEventList.closeDialog();
		}

		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.myEventList.insertOrUpdateEvent(serializeObject($('#form')));
		}
	</script>
</body>
</html>