<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>


<!DOCTYPE html>
<html>

<head>
<title>ApiService</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" href="avicit/platform6/apicenter/apimanage/css/default.css" type="text/css" />
<link rel="stylesheet" href="avicit/platform6/apicenter/apimanage/css/codemirror.css" type="text/css" />


<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" /></jsp:include>

<style>
.list-group a {
	margin-bottom: 5px;
}

.busdomain {
	margin-bottom: 10px;
}

.form_commonTable th {
	text-align: left;
}

a.list-group-item:focus {
	background-color: #C2EBFF;
}

#errorCode .list-group-item {
	margin-top: 10px;
	padding-top: 10px;
}

.chosen {
	background-color: #C2EBFF;
}

.headersize {
	margin: 20px auto;
}

.headersize  td {
	font-size: 16px;
}

.head {
	width: 94%;
	margin: 0 auto;
	background-color: rgba(122, 122, 122, .1);
	padding-top: 10px;
	padding-bottom: 1px;
	border-radius: 4px;
	margin-top: 14px;
	margin-bottom: 18px;
}

.list-inline {
	padding-left: 0;
	margin-left: -5px;
	list-style: none;
	margin: 0 auto;
	font-size: 12px;
}

.exInfo {
	border: solid 1px #2fad95;
	color: #2fad95;
	border-radius: 2px;
	margin: 4px 6px;
}

a:hover {
	
}

.CodeMirror {
       border: 1px solid #eee;
       height: auto;
        max-height :200px;
   } 
.CodeMirror-scroll {
    height: auto;
    max-height :200px;
    overflow-y: hidden;
    overflow-x: auto;
}

.exactInfo{
margin-left:3px;
margin-right:3px;
}
</style>
</head>

<body>
	<div class="head" style="background-color:#f9f9f9">
		<ul class="list-inline">
			<li style="font-size: 26px; font-weight: bold; margin: 0 6px" id="serviceCode">${apiInfoManageDTO.serviceCode}</li>
			<li id="appCode" class="exInfo" title="应用编码" style="display: none"><span>${apiInfoManageDTO.appCode}</span></li>
			<li id="appName" class="exInfo" title="应用名称"><span>${apiInfoManageDTO.appName}</span></li>
			<li id="businessDomain" class="exInfo" title="业务域编码"><span>${apiInfoManageDTO.businessDomain}</span></li>
			<li id="serviceVersion" class="exInfo" title="应用版本">${apiInfoManageDTO.appVersion}</li>
			<li id="deptName" class="exInfo" title="责任部门"><span>${apiInfoManageDTO.deptNameAlias}</span></li>
			<li id="apiId" class="exInfo" title="ID" style="display: none"><span>${apiInfoManageDTO.id}</span></li>
			
			<li id="serviceCodeValue" class="exInfo" title="serviceCodeValue" style="display: none">${serviceCodeValue}</li>
			<%-- <li id="chosenBusDomain" class="chosenBusDomain" title="serviceCodeValue" style="display: none">${chosenBusDomain}</li> --%>
		</ul>
		<p style="margin-left: 11px; margin-top: 9px;">该组件提供了用户管理的服务，包括用户信息的增、删、改、查服务。</p>
	</div>
	<!-- <div class="busdomain">
		<ul id="myTab" class="nav nav-tabs"
			style="width: 94%; margin: 0 auto;">
			<li class="active"><a href="#apiDoc" data-toggle="tab">API文档</a></li>
			<li><a href="#exampleCode" data-toggle="tab">示例代码</a></li>
		</ul>
	</div> -->
	<div id="myTabContent" class="tab-content" style="width: 94%; margin: 0 auto;">
		<div id="apiDoc">
			<div>
				<div class="list-group leftMenu" style="float: left; width: 20%; 
				text-align: center;"></div>
				<table class="form_commonTable " id="APIInfo" style="float: right; width: 70%;margin-bottom:30px">
					<tbody>
						<tr>
							<th width="8%"><label id="">请求URL：</label></th>
							<td width="39%"><label id="reqUrl">xxx</label></td>
						</tr>
						<tr>
							<th width="8%"><label for="">请求方式：</label></th>
							<td width="39%"><label id="reqStyle">get</label></td>
						</tr>
						<tr>
							<th width="8%"><label for="">返回方式：</label></th>
							<td width="39%"><label id="callbackStyle">json</label></td>
						</tr>
						<tr>
							<th width="8%"><label for="">API描述：</label></th>
							<td width="39%"><label id="apiDesc">json</label></td>
						</tr>
						<tr>
							<th width="8%"><a id="APITest" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" 
							 role="button" title="API测试(POST只测试接口可用不可用)" style="width:60px" >API测试</a></th>
							<th width="8%"><a id="exampleShow" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" 
							role="button" title="示例代码" style="width:60px">示例代码</a></th>
						</tr>
						<tr>
							<th>请求参数说明</th>
						</tr>
						<tr>
							<td colspan="2">
								<form id='testform' style="padding: 10px 0;">
									<table id="requestDesGrid"></table>
								</form>
								<div id="tryIt" style="display: none; margin: 10px 0;">
									<button type="button" class="btn btn-success btn-sm btn-block" contenteditable="true">提交测试</button>
								</div>
							</td>
						</tr>
						<tr>
							<th>返回参数说明：</th>
						</tr>
						<tr>
							<td colspan="2">
								<table id="callbacDesGrid"></table>
							</td>
						</tr>
						<tr  class="fanhui">
							<th colspan="2">返回示例：</th>
						</tr>
						<tr class="fanhuiCode">
							<th colspan="2">
								<div class="returnMirror">
									<textarea id="returnExample"  style="height: 90px;width:100%;border-color:lightgray"    >
					  				</textarea>
					   			</div>
					   		</td>
						</tr>
					</tbody>
				</table>
				
			</div>
		</div>

		
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" /></jsp:include>
	<script src="avicit/platform6/apicenter/apimanage/js/codemirror.js" type="text/javascript"></script>
	<script src="avicit/platform6/apicenter/apimanage/js/clike.js" type="text/javascript"></script>
	<script src="avicit/platform6/apicenter/apimanage/js/APIService.js" type="text/javascript"></script>


</body>
</html>