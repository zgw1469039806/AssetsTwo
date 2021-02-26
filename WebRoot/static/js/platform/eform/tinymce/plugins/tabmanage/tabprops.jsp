<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="static/css/platform/aceadmin/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="static/css/platform/aceadmin/css/font-awesome.min.css"/>

    <link rel="stylesheet" href="static/css/platform/eform/jquery-ui.min.css"/>


<link rel="stylesheet" href="avicit/platform6/eform/formdesign/css/subtable.css"/>


<!-- basic scripts -->
<!--[if !IE]> -->
<script src="static/js/platform/aceadmin/jquery.min.js"></script>
<!-- <![endif]-->
<!--[if IE]>
<script src="static/js/platform/aceadmin/jquery1x.min.js"></script>
<![endif]-->
<script src="static/js/platform/aceadmin/bootstrap.min.js"></script>
<script src="static/js/platform/eform/jquery-ui.min.js"></script>
<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
<script src="static/js/platform/eform/common.js"></script>
<script src="static/js/platform/eform/mydialog.js"></script>
<script src="static/js/platform/eform/tinymce/plugins/tabmanage/tabprops.js"></script>
<style type="text/css">
	.add-button-group{
		float: right;
    	padding: 1px;
	}
	.add-button{
		padding-top: 2px;
    	padding-bottom: 2px;
	}
    html,body{
        height: 100%;
        width: 100%;
    }
</style>
</head>
<body>
    <div class="item-list-wrap">
        <div class="title">标签页<span id="item_add" style="float:right;color:rgb(90, 172, 35);"><i class="fa fa-fw fa-lg fa-plus"></i></span></div>
        <ul id="list_area" class="content-wrap" style="visibility: visible; outline: none;"></ul>
        <div class="empty-tip">
            点击添加新项按钮添加新的标签页
        </div>
    </div>
    <div class="property-list-wrap">
        <div class="title">属性</div>
        <ul class="content-wrap" style="visibility: visible;">
            <form id="property_form">
                <li class="property-list">
                    <span class="property-title">页签名称</span>
                    <input type="text" name="tabname" class="item-width">
                </li>
                <li class="property-list">
                    <span class="property-title">页签id</span>
                    <input type="text" name="tabid" class="item-width">
                </li>

          
            </form>
        </ul>
        <div class="empty-tip">
            请先添加页签
        </div>
    </div>
</body>
</html>