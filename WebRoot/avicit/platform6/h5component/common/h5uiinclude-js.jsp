<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.Arrays"%>
<c:set var="jsversion" scope="request" value="1"/> 
<%
Object lang=session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_LANGUAGE_CODE);
String languageCode="zh_CN";
if(lang!=null){
	languageCode=lang.toString();
}
String theme = null;
if(theme ==null){
	theme = "";
}
String skinColor = (String)session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN);
if(skinColor ==null){
	skinColor="";
}

boolean All_LIB_FLG = true;
String importlibs = request.getParameter("importlibs");
String[] libs = new String[]{""};
if(importlibs != null){
	All_LIB_FLG = false;
	libs = importlibs.split(",");
}
Arrays.sort(libs);
int positon = Arrays.binarySearch(libs, "common");
if(All_LIB_FLG || positon >= 0){

	int noskin = Arrays.binarySearch(libs, "noskin");
	if(noskin < 0){
		if(!(theme.equals("")  || skinColor.equals("")) ){
%>
<link rel="stylesheet" type="text/css" href="avicit/platform6/portal/themes/<%=theme%>/<%=skinColor%>/skin/style.css?v=${jsversion}"/>
<%
}}
%>
<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/jquery-validation/1.14.0/jquery.validate.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/bootstrap/3.3.4/js/bootstrap.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/jquery_lazyload/jquery.lazyload.js?v=${jsversion}" ></script>
<script type="text/javascript" src="static/h5/singleLayOut/easyloader.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/singleLayOut/src/jquery.resizable.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/singleLayOut/plugins/jquery.panel.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/singleLayOut/plugins/jquery.layout.custom.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/common-ext/h5-common-befer.js?v=${jsversion}"></script>

<script>
	function dynamicLoadCss(id) {
		if(bssbsrc){
			url = bssbsrc;
		}else{
			url = "static/h5/bootstrap/3.3.4/css_default/bootstrap.min.css";
		}
        var link = document.getElementById(id);
        if (link!=null)
        	link.href = url;
    }
    // function banBackSpace(e) {
	//     var ev = e || window.event; //获取event对象
	//     var obj = ev.target || ev.srcElement; //获取事件源
	//     var t = obj.type || obj.getAttribute('type'); //获取事件源类型
	//     //获取作为判断条件的事件类型
	//     var vReadOnly = obj.getAttribute('readonly');
	//     //处理null值情况
	//     vReadOnly = (vReadOnly == "") ? false : vReadOnly;
	//     //当敲Backspace键时，事件源类型为密码或单行、多行文本的，
	//     //并且readonly属性为true或enabled属性为false的，则退格键失效
	//     var flag1 = (ev.keyCode == 8 && (t == "password" || t == "text" || t == "	textarea") &&
	//         vReadOnly == "readonly") ? true : false;
	//     //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效
	//     var flag2 = (ev.keyCode == 8 && t != "password" && t != "text" && t != "	textarea") ?
	//         true : false;
	//     //判断
	//     if (flag2) {
	//         return false;
	//     }
	//     if (flag1) {
	//         return false;
	//     }
	// }
	$(function(){
    	// dynamicLoadCss('bssb');
    	//禁止后退键 作用于Firefox、Opera
    	// document.onkeypress = banBackSpace;
    	//禁止后退键 作用于IE、Chrome
    	// document.onkeydown = banBackSpace;
    });
</script>
<%
}
positon = Arrays.binarySearch(libs, "tree");
if(All_LIB_FLG || positon >= 0){
%>
<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js?v=${jsversion}"></script>
<%
}
positon = Arrays.binarySearch(libs, "table");
if(All_LIB_FLG || positon >= 0){
%>
<script type="text/javascript" src="static/h5/jqGrid-5.2.0/js/i18n/grid.locale-cn.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/jqGrid-5.2.0/js/jquery.jqGrid.custom.js?v=${jsversion}"></script>
<%
}
positon = Arrays.binarySearch(libs, "form");
if(All_LIB_FLG || positon >= 0){
%>
<script type="text/javascript" src="static/h5/jQuery-Timepicker-Addon-1.6.3/jquery-ui-1.12.1.custom/jquery-ui.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/jQuery-Timepicker-Addon-1.6.3/dist/jquery-ui-timepicker-addon.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/jQuery-Timepicker-Addon-1.6.3/dist/i18n/jquery-ui-timepicker-zh-CN.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/jQuery-Timepicker-Addon-1.6.3/dist/jquery-ui-sliderAccess.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/jquery.spinner-master/dist/js/jquery.spinner.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/common-ext/validate-ext.js"></script>
<script type="text/javascript" src="static/h5/jquery-validation/1.14.0/localization/messages_zh.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/common-ext/window-ext.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/common-ext/CommonSelect.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/colorpicker/js/colorpicker.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/avicSelectBar/compent/avicSelect/js/avicSelect.js?v=${jsversion}"></script>
<%
}
positon = Arrays.binarySearch(libs, "fileupload");
if(All_LIB_FLG || positon >= 0){
%>
<script type="text/javascript" src="static/h5/uploader-ext/swfobject.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/webuploader-0.1.5/dist/webuploader.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/uploader-ext/uploader-ext.js?v=${jsversion}"></script>
<%
}
positon = Arrays.binarySearch(libs, "treeview");
if(All_LIB_FLG || positon >= 0){
%>
<script type="text/javascript" src="static/h5/bootstrap-treeview/js/bootstrap-treeview.js?v=${jsversion}"></script>
<%
}
positon = Arrays.binarySearch(libs, "common");
if(All_LIB_FLG || positon >= 0){
%>
<!--[if lt IE 9]>
<!--<script src="static/h5/html5shiv/dist/html5shiv.min.js"></script>-->
<!--<script src="static/h5/respond/dest/respond.min.js"></script>-->
<![endif]-->
<script type="text/javascript" src="static/h5/common-ext/avic.ajax.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/common-ext/h5-common-after.js?v=${jsversion}"></script>
<script type="text/javascript" src="static/h5/perfect-scrollbar/js/divscroll.js?v=${jsversion}"></script>
<%
}
%>
<!-- 解决IE图标重绘问题公共js -->
<script type="text/javascript" src="avicit/platform6/portal/js/redrawpseudoel.js?v=${jsversion}"></script>  