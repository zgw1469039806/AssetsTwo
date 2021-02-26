<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<c:set var="jsversion" scope="request" value="1"/> 
<%@ page import="java.util.Arrays"%>
<% 
Object lang=session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_LANGUAGE_CODE);
String languageCode="zh_CN";
int intFlag = (int)(Math.random() * 1000000);
String flag = String.valueOf(intFlag);
if(lang!=null){
	languageCode=lang.toString();
}
//modify by xingc
String skinsValue = (String)session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN);
if(skinsValue == null){
	skinsValue="static/h5/skin/default.css";
}

String colorValue =  (String)session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN_TYPE);
if(colorValue == null){
	colorValue = "blue";
}
boolean All_LIB_FLG = true;
String importlibs = request.getParameter("importlibs");
String[] libs = new String[]{""};
if(importlibs != null){
	All_LIB_FLG = false;
	libs = importlibs.split(",");
}
Arrays.sort(libs);
int positon = Arrays.binarySearch(libs, "noLoading-mask");
if(All_LIB_FLG || positon >= 0){}else{
%>
<!-- 增加页面重新打开窗口时没有ico图标问题，由于增加样式引用会导致IE8超出样式引用个数限制，这里需要判断IE8下不引入改样式，IE8引入该样式也是无效的 -->
 <script type="text/javascript">
 if(!(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/8./i)=="8.")){
	document.write('<link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico" type="image/x-icon">');
 }
 </script>
<script type="text/javascript" src="static/h5/singleLayOut/src/loading-mask.js?v=${jsversion}"></script>
<%
}
positon = Arrays.binarySearch(libs, "common");
if(All_LIB_FLG || positon >= 0){
%>
<script>
	// var bssbsrc= "static/h5/bootstrap/3.3.4/css_default/bootstrap.min.css";
</script>
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap.css?v=${jsversion}"/>
<style>
	@font-face {
    	font-family: 'Glyphicons Halflings<%=flag %>';
    	src: url('static/h5/bootstrap/3.3.4/fonts/glyphicons-halflings-regular.eot');
	}
	@font-face {
    	font-family: 'Glyphicons Halflings<%=flag %>';
    	src: url('static/h5/bootstrap/3.3.4/fonts/glyphicons-halflings-regular.eot');
    	src: url('static/h5/bootstrap/3.3.4/fonts/glyphicons-halflings-regular.eot?#iefix') format('embedded-opentype'), 
    	url('static/h5/bootstrap/3.3.4/fonts/glyphicons-halflings-regular.woff2') format('woff2'),
        url('static/h5/bootstrap/3.3.4/fonts/glyphicons-halflings-regular.woff') format('woff'), 
        url('static/h5/bootstrap/3.3.4/fonts/glyphicons-halflings-regular.ttf') format('truetype'), 
        url('static/h5/bootstrap/3.3.4/fonts/glyphicons-halflings-regular.svg#glyphicons_halflingsregular') format('svg')
	}
	.glyphicon {
		font-family: 'Glyphicons Halflings<%=flag %>';
	}
</style>
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap/3.3.4/css_default/bootstrap-theme.min.css?v=${jsversion}"/>
<link rel="stylesheet" type="text/css" href="static/h5/singleLayOut/themes/easyui-bootstrap.css?v=${jsversion}"/>
<link rel="stylesheet" type="text/css" href="static/h5/font-awesome-4.7.0/css/font-awesome.min.css?v=${jsversion}"/>
<%
}
positon = Arrays.binarySearch(libs, "form");
if(All_LIB_FLG || positon >= 0){
%>
<link rel="stylesheet" type="text/css" href="static/h5/jQuery-Timepicker-Addon-1.6.3/jquery-ui-1.12.1.custom/jquery-ui.css?v=${jsversion}"/>
<link rel="stylesheet" type="text/css" href="static/h5/jQuery-Timepicker-Addon-1.6.3/dist/jquery-ui-timepicker-addon.css?v=${jsversion}"/>
<link rel="stylesheet" type="text/css" href="static/h5/jquery.spinner-master/dist/css/bootstrap-spinner.css?v=${jsversion}"/>
<link rel="stylesheet" type="text/css" href="static/h5/colorpicker/css/colorpicker.css?v=${jsversion}"/>
<link rel="stylesheet" type="text/css" href="static/h5/avicSelectBar/compent/avicSelect/css/avicSelect.css?v=${jsversion}"/>
<%
}
positon = Arrays.binarySearch(libs, "tree");
if(All_LIB_FLG || positon >= 0){
%>
<link rel="stylesheet" id="bsztree" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro.css?v=${jsversion}" />
<%
}
positon = Arrays.binarySearch(libs, "table");
if(All_LIB_FLG || positon >= 0){
%>
<link rel="stylesheet" type="text/css" href="static/h5/jqGrid-5.2.0/css/ui.jqgrid-bootstrap.css?v=${jsversion}" />
<%
}
positon = Arrays.binarySearch(libs, "fileupload");
if(All_LIB_FLG || positon >= 0){
%>
<link rel="stylesheet" type="text/css" href="static/h5/webuploader-0.1.5/dist/webuploader.css?v=${jsversion}"/>
<link rel="stylesheet" type="text/css" href="static/h5/uploader-ext/uploader-ext.css?v=${jsversion}"/>
<%
}
positon = Arrays.binarySearch(libs, "treeview");
if(All_LIB_FLG || positon >= 0){
%>
<link rel="stylesheet" type="text/css" href="static/h5/bootstrap-treeview/css/bootstrap-treeview.css?v=${jsversion}"/>
<%
}
positon = Arrays.binarySearch(libs, "common");
if(All_LIB_FLG || positon >= 0){
%>
<link rel="stylesheet" type="text/css" href="static/h5/skin/css/toolbar.css?v=${jsversion}"/>
<!--平台公共图标库文件  -->
<link rel="stylesheet" type="text/css" href="static/h5/skin/iconfont/iconfont.css?v=${jsversion}"/>
<!--平台自定义复写图标库文件  -->
<link rel="stylesheet" type="text/css" href="static/h5/skin/common.css?v=${jsversion}"/>
<link rel="stylesheet" type="text/css" href="static/css/platform/eform/form_commonTable1.css?v=${jsversion}"/>
<link rel="stylesheet" type="text/css" id="skin_link" href=""/>
<!--平台皮肤提取颜色css  -->
<link rel="stylesheet" type="text/css" id="color_link" href=""/>
<%}%>

<script>
	var consoleFlag;
	var obj;
	try{
		obj = top;
	}catch(err){
		obj = window.opener.top;
	}
	consoleFlag = obj.consoleFlag;
    var link = document.getElementById("skin_link");
    var colorLink = document.getElementById("color_link");
    var linkStr = "<%=skinsValue %>";
    var colorLinkStr = "avicit/platform6/portal/skin/<%=colorValue %>.css";
    if (consoleFlag != null && consoleFlag != "" && typeof(consoleFlag) != "undefined"){
    	if (consoleFlag == "_console"){
    		linkStr = "avicit/platform6/portal/themes/oa/skins/blue/skin/style.css";
    		colorLinkStr = "avicit/platform6/portal/skin/blue.css";
    	}
    }
	link.setAttribute('href',linkStr);
	colorLink.setAttribute('href',colorLinkStr);
</script>
