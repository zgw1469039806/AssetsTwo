<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/mda/mdasearchstatistic/mdaSearchstatisticController/operation/Detail/id" -->
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
																																																																																																																																												    $('.input-right-icon').hide();
	});
	
  document.ready = function () {
	document.body.style.visibility = 'visible';
  }
</script>
</head>
<body class="easyui-layout" fit="true" style="visibility:hidden;">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
									<input type="hidden" name="id" value='${mdaSearchstatisticDTO.id}'/>
												<input type="hidden" name="id" value='${mdaSearchstatisticDTO.id}'/>
																																																				<table class="form_commonTable">
		<tr>
																																																																		  									<th align="right" width="10%" style="word-break:break-all;word-warp:break-word;">
													<span style="color:red;">*</span>
										KEYWORDS:</th>
					<td class="disabled" width="39%">
																		<input title="KEYWORDS" class="easyui-validatebox" data-options="required:true" style="width: 99%;" type="text" name="keywords" id="keywords" readonly="readonly" value='<c:out  value='${mdaSearchstatisticDTO.keywords}'/>'/>
																</td>
									 				 				   																				  									<th align="right" width="10%" style="word-break:break-all;word-warp:break-word;">
																	RATE:</th>
					<td class="disabled" width="39%">
																  		<input title="RATE" class="easyui-numberbox" style="width: 99%;" type="text" name="rate" id="rate" readonly="readonly" value='<c:out  value='${mdaSearchstatisticDTO.rate}'/>'/>	
																</td>
											</tr>
						<tr>
									 				 				   											</tr>
		</table>
		</form>
	</div>
</body>
</html>