<%@page import="java.util.Enumeration"%>
<%@page language="java"  pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page import="avicit.platform6.core.properties.PlatformProperties"%>
<%@ page import="avicit.platform6.core.properties.PlatformConstant"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>欢迎使用-业务基础平台</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<meta name="renderer" content="webkit|ie-stand">
	<link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico" type="image/x-icon">
	<link href="static/fixie/jquery-easyui-1.3.5/themes/azure/easyui.css" type="text/css" rel="stylesheet">
	<link href="static/fixie/jquery-easyui-1.3.5/themes/azure/avicit-easyui-extend-1.3.5.css" type="text/css" rel="stylesheet">
	<link href="static/fixie/jquery-easyui-1.3.5/themes/azure/icon.css" type="text/css" rel="stylesheet">
	<link href="avicit/platform6/portal/themes/fixie/css/style.css" type="text/css" rel="stylesheet">
	
	<script type="text/javascript" src="static/fixie/jQuery-1.8.2/jquery-1.8.2.min.js"></script>
	<script type="text/javascript" src="static/fixie/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>
	
</head>
<body class="easyui-layout">
  <div data-options="region:'north'" style="height:65px;background-color:#00b3af">
  	<div class="headerLogoDom">
        <div class="logo"><img src="avicit/platform6/portal/logo.png"></div>
   		<div class="title">业务基础平台</div>
    </div>
    <div class="headerConfigDom">
    	<table>
    		<tr><td></td><td></td><td>您好，[${userName }]</td></tr>
    	</table>
    </div>
  </div>
        <div data-options="region:'west',split:true,title:'我的菜单'" style="width:200px;">
        	<div class="easyui-panel" style="padding:5px">
		        <ul class="easyui-tree" data-options="url:'tree_data.json',method:'get'"></ul>
		    </div>
        </div>
        <div data-options="region:'center'"></div>
</body>
</html>