<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "mdaDatasourceEasyUIController/operation/Detail/id" -->
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		if (!"${mdaDatasourceDTO.createtime}" == "") {
			$('#createtime').datebox(
					'setValue',
					parserColumnTime("${mdaDatasourceDTO.createtime}").format(
							"yyyy-MM-dd"));
		}
		if (!"${mdaDatasourceDTO.lastmodifytime}" == "") {
			$('#lastmodifytime').datebox(
					'setValue',
					parserColumnTime("${mdaDatasourceDTO.lastmodifytime}")
							.format("yyyy-MM-dd"));
		}
		var useridUserCommonSelector = new CommonSelector("user",
				"userSelectCommonDialog", "userid", "useridAlias");
		useridUserCommonSelector.init();
		$('.input-right-icon').hide();
	});
	document.ready = function() {
		document.body.style.visibility = 'visible';
	}
</script>
</head>
<body class="easyui-layout" fit="true" style="visibility: hidden;">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id"
				value='<c:out  value='${mdaDatasourceDTO.id}'/>' /> <input
				type="hidden" name="id"
				value='<c:out  value='${mdaDatasourceDTO.id}'/>' />
			<table class="form_commonTable">
				<tr>
					<th align="right" width="10%"
						style="word-break: break-all; word-warp: break-word;"><span
						style="color: red;">*</span> USERID:</th>
					<td class="disabled" width="39%"><input title="USERID"
						class="inputbox easyui-validatebox" style="width: 99%;"
						type="hidden" name="userid" id="userid" />
						<div class="">
							<input class="easyui-validatebox" type="text" title="USERID"
								name="useridAlias" id="useridAlias" readOnly="readOnly"
								value='<c:out  value='${mdaDatasourceDTO.useridAlias}'/>'></input>
						</div></td>
					<th align="right" width="10%"
						style="word-break: break-all; word-warp: break-word;">NAME:</th>
					<td class="disabled" width="39%"><input title="NAME"
						class="inputbox easyui-validatebox" style="width: 99%;"
						type="text" name="name" id="name" readonly="readonly"
						value='<c:out  value='${mdaDatasourceDTO.name}'/>' /></td>
				</tr>
				<tr>
					<th align="right" width="10%"
						style="word-break: break-all; word-warp: break-word;">
						CREATETIME:</th>
					<td class="disabled" width="39%"><input title="CREATETIME"
						class="easyui-datebox" style="width: 99%;" editable="false"
						type="text" name="createtime" id="createtime" readonly="readonly"
						value='<c:out  value='${mdaDatasourceDTO.createtime}'/>' /></td>
					<th align="right" width="10%"
						style="word-break: break-all; word-warp: break-word;">
						LASTMODIFYTIME:</th>
					<td class="disabled" width="39%"><input title="LASTMODIFYTIME"
						class="easyui-datebox" style="width: 99%;" editable="false"
						type="text" name="lastmodifytime" id="lastmodifytime"
						readonly="readonly"
						value='<c:out  value='${mdaDatasourceDTO.lastmodifytime}'/>' /></td>
				</tr>
				<tr>
					<th align="right" width="10%"
						style="word-break: break-all; word-warp: break-word;">
						STATUS:</th>
					<td class="disabled" width="39%"><pt6:syslookup name="status"
							id="status" title="STATUS" isNull="true"
							lookupCode="PLATFORM_VALID_FLAG"
							defaultValue='${mdaDatasourceDTO.status}'
							dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel,disabled:true">
						</pt6:syslookup></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>