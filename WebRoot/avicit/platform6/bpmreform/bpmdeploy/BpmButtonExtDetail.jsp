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
<!-- ControllerPath = "platform6/bpmreform/bpmdesigner/bpmbuttonext/bpmButtonExtController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input
				type="hidden" name="id"
				value="<c:out  value='${bpmButtonExt.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="code">编码:</label>
					</th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="code" id="code"
						value="<c:out  value='${bpmButtonExt.code}'/>" 
						 disabled/></td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="dName">默认名称:</label>
					</th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="dName" id="dName"
						value="<c:out  value='${bpmButtonExt.dName}'/>" 
						disabled/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="name">自定义名称:</label>
					</th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="name" id="name"
						value="<c:out  value='${bpmButtonExt.name}'/>" disabled/></td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="order">排序:</label>
					</th>
					<td width="39%">
						<div class="input-group input-group-sm spinner"
							data-trigger="spinner">
							<input class="form-control" type="text" name="order"
								id="order"
								value="<c:out  value='${bpmButtonExt.order}'/>"
								data-min="-<%=Math.pow(10,11)-Math.pow(10,-0)%>"
								data-max="<%=Math.pow(10,11)-Math.pow(10,-0)%>" data-step="1"
								data-precision="0" disabled/> <span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i
									class="glyphicon glyphicon-triangle-top"></i></a> <a
								href="javascript:;" class="spin-down" data-spin="down"><i
									class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="jsfunction">js方法名称:</label>
					</th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="jsfunction" id="jsfunction"
						value="<c:out  value='${bpmButtonExt.jsfunction}'/>" 
						disabled/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="isGlobal">是否全局按钮:</label>
					</th>
					<td width="39%">
						<select id="isGlobal" name="isGlobal" class="form-control input-sm" title="" 
							data-options="" style="" value="<c:out  value='${bpmButtonExt.isGlobal}'/>"
							disabled>
						  <option value="1" <c:if test="${bpmButtonExt.isGlobal eq 1}">selected</c:if>>是</option>
						  <option value="0" <c:if test="${bpmButtonExt.isGlobal eq 0}">selected</c:if>>否</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="isPlatform">是否平台按钮:</label>
					</th>
					<td width="39%">
						<select id="isPlatform" name="isPlatform" class="form-control input-sm" title="" 
							data-options="" style="" value="<c:out  value='${bpmButtonExt.isPlatform}'/>" disabled>
						  <option value="0" <c:if test="${bpmButtonExt.isPlatform eq 0}">selected</c:if>>否</option>
						  <option value="1" <c:if test="${bpmButtonExt.isPlatform eq 1}">selected</c:if>>是</option>
						</select>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="isDesign">是否在流程设计器中配置:</label>
					</th>
					<td width="39%">
						<select id="isDesign" name="isDesign" class="form-control input-sm" 
						title="" data-options="" style="" value="<c:out  value='${bpmButtonExt.isDesign}'/>"
						disabled>
						  <option value="1" <c:if test="${bpmButtonExt.isDesign eq 1}">selected</c:if>>是</option>
						  <option value="0" <c:if test="${bpmButtonExt.isDesign eq 0}">selected</c:if>>否</option>
						</select>
					</td>
				</tr>
				<tr>
					<%--<th width="10%"><label for="isCommonly">是否常用按钮:</label></th>
					<td width="39%">
						<select id="isCommonly" name="isCommonly" class="form-control input-sm" title="" 
							data-options="" style="" value="<c:out  value='${bpmButtonExt.isCommonly}'/>" disabled>
						  <option value="1" <c:if test="${bpmButtonExt.isCommonly eq 1}">selected</c:if>>是</option>
						  <option value="0" <c:if test="${bpmButtonExt.isCommonly eq 0}">selected</c:if>>否</option>
						</select>
					</td>--%>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="icon">图标样式:</label>
					</th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="icon" id="icon"
						value="<c:out  value='${bpmButtonExt.icon}'/>" 
						disabled/></td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="desc">描述:</label>
					</th>
					<td colspan="3">
						<textarea class="form-control input-sm" rows="3" title="" name="desc" id="desc"
						disabled><c:out  value='${bpmButtonExt.desc}'/></textarea>
					</td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		document.ready = function() {
			parent.bpmButtonExt.formValidate($('#form'));
		};
		//form控件禁用
		setFormDisabled();
		$(document).keydown(function(event) {
			event.returnValue = false;
			return false;
		});
	</script>
</body>
</html>
