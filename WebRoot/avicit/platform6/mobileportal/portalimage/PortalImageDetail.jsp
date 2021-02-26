<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<HEAD>
<title>详细</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- ControllerPath = "ims/portal/stat/portalimage/portalImageController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
										   				<input type="hidden" name="id" value="<c:out  value='${portalImageDTO.id}'/>" />		    
			   		    								   		    																																																																																																																												<table class="form_commonTable">
				 <tr>
																																		 																	 													<th width="10%">
						    						  	<label for="imageName">图片名称:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="imageName"  id="imageName" readonly="readonly" value="<c:out value='${portalImageDTO.imageName}'/>"/>
													   </td>
																														   									 																	 													<th width="10%">
						    						  	<label for="imagePath">图片路径:</label></th>
						    							<td width="39%">
														    <input class="form-control input-sm" type="text" name="imagePath"  id="imagePath" readonly="readonly" value="<c:out value='${portalImageDTO.imagePath}'/>"/>
													   </td>
															</tr>
								<tr>
																														   									 																	 													<th width="10%">
						    						  	<label for="imageOrder">显示顺序:</label></th>
						    							<td width="39%">
														  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
								  <input  class="form-control"  type="text" name="imageOrder" id="imageOrder" readonly="readonly"  data-min="0" data-max="999999999999" data-step="1" data-precision="0"  value="<c:out  value='${portalImageDTO.imageOrder}'/>">
								  <span class="input-group-addon">
								    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
								  </span>
								</div>	
													   </td>
																														   									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 						</tr>
						<tr>
						  <th><label for="attachment">附件</label></th>
							<td colspan="<%=2 * 2 - 1 %>">
								<div id="attachment"></div>
							</td>
						</tr>
				  </table>
		</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
//关闭Dialog
function closeForm(){
	parent.portalImage.closeDialog();
}
//加载完后初始化
$(document).ready(function () {
	//初始化附件上传组件
   $('#attachment').uploaderExt({
		formId: '${portalImageDTO.id}',
		allowAdd: false,
		allowDelete: false
   });
	//返回按钮绑定事件
	$('#returnButton').bind('click', function(){
		closeForm();
	});
	//form控件禁用
	setFormDisabled();
	$(document).keydown(function(event){  
		event.returnValue = false;
		return false;
	});  
});
</script>
</body>
</html>