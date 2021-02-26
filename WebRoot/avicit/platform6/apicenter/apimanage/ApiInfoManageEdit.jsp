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
<title>编辑</title>
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
					<td width="39%">
					     <input class="form-control input-sm" type="text" id="businessDomain" name="businessDomain" value="<c:out  value='${apiInfoManagerDTO.businessDomain}'/>" readonly/>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="deptNameAlias">责任部门:</label></th>
					<td width="39%">
					    <%-- <div class="input-group  input-group-sm">
					   	  <input type="hidden"  id="deptName" name="deptName" value="<c:out  value='${apiInfoManagerDTO.deptName}'/>">
					      <input class="form-control" placeholder="责任部门" type="text" id="deptNameAlias" name="deptNameAlias" value="<c:out  value='${apiInfoManagerDTO.deptNameAlias}'/>">
					      <span class="input-group-addon">
					        <i class="glyphicon glyphicon-equalizer"></i>
					      </span>
				        </div> --%>
				        <input class="form-control input-sm" type="text" name="deptName" id="deptName" readonly="readonly" value="<c:out  value='${apiInfoManagerDTO.deptNameAlias}'/>" readonly/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="appName">应用名称:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" id="appName" name="appName" value="<c:out  value='${apiInfoManagerDTO.appName}'/>" readonly/></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="appCode">应用编码:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text"  id="appCode" value="<c:out  value='${apiInfoManagerDTO.appCode}'/>" readonly/></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="appDesc">应用描述:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text"  id="appDesc" value="<c:out  value='${apiInfoManagerDTO.appDesc}'/>" readonly/></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="appVersion">应用版本:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text"  id="appVersion" value="<c:out  value='${apiInfoManagerDTO.appVersion}'/>" readonly/></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="serviceCode">服务编码:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text"  id="serviceCode" value="<c:out  value='${apiInfoManagerDTO.serviceCode}'/>" readonly/></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="serviceDesc">服务描述:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text"  id="serviceDesc" value="<c:out  value='${apiInfoManagerDTO.serviceDesc}'/>" readonly/></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiName">API名称:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text"  id="apiName" value="<c:out  value='${apiInfoManagerDTO.apiName}'/>" readonly/></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiServiceUri">API地址:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text"  id="apiServiceUri" value="<c:out  value='${apiInfoManagerDTO.apiServiceUri}'/>" readonly/></td>
				</tr>
				<%-- <tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiVersion">API版本:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text"  id="apiVersion" value="<c:out  value='${apiInfoManagerDTO.apiVersion}'/>" readonly/></td>
				</tr> --%>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiDesc">API描述:</label></th>
					<td width="89%" colspan=3><input class="form-control input-sm" type="text"  id="apiDesc" value="<c:out  value='${apiInfoManagerDTO.apiDesc}'/>" readonly/></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiRequestMethod">API请求方式:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text"  id="apiRequestMethod" value="<c:out  value='${apiInfoManagerDTO.apiRequestMethod}'/>" readonly/>
					</td>
				    <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiReturnFormat">API返回格式:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text"  id="apiReturnFormat" value="<c:out  value='${apiInfoManagerDTO.apiReturnFormat}'/>" readonly/>
					</td>
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
					    <textarea class="form-control java-code" id="apiErrorInfo" data-id="apiErrorInfo">${apiErrorInfo}</textarea>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiErrorInfo">API示例代码:</label></th>
					<td width="89%" colspan=3>
					    <textarea class="form-control" rows="4" name="apiSampleCode" data-id="apiSampleCode" id="apiSampleCode"><c:out  value='${apiInfoManagerDTO.apiSampleCode}'/></textarea>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="apiTechSupport">API技术支持:</label></th>
					<td width="39%"><input class="form-control input-sm" type="text" name="apiTechSupport" id="apiTechSupport" value="<c:out  value='${apiInfoManagerDTO.apiTechSupport}'/>" readonly/></td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="monitorApiInfo_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="monitorApiInfo_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	 <script src="avicit/platform6/apicenter/apimanage/js/codemirror.js" type="text/javascript"></script>
	<script src="avicit/platform6/apicenter/apimanage/js/clike.js" type="text/javascript"></script> 
	<script type="text/javascript">
	var editor;
		function closeForm() {
			parent.monitorApiInfo.closeDialog("edit");
		}
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}
			//限制保存按钮多次点击
			$('#monitorApiInfo_saveForm').addClass('disabled');
			parent.monitorApiInfo.merageSave($('#form'), "eidt",editor);
		}

		$(document).ready(function() {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine : true,//单行显示时分秒
				closeText : '确定',//关闭按钮文案
				showButtonPanel : true,//是否展示功能按钮面板
				showSecond : false,//是否可以选择秒，默认否
			});


			
			//表单验证
			parent.monitorApiInfo.merageFormValidate($('#form'));
			//保存按钮绑定事件
			$('#monitorApiInfo_saveForm').bind('click', function() {
				saveForm();
			});
			//返回按钮绑定事件
			$('#monitorApiInfo_closeForm').bind('click', function() {
				closeForm();
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
			
			//责任部门
			/* $('#deptNameAlias').on('focus', function(e) {
				new H5CommonSelect({
					type : 'deptSelect',
					idFiled : 'deptName',
					textFiled : 'deptNameAlias'
				});
				this.blur();
				nullInput(e);
			}); */

			$('.quick_businessDomainValue').on('click', function(e) {
				layer.open({
						type : 2,
						area : [ '300px', '450px' ],
						title : '请选择业务域',
						btn: ['确定', '取消'],
						maxmin : false, // 开启最大化最小化按钮
						content : 'apicenter/apiorganization/apiOrganizationController/toApiOrganizationManage/quick_businessDomain/quick_businessDomainValue',
						yes: function(index){
					        layer.close(index);
					    },
					    btn2: function(){
					    	$("#quick_businessDomainValue").val("");
							$("#quick_businessDomain").val("");
					    },
					    cancel: function(){
					    	$("#quick_businessDomainValue").val("");
							$("#quick_businessDomain").val("");
					      }
					});
			});
			
			//高亮显示JSON、Java  
			if(testBrowerVersion()){
				 $("#apiErrorInfo,#apiRequestParam,#apiReturnParam,#apiRequestHeader").each(function(i,e){
					CodeMirror.fromTextArea(document.getElementById($(e).data("id")), {
				        lineNumbers: true,
				        readOnly : true
				    });
				}); 
			    $("#apiSampleCode").each(function(i,e){
				   editor = CodeMirror.fromTextArea(document.getElementById($(e).data("id")), {
				        lineNumbers: true,
				        matchBrackets: true,
				        mode: "text/x-java"
			       });
			    });   
			}
			//结束
			
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