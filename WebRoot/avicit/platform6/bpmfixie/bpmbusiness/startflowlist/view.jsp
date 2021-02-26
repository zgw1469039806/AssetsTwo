<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<title>流程发起</title>
<!-- Bootstrap css file v2.2.1 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmfixie/bpmcommon/css/bootstrap.css">
<!-- 当前页 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmfixie/bpmcommon/css/newWorkflow-ie6.css">
<!-- 换肤预留 -->
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
	<div class="main">
		<div class="newWorkflow">
			<div class="nw-cont">
				<div class="nw-title">
					<i class="icon icon-box">&#xe604;</i> 常用流程
				</div>
				<div class="nw-body"></div>
			</div>
			<div class="nw-cont">
				<div class="nw-title">
					<i class="icon icon-folder_add">&#xe645;</i> 新建流程
				</div>
				<div class="nw-body">
					<c:forEach items="${result}" var="catalog">
						<div class="nw-list">
							<div class="nw-l-title">
								<span>${catalog.catalogName }</span>
							</div>
							<ul>
								<c:forEach items="${catalog.children}" var="processInfo">
									<li>
										<div class="nw-l-cont">
											<i class="icon icon-point">&#xe644;</i><a href="javascript:void(0);" onclick="flowUtils.openOnDialog('platform/bpm/business/start?defineId=${processInfo.pdId }','${processInfo.pdName }')">${processInfo.pdName } V${processInfo.pdVersion }<span class="sub">(<c:choose><c:when test="${processInfo.isUflow != null && processInfo.isUflow == '2' }">自由流程</c:when><c:otherwise>固定流程</c:otherwise></c:choose>)</span></a>
											<ul class="nw-l-nav navbar-right">
												<li class="dropdown"><a href="#" name="bpmDoFav"
													clsss="dropdown-toggle" data-toggle="dropdown"
													role="button" aria-haspopup="true" aria-expanded="false">
													<input type="hidden" value="${processInfo.pdId }">
													<i class="icon icon-star">&#xe64b;</i></a></li>
											</ul>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.js" ></script>
	<script type="text/javascript" src="static/fixie/bsie/bootstrap/js/bootstrap.js"></script>
	<!--[if lte IE 6]>
        <script type="text/javascript" src="static/fixie/bsie/js/bootstrap-ie.js"></script>
    <![endif]-->
	<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"  ></script>
	<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmcommon/js/newWorkflow.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmbusiness/startflowlist/view.js"></script>
</body>
</html>
