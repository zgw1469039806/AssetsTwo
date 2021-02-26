<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
	String importlibs = "common,table,form,tree";	
%>
<!DOCTYPE html>
<html>
<head>
	
	<title>行为规则设置</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='addFormViewAction' role="form">
、
				<input type="hidden" name="id" id="columnId">
				<table class="form_commonTable">
					<tr>
						<th width="10%" style="word-break: break-all; word-warp: break-word;">
							<label for="formId">关联表单</label>
						</th>
						<td width="40%">
							<input type="hidden" id="formId" name="formId">
							<input class="form-control input-sm" type="text" name="formName" id="formName" title="关联表单" readonly/>
						</td>
						<td width="5%"></td>
					</tr>
					<tr>
						<th width="10%" style="word-break: break-all; word-warp: break-word;">
							<label for="formOpen">行为目标</label>
						</th>
						<td width="40%">
							<select class="form-control input-sm" id="formOpen" name="formOpen" title="行为目标">
					        	<option value="1">新TAB页</option>
					        	<option value="2">模态窗口</option>
					        	<option value="3">新窗体</option>
					        </select>
						</td>
						<td width="5%"></td>
					</tr>
				</table>	
		</form>
	</div>	
	
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script src="avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.js"></script>
	<script type="text/javascript">
		var selectPublishEform = new SelectPublishEform("formId","formName",null,"Y","eform");
		selectPublishEform.init();	        
	</script>
</body>
</html>