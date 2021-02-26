<%@page import="java.util.Enumeration"%>
<%@page language="java"  pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String importlibs = "common";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自定义个人首页</title>
<%-- <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include> --%>

<!--[if !IE 7]><!-->
<link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/bootstrap.css">
    <!-- bsie css 补丁文件 -->
<link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/bootstrap-ie6.css">
<link rel="stylesheet" type="text/css" href="static/fixie/bsie/bootstrap/css/bootstrap-theme.css"/>
 <!--<![endif]-->
<!-- Le styles -->
<link rel="stylesheet" type="text/css" href="static/h5/singleLayOut/themes/easyui-bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/font-awesome-4.7.0/css/font-awesome.css"/>
<link rel="stylesheet" type="text/css" href="avicit/platform6/portalie/css/toolbar.css"/>
<link rel="stylesheet" type="text/css" href="avicit/platform6/portalie/css/iconfont/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/skin/default.css"/>
<!-- Le styles -->
<link href="avicit/platform6/portal/portlet/css/bootstrap-combined.min.css" rel="stylesheet">
<link href="avicit/platform6/portal/portlet/css/layoutit.css" rel="stylesheet">
<link href="avicit/platform6/portal/portlet/css/layoutit_extend.css" rel="stylesheet">
<link href="avicit/platform6/portal/portlet/css/guider.css" rel="stylesheet">

</head>
<body style="height:660px;cursor:auto;background:#f0f0f0;padding-top:10px;display:;overflow-x:hidden;width: 99.5%;" class="edit">
<!-- <div id='loading' style='display:block;text-align:center;'>
	正在加载数据...
</div> -->
<div id='main' class="container-fluid" style="padding-left:2px;padding-right:2px;display:none;">
  <div class="row-fluid" >
    <div style="min-height: 590px;" class="demo ui-sortable">
    	${portletContent}
    </div>
  </div>
</div>

<script type="text/javascript" src="avicit/platform6/portalie/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="static/fixie/bsie/js/bootstrap-ie.js"></script>
<script type="text/javascript" src="avicit/platform6/portalie/js/easyloader.js"></script>
<script type="text/javascript" src="static/h5/singleLayOut/src/jquery.resizable.js"></script>
<script type="text/javascript" src="avicit/platform6/portalie/js/plugins/jquery.panel.js"></script>
<script type="text/javascript" src="static/h5/singleLayOut/plugins/jquery.layout.custom.js"></script>
<script type="text/javascript" src="avicit/platform6/portalie/js/layer.js"></script>
<script type="text/javascript" src="static/h5/common-ext/avic.ajax.js"></script>
<script type="text/javascript" src="avicit/platform6/portalie/js/divscroll.js"></script>

<script type="text/javascript">
   $(function() {
		$("body").removeClass("edit");
		$("body").addClass("devpreview sourcepreview");
		$('.two_column_7_3').find('.span8').css('width','70%');
		$('.two_column_7_3').find('.span4').css('width','30%');
		
		$('.two_column_3_7').find('.span8').css('width','70%');
		$('.two_column_3_7').find('.span4').css('width','30%');
		
		$('.two_column_5_5').find('.span6').css('width','50%');
		
		$('.three_column_3_4_3').find('.span4').css('width','33.333%');
		
		$('.three_column_2_5_3').find('.span2').css('width','20%');
		$('.three_column_2_5_3').find('.span6').css('width','50%');
		$('.three_column_2_5_3').find('.span4').css('width','30%');
		
		$('.demo').find('.columnTip').hide();
		$('.demo').find('.layoutTip').hide();
		
		$('body').show();
		var _baseUrl = '<%=ViewUtil.getRequestPath(request)%>';
		$('.view').find('.guider').find('a').on('click',function(){
			top.window.open(_baseUrl + $(this).attr('data-src'),$(this).attr('data-title'));

		});
		/* $('#loading').hide(); */
		$('#main').show();
	});
/*  //ie9以上美化滚动条
   function perfectScroll(dom) {
       dom.perfectScrollbar();
   } */
   //美化滚动条
//    $(function() {
//    	perfectScroll($('body'));
//    });

</script>
</body>
</html>