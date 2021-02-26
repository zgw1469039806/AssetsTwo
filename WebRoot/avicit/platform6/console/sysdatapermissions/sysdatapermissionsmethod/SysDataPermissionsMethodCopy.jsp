<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>复制模块</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/css/style.css"/>
</head>
<body class="easyui-layout" fit="true">
	<div style="height: 100%">
		<div class="steps" style="height: 8%">
			<ol>
				<li id="1" class="active"><i>1</i><span class="tsl">选择要复制的方法</span></li>
				<li id="2"><i>2</i><span class="tsl">选择目标模块</span></li>
				<li id="3"><i>3</i><span class="iconfont">设置方法</span></li>
			</ol>
			<div>
				<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="上一步" id="previous" style="display: none;margin-top: 10px;"><i class="fa fa-mail-reply"></i> 上一步</a>
				<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="下一步" id="next" style="margin-top: 10px;"><i class="fa fa-mail-forward"></i> 下一步</a>
				<a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="保存" id="save" style="display: none;margin-top: 10px;"><i class="fa fa-copy"></i> 保存</a>
			</div>
		</div>
		<iframe id="contentIframe" width="100%" height="90%" frameborder="0"></iframe>
	</div>
	
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		var copyObj = {};
	
		$(function(){
			$('iframe').attr('src','platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/toCopySysDataPermissionsMethod?step=1');			
			$("#next").on("click",function(){
				var currentId = $(".steps").find(".active").attr("id");
				if(currentId=="1"){
					var contentWin = $("#contentIframe")[0].contentWindow;
					var subWin = contentWin.getFormData();
					if (!subWin) {
						return false;
					}
					copyObj.methodId = subWin.id;
					$("#1").removeClass("active");
					$("#2").addClass("active");
					$("#previous").show();
					$('iframe').attr('src',"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/toCopySysDataPermissionsMethod?step=2");
				} else if(currentId=="2"){
					var contentWin = $("#contentIframe")[0].contentWindow;
					var subWin = contentWin.getFormData();
					if(!subWin){
						return false;
					}
					copyObj.menuId = subWin;
					$("#2").removeClass("active");
					$("#3").addClass("active");
					$("#next").hide();
					$("#save").show();
					$('iframe').attr('src',"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/toCopySysDataPermissionsMethod?step=3&methodId="+copyObj.methodId+"&menuId="+copyObj.menuId);
				}
			});
			
			$("#previous").on("click",function(){
				var currentId = $(".steps").find(".active").attr("id");
				if(currentId=="2"){
					$("#previous").hide();
					$("#1").addClass("active");
					$("#2").removeClass("active");
					$('iframe').attr('src',"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/toCopySysDataPermissionsMethod?step=1");
				} else if(currentId=="3"){
					$("#2").addClass("active");
					$("#3").removeClass("active");
					$("#save").hide();
					$("#next").show();
					$('iframe').attr('src',"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/toCopySysDataPermissionsMethod?step=2");
				}
			});
			
			$("#save").on("click",function(){
				var contentWin = $("#contentIframe")[0].contentWindow;
				var subWin = contentWin.getFormData();
				if (!subWin) {
					return false;
				}
				parent.sysDataPermissionsMethod.copyMethod(JSON.stringify(subWin));
			});
		});
	</script>	
</body>
</html>