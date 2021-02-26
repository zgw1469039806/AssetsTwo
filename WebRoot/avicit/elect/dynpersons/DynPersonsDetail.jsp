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
			<input type="hidden" name="id" value="<c:out value='${dynPersonsDTO.id}'/>" />
			<input type="hidden" name="version" value="<c:out  value='${dynPersonsDTO.version}'/>"/>
			<table class="form_commonTable">
				<tr>
					<th width="15%">
						<label for="no">序号:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="no"  id="no" value="<c:out value='${dynPersonsDTO.no}'/>">
   					</td>
					<th width="15%">
						<label for="name">姓名:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="name"  id="name" value="<c:out value='${dynPersonsDTO.name}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="deptName">部门名称:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="deptName"  id="deptName" value="<c:out value='${dynPersonsDTO.deptName}'/>">
   					</td>
					<th>
						<label for="major">专业:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="major"  id="major" value="<c:out value='${dynPersonsDTO.major}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="status">状态:</label></th>
					<td>
						<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="true" lookupCode="candidate_status" defaultValue="${dynPersonsDTO.status}" />
   					</td>
					<th>
						<label for="turnNum">中选轮次:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="turnNum" id="turnNum"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynPersonsDTO.turnNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="ifMark">是否加星:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="ifMark"  id="ifMark" value="<c:out value='${dynPersonsDTO.ifMark}'/>">
   					</td>
					<%--<th>
						<label for="att01">备用字段1:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att01"  id="att01" value="<c:out value='${dynPersonsDTO.att01}'/>">
   					</td>--%>
				</tr>
    			<%--<tr>
					<th>
						<label for="att02">备用字段2:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att02"  id="att02" value="<c:out value='${dynPersonsDTO.att02}'/>">
   					</td>
					<th>
						<label for="att03">备用字段3:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att03"  id="att03" value="<c:out value='${dynPersonsDTO.att03}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="att04">备用字段4:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att04"  id="att04" value="<c:out value='${dynPersonsDTO.att04}'/>">
   					</td>
					<th>
						<label for="att05">备用字段5:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att05"  id="att05" value="<c:out value='${dynPersonsDTO.att05}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="att06">备用字段6:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att06" id="att06"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynPersonsDTO.att06}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="att07">备用字段7:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att07" id="att07"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynPersonsDTO.att07}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="att08">备用字段8:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att08" id="att08"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynPersonsDTO.att08}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="att09">备用字段9:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att09" id="att09"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynPersonsDTO.att09}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="att10">备用字段10:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att10" id="att10"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynPersonsDTO.att10}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>--%>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 50px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="dynPersons_closeForm">返回</a>
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
			parent.dynPersons.closeDialog("detail");
		}
		$(document).ready(function (){
			//返回按钮绑定事件
			$('#dynPersons_closeForm').bind('click', function(){
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
