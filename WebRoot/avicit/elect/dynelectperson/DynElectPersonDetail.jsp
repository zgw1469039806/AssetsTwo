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
			<input type="hidden" name="id" value="<c:out value='${dynElectPersonDTO.id}'/>" />
			<input type="hidden" name="version" value="<c:out  value='${dynElectPersonDTO.version}'/>"/>
			<input type="hidden" name="electId" value="<c:out value='${pid}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="15%">
						<label for="electName">选举名称:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="electName"  id="electName" value="<c:out value='${dynElectPersonDTO.electName}'/>">
   					</td>
					<th width="15%">
						<label for="personId">候选人id:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="personId"  id="personId" value="<c:out value='${dynElectPersonDTO.personId}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="personName">候选人名称:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="personName"  id="personName" value="<c:out value='${dynElectPersonDTO.personName}'/>">
   					</td>
					<th>
						<label for="ifMark">是否加星:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="ifMark"  id="ifMark" value="<c:out value='${dynElectPersonDTO.ifMark}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="personDeptName">候选人部门:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="personDeptName"  id="personDeptName" value="<c:out value='${dynElectPersonDTO.personDeptName}'/>">
   					</td>
					<th>
						<label for="ruleDesc">规则描述:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="ruleDesc"  id="ruleDesc" value="<c:out value='${dynElectPersonDTO.ruleDesc}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="att01">备用字段1:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att01"  id="att01" value="<c:out value='${dynElectPersonDTO.att01}'/>">
   					</td>
					<th>
						<label for="att02">备用字段2:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att02"  id="att02" value="<c:out value='${dynElectPersonDTO.att02}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="att03">备用字段3:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att03"  id="att03" value="<c:out value='${dynElectPersonDTO.att03}'/>">
   					</td>
					<th>
						<label for="att04">备用字段4:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att04"  id="att04" value="<c:out value='${dynElectPersonDTO.att04}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="att05">备用字段5:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att05"  id="att05" value="<c:out value='${dynElectPersonDTO.att05}'/>">
   					</td>
					<th>
						<label for="att06">备用字段6:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att06" id="att06"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectPersonDTO.att06}'/>">
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
							<input  class="form-control"  type="text" name="att07" id="att07"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectPersonDTO.att07}'/>">
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
							<input  class="form-control"  type="text" name="att08" id="att08"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectPersonDTO.att08}'/>">
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
							<input  class="form-control"  type="text" name="att09" id="att09"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectPersonDTO.att09}'/>">
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
							<input  class="form-control"  type="text" name="att10" id="att10"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectPersonDTO.att10}'/>">
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
						<input class="form-control input-sm" type="text" name="major"  id="major" value="<c:out value='${dynElectPersonDTO.major}'/>">
   					</td>
				</tr>
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
		function closeForm(){
			parent.dynElectPerson.closeDialog("detail");
		}

        //清空日期值
        function clearCommonSelectValue(element) {
            $(element).siblings("input").val("");
        }

		$(document).ready(function (){
			//返回按钮绑定事件
			$('#dynElectPerson_closeForm').bind('click', function(){
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
