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
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value="<c:out value='${dbCommonColDTO.id}'/>" />
			<input type="hidden" name="version" value="<c:out  value='${dbCommonColDTO.version}'/>"/>
			<table class="form_commonTable">
				<tr>
					<th width="10%">
						<label for="colName">字段名称:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="colName"  id="colName" value="<c:out value='${dbCommonColDTO.colName}'/>">
   					</td>
					<th width="10%">
						<label for="colType">数据类型:</label></th>
					<td width="39%">
						<pt6:h5select css_class="form-control input-sm" name="colType" id="colType" title="" isNull="true" lookupCode="PLATFORM_MENU_MARK" defaultValue="${dbCommonColDTO.colType}" />
   					</td>
				</tr>
				<tr>
					<th>
						<label for="colLength">字段长度:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="colLength"  id="colLength" value="<c:out value='${dbCommonColDTO.colLength}'/>">
   					</td>
					<th>
						<label for="colDecimal">小数位数:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="colDecimal"  id="colDecimal" value="<c:out value='${dbCommonColDTO.colDecimal}'/>">
   					</td>
				</tr>
				<tr>
					<th>
						<label for="orderBy">排序:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="orderBy" id="orderBy"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dbCommonColDTO.orderBy}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="colDomType">字段类型:</label></th>
					<td>
						<pt6:h5select css_class="form-control input-sm" name="colDomType" id="colDomType" title="" isNull="true" lookupCode="PLATFORM_VALID_FLAG" defaultValue="${dbCommonColDTO.colDomType}" />
   					</td>
				</tr>
				<tr>
					<th>
						<label for="colClass">所属分类:</label></th>
					<td>
						<pt6:h5select css_class="form-control input-sm" name="colClass" id="colClass" title="" isNull="true" lookupCode="PLATFORM_PROGRAM_VERSION_OPENMODE" defaultValue="${dbCommonColDTO.colClass}" />
   					</td>
				</tr>
				<tr>
					<th>
						<label for="colComments">描述:</label></th>
					<td colspan="3">
						<textarea class="form-control input-sm" rows="3" style="resize:none" readonly="readonly" name="colComments" id="colComments"><c:out value='${dbCommonColDTO.colComments}'/></textarea> 
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
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="dbCommonCol_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		function closeForm(){
			parent.dbCommonCol.closeDialog("detail");
		}
		$(document).ready(function (){
			//返回按钮绑定事件
			$('#dbCommonCol_closeForm').bind('click', function(){
				closeForm();
			});
		});
		//form控件禁用
		setFormDisabled();
		$(document).keydown(function(event){  
			event.returnValue = false;
			return false;
		});
	</script>
</body>
</html>
