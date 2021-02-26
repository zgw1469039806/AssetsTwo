<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- ControllerPath = "platform6/mda/mdasearchconfig/mdaSearchconfigController/toMdaSearchconfigManage" -->
<title>搜索</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<link rel="shortcut icon" href="static/images/search_imgs/favicon.ico" />
<link rel="bookmark" href="static/images/search_imgs/favicon.ico" />
<style type="text/css">
body {
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale'
		);
	background-repeat: no-repeat;
	background-positon: 100%, 100%;
	margin: 0px;
	padding: 0px;
	/* backgroud-size: cover; 只针对除了ie6的浏览器*/
}

div.search {
	border: none;
	width: 500px;
	margin: 0 auto;
}

.search input,.search button {
	float: left;
}

.search input.box { /* -webkit-box-align: center;
-webkit-box-orient: horizontal;
-webkit-box-pack: end;
display: -webkit-box;
	font-size: 1.2em;
	width: 400px;
	height: 35px;
	margin-right: 6px; */
	-webkit-box-align: center;
	-webkit-box-orient: horizontal;
	-webkit-box-pack: end;
	display: -webkit-box;
	font-size: 1.2em;
	width: 400px;
	height: 35px;
	margin-right: 6px;
	padding: 5px 0;
}

.search input.box:focus {
	outline: none;
}

.search input.btn {
	width: 80px;
	height: 33px;
	cursor: pointer;
	font-color: red;
	font-size: 1.4em;
}
/* .search button.btn {
	width: 50px;
	height: 40px;
	cursor: pointer;
	font-color:red;
	font-size: 1.2em;
} */
.search button.btn:hover {
	
}

.foot {
	font-family: Arial, Helvetica, sans-serif;
	/*  background:url(./resources/img/footBg.gif) repeat-x;  */
	background: #666666;
	height: 20px;
	font-size: 12px;
	width: 100%;
	padding-top: 6px;
	padding-bottom: 5px;
	margin-top: 0px;
	color: white;
	text-align: center;
}

.top {
	font-family: Arial, Helvetica, sans-serif;
	/*  background:url(./resources/img/footBg.gif) repeat-x;  */
	background: #292929;
	height: 20px;
	font-size: 12px;
	width: 100%;
	padding-top: 8px;
	padding-bottom: 3px;
	margin-top: 0px;
	color: white;
	text-align: right;
}

a {
	color: white;
	font-size: 15px;
}
</style>
</head>
<!-- <body background="static/images/search_imgs/bc.jpg" >  -->
<body>
	<form:form id="f1" name="f1" modelAttribute="search" method="post"
		action="search.do" style="height:89%;">

		<div style="height: 20%;"></div>

		<div style="width: 100%; align: center">

			<table style="width: 100%; margin: 0 0 0 0;">

				<tr>

					<td align="center" width="100%">
						<div style="height: 15%; margin: 35px;">
							<table style="border: none; height: 100%">
								<tr>
									<td><img src="static/images/platform/mda/search_imgs/search_logo2.png"
										border="0" style="width: 487px; height: 163px;"></td>
								</tr>
							</table>
						</div>

						<div style="height: 20px;"></div>
						<div style="height: 20%; margin: 35px;">
							<table style="border: none; height: 100%">
								<tr style="height: 45%;">
									<td>
										<div class="row"
											style="width: 350px; left: 38%; margin: 0 0 0 0; position: absolute; top: 43%;">
											<div class="input-group  input-group-sm">
												<input id="sousuo" name="word" class="easyui-validatebox" style= "width: 250px;height: 30px;float: left;"
													placeholder="请输入关键字。。。" type="text"> <span
													class="input-group-btn">
													<button id="subok" class="easyui-linkbutton" style= "height: 34px;float: left;background-color:#1ab394;border: none;"
														type="button" onclick="ok_onclick(document.f1)">
														<span><font style="margin:5px;color: #f9f9f9;" >搜索一下</font></font></font></span>
													</button>
												</span>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form:form>

	<script type="text/javascript">
		function ok_onclick(obj) {

			var searchwords = document.getElementById("sousuo").value;
			obj.action = "mdaSearchEasyUIController/operation/search?searchword="
					+ searchwords;
			obj.submit();
			/* if(searchwords==""){
				obj.action="platform6/mda/mdasearchconfig/mdaSearchController/toMdaSearchconfigIndex";
			}else{
				obj.action="platform6/mda/mdasearchconfig/mdaSearchController/operation/search?searchword="+searchwords;
				obj.submit();
			} */
		}

		document.onkeydown = function(e) {
			if (!e)
				e = window.event;//火狐中是 window.event
			if ((e.keyCode || e.which) == 13) {
				document.getElementById("subok").click();
			}
		};
	</script>
</body>
</html>