<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/monitor/apicenter/monitorapiinfo/monitorApiInfoController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" href="avicit/platform6/apicenter/apimanage/css/codemirror.css" type="text/css" />
<style type="text/css">
     .CodeMirror {
         border: 1px solid #eee;
         height: auto;
          max-height :200px;
     } .CodeMirror-scroll {
         height: auto;
         max-height :200px;
         overflow-y: hidden;
         overflow-x: auto;
     }
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="version" value="<c:out  value='${apiInfoManagerDTO.version}'/>" /> 
			<input type="hidden" name="id" value="<c:out  value='${apiInfoManagerDTO.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="businessDomain">业务域编码:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="businessDomain" id="businessDomain" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.businessDomain}'/>" />
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="deptName">责任部门:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="deptName" id="deptName" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.deptNameAlias}'/>" /></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="appName">应用名称:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="appName" id="appName" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.appName}'/>" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="appCode">应用编码:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="appCode" id="appCode" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.appCode}'/>" /></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="appDesc">应用描述:</label></th>
					<td width="89%" colspan=3><input class="form-control input-sm" type="text" name="appDesc" id="appDesc" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.appDesc}'/>" /></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="appVersion">应用版本:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="appVersion" id="appVersion" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.appVersion}'/>" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="serviceCode">服务编码:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="serviceCode" id="serviceCode" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.serviceCode}'/>" /></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="serviceDesc">服务描述:</label></th>
					<td width="89%" colspan=3><input class="form-control input-sm" type="text" name="serviceDesc" id="serviceDesc" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.serviceDesc}'/>" /></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiName">API名称:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="apiName" id="apiName" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.apiName}'/>" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiServiceUri">API地址:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="apiServiceUri" id="apiServiceUri" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.apiServiceUri}'/>" /></td>
				</tr>
				<%-- <tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiVersion">API版本:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="apiVersion" id="apiVersion" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.apiVersion}'/>" /></td>
				</tr> --%>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiDesc">API描述:</label></th>
					<td  width="89%" colspan=3><input class="form-control input-sm" type="text" name="apiDesc" id="apiDesc" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.apiDesc}'/>" /></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiRequestMethod">API请求方式:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="apiRequestMethod" id="apiRequestMethod" readonly="readonly"
						value="<c:out  value='${apiInfoManagerDTO.apiRequestMethod}'/>" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiReturnFormat">API返回格式:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="apiReturnFormat" id="apiReturnFormat" readonly="readonly"
						value="<c:out  value='${apiInfoManagerDTO.apiReturnFormat}'/>" /></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiRequestParam">API请求参数:</label></th>
					<td width="89%" colspan=3>
					      <c:set var="apiRequestParam" value="${apiInfoManagerDTO.apiRequestParam}"/>
						  <c:set var="apiRequestParam" value="${fn:replace(apiRequestParam,'<','&lt')}"/>
						  <c:set var="apiRequestParam" value="${fn:replace(apiRequestParam,'>','&gt')}"/>
					       <textarea class="form-control java-code" id="apiRequestParam" data-id="apiRequestParam">${apiRequestParam}</textarea>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiRequestHeader">API请求头:</label></th>
					<td width="89%" colspan=3>
					      <c:set var="apiRequestHeader" value="${apiInfoManagerDTO.apiRequestHeader}"/>
						  <c:set var="apiRequestHeader" value="${fn:replace(apiRequestHeader,'<','&lt')}"/>
						  <c:set var="apiRequestHeader" value="${fn:replace(apiRequestHeader,'>','&gt')}"/>
					      <textarea class="form-control java-code" id="apiRequestHeader" data-id="apiRequestHeader">${apiRequestHeader}</textarea>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiReturnParam">API返回参数:</label></th>
					<td width="89%" colspan=3>
					    <c:set var="apiReturnParam" value="${apiInfoManagerDTO.apiReturnParam}"/>
						<c:set var="apiReturnParam" value="${fn:replace(apiReturnParam,'<','&lt')}"/>
						<c:set var="apiReturnParam" value="${fn:replace(apiReturnParam,'>','&gt')}"/>
					     <textarea class="form-control java-code" id="apiReturnParam" data-id="apiReturnParam">${apiReturnParam}</textarea>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiErrorInfo">API错误码:</label></th>
					<td width="89%" colspan=3>
					    <c:set var="apiErrorInfo" value="${apiInfoManagerDTO.apiErrorInfo}"/>
						<c:set var="apiErrorInfo" value="${fn:replace(apiErrorInfo,'<','&lt')}"/>
						<c:set var="apiErrorInfo" value="${fn:replace(apiErrorInfo,'>','&gt')}"/>
					    <textarea class="form-control json-code" id="apiErrorInfo" data-id="apiErrorInfo">${apiErrorInfo}</textarea>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiReturnParam">API示例代码:</label></th>
					<td width="89%" colspan=3>
					<c:set var="apiSampleCode" value="${apiInfoManagerDTO.apiSampleCode}"/>
					<c:set var="apiSampleCode" value="${fn:replace(apiSampleCode,'<','&lt')}"/>
					<c:set var="apiSampleCode" value="${fn:replace(apiSampleCode,'>','&gt')}"/>
					     <textarea class="form-control java-code" id="apiSampleCode" data-id="apiSampleCode">${apiSampleCode}</textarea>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiTechSupport">API技术支持:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="apiTechSupport" id="apiTechSupport" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.apiTechSupport}'/>" />
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"></th>
					<td width="39%"></td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script src="avicit/platform6/apicenter/apimanage/js/codemirror.js" type="text/javascript"></script>
	<script src="avicit/platform6/apicenter/apimanage/js/clike.js" type="text/javascript"></script>

	<script type="text/javascript">
		document.ready = function() {
			//parent.monitorApiInfo.formValidate($('#form'));
			/* $('pre code').each(function(i, block) {
			    hljs.highlightBlock(block);
			 }); */
			 
			 if(testBrowerVersion()){
				 
				$("#apiErrorInfo,#apiRequestParam,#apiReturnParam,#apiRequestHeader").each(function(i,e){
					CodeMirror.fromTextArea(document.getElementById($(e).data("id")), {
				        lineNumbers: true,
				        readOnly : true
				    });
				});
				$("#apiSampleCode").each(function(i,e){
					CodeMirror.fromTextArea(document.getElementById($(e).data("id")), {
				        lineNumbers: true,
				        matchBrackets: true,
				        mode: "text/x-java",
				        readOnly : true
				    });
				});
			 }
		};
		//form控件禁用
	//	setFormDisabled();
		$(document).keydown(function(event) {
			event.returnValue = false;
			return false;
		});
		
		function testBrowerVersion(){
			if(navigator.userAgent.indexOf("MSIE")>0)  
			{   
			    if(navigator.userAgent.indexOf("MSIE 6.0")>0)  
			    {   
			   return false;  
			    }   
			    if(navigator.userAgent.indexOf("MSIE 7.0")>0)  
			    {  
			    	return false;  
			    }   
			    if(navigator.userAgent.indexOf("MSIE 8.0")>0)  
			    {  
			    	return false;
			    }   
			    if(navigator.userAgent.indexOf("MSIE 9.0")>0)  
			    {  
			    	return true;
			    }   
			}else  
			{  
				return true;  
			}   
		}
	</script>
</body>
</html>