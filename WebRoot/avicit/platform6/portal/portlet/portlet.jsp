<%@page import="java.util.Enumeration"%>
<%@page language="java"  pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String importlibs = "common,noLoading-mask";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit|ie-stand">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自定义个人首页</title>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp" >
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<!-- Le styles -->
<link href="avicit/platform6/portal/portlet/css/bootstrap-combined.min.css" rel="stylesheet">

<link href="avicit/platform6/portal/portlet/css/layoutit.css" rel="stylesheet">
<link href="avicit/platform6/portal/portlet/css/layoutit_extend.css" rel="stylesheet">
<link href="avicit/platform6/portal/portlet/css/guider.css" rel="stylesheet">
<style type="text/css">
.content-empty:after,
.content-empty:before{
  content:"" !important;
}
</style>
</head>
<body style="cursor:auto;background:#f0f0f0;padding-top:15px;display:none;overflow-x:hidden;" class="edit">
<div class="container-fluid" style="padding-left:0px;padding-right:15px;">
  <div class="row-fluid">
    <div  class="demo ui-sortable">
    	${portletContent}
    </div>
  </div>
</div>
<a id="ict_top" class="goTop" style="display: none;" ><i class="icon_goTop"></i></a>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
$(window).scroll(function () {
	if (document.documentElement.scrollTop + document.body.scrollTop > 0) {
		$("#ict_top").show();
	} else {
		$("#ict_top").hide();
	}
});	


   $(function() {
		$("body").removeClass("edit");
		$("body").addClass("devpreview sourcepreview");
		$('.two_column_7_3').find('.span9').css('width','70%');
		$('.two_column_7_3').find('.span3').css('width','30%');
		
		$('.two_column_3_7').find('.span9').css('width','70%');
		$('.two_column_3_7').find('.span3').css('width','30%');

       $('.two_column_6_4').find('.span8').css('width','60%');
       $('.two_column_6_4').find('.span4').css('width','40%');

       $('.two_column_4_6').find('.span8').css('width','60%');
       $('.two_column_4_6').find('.span4').css('width','40%');

		$('.two_column_5_5').find('.span6').css('width','50%');

       $('.three_column_3_4_3').find('.span3').css('width','30%');
       $('.three_column_3_4_3').find('.span6').css('width','40%');

       $('.three_column_2_5_3').find('.span2').css('width','20%');
		$('.three_column_2_5_3').find('.span6').css('width','50%');
		$('.three_column_2_5_3').find('.span4').css('width','30%');

       $('.three_column_4_4_4').find('.span4').css('width','33.333%');

		$('.demo').find('.columnTip').hide();
		$('.demo').find('.layoutTip').hide();
		
		$('body').show();
		// $('.view').find('.guider').find('a').on('click',function(){
		// 	top.window.open($(this).attr('data-src'),$(this).attr('data-title'));
		// 	return;
		// });
       var _baseUrl = '<%=ViewUtil.getRequestPath(request)%>';
       $('.view').find('.guider').find('.refresh-a').on('click',function(){
    	   $('#'+$(this).attr('data-src')).attr('src', $('#'+$(this).attr('data-src')).attr('src'));
       });
       $('.view').find('.guider').find('.more-a').on('click',function(){
           top.window.open(_baseUrl + $(this).attr('data-src'),$(this).attr('data-title'));

       });
       
       $('#ict_top').bind('click',function(){
	       	$('html,body').animate({
	       		scrollTop: '0px'
	       	}, 200); //200毫秒返回到顶部
      });

	});
 //ie9以上美化滚动条
   function perfectScroll(dom) {
       dom.perfectScrollbar();
   }
	//美化滚动条
	//    $(function() {
	//    	perfectScroll($('body'));
	//    });
</script>
</body>
</html>