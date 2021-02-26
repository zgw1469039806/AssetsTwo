<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "avicit/platform6/mobileportal/portalimage/controller/NewPortalImageController/toSynchrodata" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
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
<body>
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
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/mobileportal/portalimage/js/PortalImage.js"
	type="text/javascript"></script>
<script type="text/javascript">
var portalImage;
$(function() {
	portalImage = new PortalImage('dgPortalImage', '${url}',
			'searchDialog', 'portalImage');
});
function synData() {
	var  msg=layer.msg('请稍候,正在同步中...',{time:false});
	$.ajax({
		 url:"platform/avicit/platform6/mobileportal/portalimage/controller/NewPortalImageController/synchrodata/data",
		 data : {},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 layer.close(msg);
			 if (r.flag == "success"){
				 layer.msg('同步成功！');
			 }else{
				 
				 layer.alert(r.error,{
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0,
					  btn: ['关闭'],
			          title:"提示"
				    }
				 );
			 } 
		 }
	 });
}
</script>
</html>