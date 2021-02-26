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
			<input type="hidden" name="id" value="<c:out value='${dynElectLogDTO.id}'/>" />
			<input type="hidden" name="version" value="<c:out  value='${dynElectLogDTO.version}'/>"/>
			<table class="form_commonTable">
				<tr>
					<th width="15%">
						<label for="electId">选举表id:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="electId"  id="electId" value="<c:out value='${dynElectLogDTO.electId}'/>">
   					</td>
					<th width="15%">
						<label for="electName">选举名称:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="electName"  id="electName" value="<c:out value='${dynElectLogDTO.electName}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="ruleDesc">规则描述:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="ruleDesc"  id="ruleDesc" value="<c:out value='${dynElectLogDTO.ruleDesc}'/>">
   					</td>
					<th>
						<label for="numPlate">号码牌:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="numPlate"  id="numPlate" value="<c:out value='${dynElectLogDTO.numPlate}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="personId">候选人id:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="personId"  id="personId" value="<c:out value='${dynElectLogDTO.personId}'/>">
   					</td>
					<th>
						<label for="personName">候选人姓名:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="personName"  id="personName" value="<c:out value='${dynElectLogDTO.personName}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="personDeptName">候选人部门:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="personDeptName"  id="personDeptName" value="<c:out value='${dynElectLogDTO.personDeptName}'/>">
   					</td>
					<th>
						<label for="att01">候选人专业:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att01"  id="att01" value="<c:out value='${dynElectLogDTO.att01}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="agreeNum">赞成数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="agreeNum" id="agreeNum"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectLogDTO.agreeNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="unagreeNum">反对数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="unagreeNum" id="unagreeNum"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectLogDTO.unagreeNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="giveupNum">弃权数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="giveupNum" id="giveupNum"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectLogDTO.giveupNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="submitDate">提交时间:</label></th>
					<td>
						<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text" name="submitDate" id="submitDate" value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' value='${dynElectLogDTO.submitDate}'/>" />
							<span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="att02">备用字段2:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att02"  id="att02" value="<c:out value='${dynElectLogDTO.att02}'/>">
   					</td>
					<th>
						<label for="att03">备用字段3:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att03"  id="att03" value="<c:out value='${dynElectLogDTO.att03}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="att04">备用字段4:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att04"  id="att04" value="<c:out value='${dynElectLogDTO.att04}'/>">
   					</td>
					<th>
						<label for="att05">备用字段5:</label></th>
					<td>
						<input class="form-control input-sm" type="text" name="att05"  id="att05" value="<c:out value='${dynElectLogDTO.att05}'/>">
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="att06">备用字段6:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="att06" id="att06"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectLogDTO.att06}'/>">
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
							<input  class="form-control"  type="text" name="att07" id="att07"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectLogDTO.att07}'/>">
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
							<input  class="form-control"  type="text" name="att08" id="att08"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectLogDTO.att08}'/>">
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
							<input  class="form-control"  type="text" name="att09" id="att09"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectLogDTO.att09}'/>">
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
							<input  class="form-control"  type="text" name="att10" id="att10"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectLogDTO.att10}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
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
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="dynElectLog_closeForm">返回</a>
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
			parent.dynElectLog.closeDialog("detail");
		}
		$(document).ready(function (){
			//返回按钮绑定事件
			$('#dynElectLog_closeForm').bind('click', function(){
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
