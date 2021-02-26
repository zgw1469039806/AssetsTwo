<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<%
String skinsValue =  (String)session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN_TYPE);
if(StringUtils.isEmpty(skinsValue)){
	 skinsValue = "blue";
}
%>
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>demo3</title>

<link rel="stylesheet" type="text/css" href="static/h5/skin/iconfont/iconfont.css"/>

<link rel="stylesheet" href="avicit/platform6/h5demo/potal/demo_index3/css/index.css" />
<link id = "portlet-skin" rel="stylesheet" href="avicit/platform6/portal/portlet/skin/<%=skinsValue %>-portlet.css">
<style type="text/css">
	.content-empty:after,
	.content-empty:before{
	  content:"" !important;
	}
</style>
<style>
.content-body {
    padding: 10px;
}
.db-table {
    margin: 0;
    width: 100%;
}
#todo .db-table td {
    padding: 0;
    margin: 0;
    height: 30px;
    line-height: 30px;
    text-align: center;
    color: #98A5BA;
    font-size: 12px;
}

.title {
    width: 200px/0;
    max-width: 200px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    word-break: break-all;
}
a {
    text-decoration: none;
}
a.link-title {
    font-size: 14px;
    color: #3d4d65;
    width: 90%;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    float: left;
    text-align: left;
    padding-left: 14px;
    display: block;
}
a.link-title:hover {
    color: #1890ff;
}
a.link-text {
    color: #1890ff;
}
#todo .db-table tr {
    border-radius: 4px;
    overflow: hidden;
}
#todo .db-table tr:hover {
    background: #f3f4f9;
}
</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
	<body>
		<div class="bulletin content_box">
			<div class="content-body" id="todo" style="height: 240px;">
				<table class="db-table" border="0" cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<td class="title">
								<a href="javascript:void(0);" class="link-title " onclick="flowUtils.executeTask('8a58c6567369c111017369c3ec860207','8a58c656717d0a2401717d146e8d0149.8a58c6567369c111017369c3ec860207','8a58c6567369c111017369c3f3c0021b','8a58c6567369c111017369c3d8ee0205','eform/bpmsCRUDClient/tobpm?formInfoId=8a58c656717d0a2401717d10dbcf0137&amp;tableName=DYN_TEST&amp;version=V1','task1','0')">
				
									<span>测试电子表单流程</span>
				
									<span>task1</span>
								</a>
							</td>
							<td width="100px">平台管理员</td>
							<td width="80px" nowrap="nowrap">2020-07-20</td>
				
							<td width="60px;" nowrap="nowrap">
								<a class="link-text" href="javascript:void(0);" onclick="flowUtils.quickDoTask('8a58c6567369c111017369c3ec860207','8a58c656717d0a2401717d146e8d0149.8a58c6567369c111017369c3ec860207','8a58c6567369c111017369c3f3c0021b','8a58c6567369c111017369c3d8ee0205','eform/bpmsCRUDClient/tobpm?formInfoId=8a58c656717d0a2401717d10dbcf0137&amp;tableName=DYN_TEST&amp;version=V1','task1','0','task1')">办理</a>
							</td>
						</tr>
						<tr>
							<td class="title">
								<a href="javascript:void(0);" class="link-title " onclick="flowUtils.executeTask('4028803573607fd1017360f0fcca021f','8a58c656717d0a2401717d146e8d0149.4028803573607fd1017360f0fcca021f','4028803573607fd1017360f0ff4d0233','4028803573607fd1017360f0f37f021e','eform/bpmsCRUDClient/tobpm?formInfoId=8a58c656717d0a2401717d10dbcf0137&amp;tableName=DYN_TEST&amp;version=V1&amp;grid=tablee6f323aa0aa8d84ff9487281f2728cf691ed','task1','0')">
									<span>测试电子表单流程</span>
									<span>task1</span>
								</a>
							</td>
							<td width="100px">平台管理员</td>
							<td width="80px" nowrap="nowrap">2020-07-18</td>
							<td width="60px;" nowrap="nowrap">
								<a class="link-text" href="javascript:void(0);" onclick="flowUtils.quickDoTask('4028803573607fd1017360f0fcca021f','8a58c656717d0a2401717d146e8d0149.4028803573607fd1017360f0fcca021f','4028803573607fd1017360f0ff4d0233','4028803573607fd1017360f0f37f021e','eform/bpmsCRUDClient/tobpm?formInfoId=8a58c656717d0a2401717d10dbcf0137&amp;tableName=DYN_TEST&amp;version=V1&amp;grid=tablee6f323aa0aa8d84ff9487281f2728cf691ed','task1','0','task1')">办理</a>
							</td>
						</tr>
						<tr>
							<td class="title">
								<a href="javascript:void(0);" class="link-title " onclick="flowUtils.executeTask('8a58c6ab73515ad30173517ee0fc0261','8a58bcf769d81a100169d849cfcf0269.8a58c6ab73515ad30173517ee0fc0261','8a58c6ab73515ad30173517f09d80285','8a58c6ab73515ad30173517ed1c4025e','eform/bpmsCRUDClient/tobpm?formInfoId=8a58bcf769d81a100169d8355e2e020c&amp;tableName=DYN_APPLY_LEAVE&amp;version=V1','部门领导','0')">
									<span>路由分支流程配置</span>
									<span>部门领导</span>
								</a>
							</td>
							<td width="100px">平台管理员</td>
							<td width="80px" nowrap="nowrap">2020-07-15</td>
							<td width="60px;" nowrap="nowrap">
								<a class="link-text" href="javascript:void(0);" onclick="flowUtils.quickDoTask('8a58c6ab73515ad30173517ee0fc0261','8a58bcf769d81a100169d849cfcf0269.8a58c6ab73515ad30173517ee0fc0261','8a58c6ab73515ad30173517f09d80285','8a58c6ab73515ad30173517ed1c4025e','eform/bpmsCRUDClient/tobpm?formInfoId=8a58bcf769d81a100169d8355e2e020c&amp;tableName=DYN_APPLY_LEAVE&amp;version=V1','部门领导','0','task3')">办理</a>
							</td>
						</tr>
						<tr>
							<td class="title">
								<a href="javascript:void(0);" class="link-title " onclick="flowUtils.executeTask('8a58c6ab73515ad30173517dfca7023d','8a58c656717d0a2401717d146e8d0149.8a58c6ab73515ad30173517dfca7023d','8a58c6ab73515ad30173517e025e0251','8a58c6ab73515ad30173517df34a023c','eform/bpmsCRUDClient/tobpm?formInfoId=8a58c656717d0a2401717d10dbcf0137&amp;tableName=DYN_TEST&amp;version=V1','task1','0')">
									<span>测试电子表单流程</span>
									<span>task1</span>
								</a>
							</td>
							<td width="100px">平台管理员</td>
							<td width="80px" nowrap="nowrap">2020-07-15</td>
							<td width="60px;" nowrap="nowrap">
								<a class="link-text" href="javascript:void(0);" onclick="flowUtils.quickDoTask('8a58c6ab73515ad30173517dfca7023d','8a58c656717d0a2401717d146e8d0149.8a58c6ab73515ad30173517dfca7023d','8a58c6ab73515ad30173517e025e0251','8a58c6ab73515ad30173517df34a023c','eform/bpmsCRUDClient/tobpm?formInfoId=8a58c656717d0a2401717d10dbcf0137&amp;tableName=DYN_TEST&amp;version=V1','task1','0','task1')">办理</a>
							</td>
						</tr>
						<tr>
							<td class="title">
								<a href="javascript:void(0);" class="link-title " onclick="flowUtils.executeTask('8a58c6ab73515ad30173517d2b460213','8a58bc71727cf931017292e9838b0f54.8a58c6ab73515ad30173517d2b460213','8a58c6ab73515ad30173517d32250229','8a58c6ab73515ad30173517ce54b020e','eform/bpmsCRUDClient/tobpm?formInfoId=8a58bcf769d81a100169d8355e2e020c&amp;tableName=DYN_APPLY_LEAVE&amp;version=V1','-2020-07-15 16:00:26','0')">
									<span>请假审批流程</span>
									<span>-2020-07-15 16:00:26</span>
								</a>
							</td>
							<td width="100px">平台管理员</td>
							<td width="80px" nowrap="nowrap">2020-07-15</td>
							<td width="60px;" nowrap="nowrap">
								<a class="link-text" href="javascript:void(0);" onclick="flowUtils.quickDoTask('8a58c6ab73515ad30173517d2b460213','8a58bc71727cf931017292e9838b0f54.8a58c6ab73515ad30173517d2b460213','8a58c6ab73515ad30173517d32250229','8a58c6ab73515ad30173517ce54b020e','eform/bpmsCRUDClient/tobpm?formInfoId=8a58bcf769d81a100169d8355e2e020c&amp;tableName=DYN_APPLY_LEAVE&amp;version=V1','-2020-07-15 16:00:26','0','task1')">办理</a>
							</td>
						</tr>
						<tr>
							<td class="title">
								<a href="javascript:void(0);" class="link-title " onclick="flowUtils.executeTask('4028803573436b01017346ad30f30aca','8a58c656715db50b01715dcbcbe10132.4028803573436b01017346ad30f30aca','4028803573436b01017346ad31850af5','4028803573436b01017346ad30e70ac8','avicit/test/test/TestDetail.jsp','task1233','0')">
									<span>测试流程</span>
									<span>task1233</span>
								</a>
							</td>
							<td width="100px">平台管理员</td>
							<td width="80px" nowrap="nowrap">2020-07-13</td>
							<td width="60px;" nowrap="nowrap">
								<a class="link-text" href="javascript:void(0);" onclick="flowUtils.quickDoTask('4028803573436b01017346ad30f30aca','8a58c656715db50b01715dcbcbe10132.4028803573436b01017346ad30f30aca','4028803573436b01017346ad31850af5','4028803573436b01017346ad30e70ac8','avicit/test/test/TestDetail.jsp','task1233','0','task1')">办理</a>
							</td>
						</tr>
						<tr>
							<td class="title">
								<a href="javascript:void(0);" class="link-title " onclick="flowUtils.executeTask('4028803573436b0101734642068e0a90','8a58c656715db50b01715dcbcbe10132.4028803573436b0101734642068e0a90','4028803573436b010173464206cd0abb','4028803573436b0101734642067f0a8e','avicit/test/test/TestDetail.jsp','task1233','0')">
									<span>测试流程</span>
									<span>task1233</span>
								</a>
							</td>
							<td width="100px">平台管理员</td>
							<td width="80px" nowrap="nowrap">2020-07-13</td>
							<td width="60px;" nowrap="nowrap">
								<a class="link-text" href="javascript:void(0);" onclick="flowUtils.quickDoTask('4028803573436b0101734642068e0a90','8a58c656715db50b01715dcbcbe10132.4028803573436b0101734642068e0a90','4028803573436b010173464206cd0abb','4028803573436b0101734642067f0a8e','avicit/test/test/TestDetail.jsp','task1233','0','task1')">办理</a>
							</td>
						</tr>
						<tr>
							<td class="title">
								<a href="javascript:void(0);" class="link-title " onclick="flowUtils.executeTask('4028803573436b010173463ed0a60a5a','8a58c656715db50b01715dcbcbe10132.4028803573436b010173463ed0a60a5a','4028803573436b010173463ed12b0a85','4028803573436b010173463ed07f0a58','avicit/test/test/TestDetail.jsp','task1233','0')">
									<span>测试流程</span>
									<span>task1233</span>
								</a>
							</td>
							<td width="100px">平台管理员</td>
							<td width="80px" nowrap="nowrap">2020-07-13</td>
							<td width="60px;" nowrap="nowrap">
								<a class="link-text" href="javascript:void(0);" onclick="flowUtils.quickDoTask('4028803573436b010173463ed0a60a5a','8a58c656715db50b01715dcbcbe10132.4028803573436b010173463ed0a60a5a','4028803573436b010173463ed12b0a85','4028803573436b010173463ed07f0a58','avicit/test/test/TestDetail.jsp','task1233','0','task1')">办理</a>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</body>
</html>