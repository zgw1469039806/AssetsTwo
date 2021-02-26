<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "phoneproject/portalimage/PortalImageController/PortalImageInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<style type="text/css">
td span {
	padding: 0px 10px;
	height: 25px;
	display:block;
	float:left;
}
button {
	height: 25px;
	width: 150px;
	color: #606060;
	border: solid 1px #b7b7b7;
	background: #fff;
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#ededed));
	background: -moz-linear-gradient(top, #fff, #ededed);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#ededed');
}
</style>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<p>
			<table>
				<tbody>
					<tr>
						<td>
							<button _type="user" _host="local" onClick="synData()">同步协同研发数据</button>
						</td>
						<td>
							<span>通过此处人工同步协同研发平台和移动门户中的人员，部门数据。注：如同步失败，请尽快联系管理员查明错误。</span>
						</td>
					</tr>
				</tbody>
			</table>
		</p>
	</div>
	<script type="text/javascript">
		var portalImage;
		$(function() {
			portalImage = new PortalImage('dgPortalImage', '${url}',
					'searchDialog', 'portalImage');
		});
		function synData() {
			$.messager.progress({
				title : '请稍候',
				msg : '正在同步中...'
			});
			$.ajax({
				 url:"platform/phoneproject/portalimage/PortalImageController/synchrodata/data",
				 data : {},
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 $.messager.progress('close');
					 if (r.flag == "success"){
						 $.messager.show({
							 title : '提示',
							 msg : '同步成功！'
						 });
					 }else{
						 $.messager.show({
							 title : '提示',
							 msg : r.error
						});
					 } 
				 }
			 });
		}
	</script>
</body>
</html>