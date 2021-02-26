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
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
	<body style="position: relative; background: #f3f4f9;">

		<div class="warpper">
			<!--<div class="box">
				<iframe src="page/top_card.html" frameborder="0" style="width: 100%;border: 0;height: 120px;"></iframe>
			</div>-->
			<div class="pos_re">
				<div class="pos_left">
					<div class="box ">
						<iframe src="page/waittodo.jsp" frameborder="0" style="width: 100%;border: 0;height: 314px;"></iframe>
					</div>

					<div class="box clearfix">
						<div class="box_left">
							<iframe src="page/chartOne.jsp" frameborder="0" style="width: 100%;border: 0;height: 342px;"></iframe>
						</div>
						<div class="box_left">
							<div>
								<iframe src="page/chartTwo.jsp" frameborder="0" style="width: 100%;border: 0;height: 347px;"></iframe>
							</div>
						</div>
					</div>
				</div>
				<div class="pos_right">
					<div class="box ">
						<iframe src="page/bulletin.jsp" frameborder="0" style="width: 100%;border: 0; height: 314px;"></iframe>
					</div>
					<div class="box ">
						<iframe src="page/quick_nav.jsp" frameborder="0" style="width: 100%;border: 0; height: 342px;"></iframe>
					</div>
				</div>
			</div>
			<div class="box">
				<iframe src="page/chartThree.jsp" frameborder="0" style="width: 100%;border: 0;height: 390px;"></iframe>
			</div>
			<div class="box">
				<iframe src="page/task.jsp" frameborder="0" style="width: 100%;border: 0;height: 300px;"></iframe>
			</div>
		</div>
	</body>

</html>