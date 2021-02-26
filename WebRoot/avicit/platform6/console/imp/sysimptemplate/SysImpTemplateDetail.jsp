<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<HEAD>
<title>详细</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- ControllerPath = "platform6/modules/system/imp/sysimptemplate/sysImpTemplateController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id"
				value="<c:out  value='${sysImpTemplateDTO.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="code">编码:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="code" id="code" readonly="readonly"
						value="<c:out value='${sysImpTemplateDTO.code}'/>" /></td>
					<th width="10%"><label for="name">名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="name" id="name" readonly="readonly"
						value="<c:out value='${sysImpTemplateDTO.name}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="swfl">事务控制方式:</label></th>
					<td width="39%"><pt6:h5select
							css_class="form-control input-sm" name="swfl" id="swfl" title=""
							isNull="true" lookupCode="SWFL_CONTROL"
							defaultValue='${sysImpTemplateDTO.swfl}' /></td>
					<th width="10%"><label for="bz">描述:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="bz" id="bz" readonly="readonly"
						value="<c:out value='${sysImpTemplateDTO.bz}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="userClass">用户自定义处理类:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="userClass" id="userClass" readonly="readonly"
						value="<c:out value='${sysImpTemplateDTO.userClass}'/>" /></td>
				</tr>
				<tr>
					<th><label for="attachment">附件</label></th>
					<td colspan="<%=2 * 2 - 1%>">
						<div id="attachment"></div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		//关闭Dialog
		function closeForm() {
			parent.sysImpTemplate.closeDialog();
		}
		//加载完后初始化
		$(document).ready(function() {
			//初始化附件上传组件
			$('#attachment').uploaderExt({
				formId : '${sysImpTemplateDTO.id}',
				allowAdd : false,
				allowDelete : false
			});
			//返回按钮绑定事件
			$('#returnButton').bind('click', function() {
				closeForm();
			});
			//form控件禁用
			setFormDisabled();
			$(document).keydown(function(event) {
				event.returnValue = false;
				return false;
			});
		});
	</script>
</body>
</html>