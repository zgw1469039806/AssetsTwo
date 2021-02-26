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
			<input type="hidden" name="id" value="<c:out value='${dynElectDTO.id}'/>" />
			<input type="hidden" name="version" value="<c:out  value='${dynElectDTO.version}'/>"/>
			<table class="form_commonTable">
				<tr>
					<th width="15%">
						<label for="name">选举名称:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="name"  id="name" value="<c:out value='${dynElectDTO.name}'/>">
   					</td>
					<th width="15%">
						<label for="status">状态:</label></th>
					<td width="34%">
						<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="true" lookupCode="elect_status" defaultValue="${dynElectDTO.status}" />
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="agreeRuleNum">可赞成数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="agreeRuleNum" id="agreeRuleNum"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.agreeRuleNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="shouldInvestNum">应投数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="shouldInvestNum" id="shouldInvestNum"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.shouldInvestNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="sceneNum">实到数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="sceneNum" id="sceneNum"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.sceneNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="loginNum">登陆数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="loginNum" id="loginNum"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.loginNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
				</tr>
    			<tr>
					<th>
						<label for="actualInvestNum">实投数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="actualInvestNum" id="actualInvestNum"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.actualInvestNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
   					</td>
					<th>
						<label for="roundNum">轮数:</label></th>
					<td>
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="roundNum" id="roundNum"  data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0" value="<c:out value='${dynElectDTO.roundNum}'/>">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="15%">
						<label for="scanPlan">方案:</label></th>
					<td width="34%">
						<pt6:h5select css_class="form-control input-sm" name="scanPlan" id="scanPlan" title=""  defaultValue="${dynElectDTO.scanPlan}" isNull="false" lookupCode="SCAN_PLAN" />
					</td>
					<th width="15%">
						<label for="groupId">活动标识:</label></th>
					<td width="34%">
						<input class="form-control input-sm" type="text" name="groupId"   value="<c:out value='${dynElectDTO.groupId}'/>"  id="groupId" />
					</td>
				</tr>
				<tr>
					<th width="15%">
						<label for="isShowPersons">是否显示人员信息:</label></th>
					<td width="34%">
						<pt6:h5select css_class="form-control input-sm" name="isShowPersons" id="isShowPersons" title="" isNull="true" lookupCode="SHOW_OR_HIDE" defaultValue="${dynElectDTO.isShowPersons}" />
					</td>
					<th width="15%">
						<label for="isShowVoteNum">是否显示票数:</label></th>
					<td width="34%">
						<pt6:h5select css_class="form-control input-sm" name="isShowVoteNum" id="isShowVoteNum" title="" isNull="true" lookupCode="SHOW_OR_HIDE" defaultValue="${dynElectDTO.isShowVoteNum}" />
					</td>
				</tr>
				<tr>
					<th width="15%">
						<label for="isShowRanking">是否显示排名:</label></th>
					<td width="34%">
						<pt6:h5select css_class="form-control input-sm" name="isShowRanking" id="isShowRanking" title="" isNull="true" lookupCode="SHOW_OR_HIDE" defaultValue="${dynElectDTO.isShowRanking}" />
					</td>
				</tr>
				<tr>
					<th>
						<label for="ruleDesc">规则描述:</label></th>
					<td colspan="3">
						<textarea class="form-control input-sm" rows="3" style="resize:none" readonly="readonly" name="ruleDesc" id="ruleDesc"><c:out value='${dynElectDTO.ruleDesc}'/></textarea>
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
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="dynElect_closeForm">返回</a>
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
			parent.dynElect.closeDialog("detail");
		}

        //清空日期值
        function clearCommonSelectValue(element) {
            $(element).siblings("input").val("");
        }

		$(document).ready(function (){
			//返回按钮绑定事件
			$('#dynElect_closeForm').bind('click', function(){
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
