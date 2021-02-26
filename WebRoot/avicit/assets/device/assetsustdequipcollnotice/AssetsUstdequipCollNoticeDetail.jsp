<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "assets/device/assetsustdequipcollnotice/assetsUstdequipCollNoticeController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${assetsUstdequipCollNoticeDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsUstdequipCollNoticeDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																																								 <table class="form_commonTable">
				<tr>
																																											 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="noticeNo">单号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="noticeNo"  id="noticeNo" readonly="readonly" value="<c:out  value='${assetsUstdequipCollNoticeDTO.noticeNo}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="authorAlias">起草人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="author" name="author" value="<c:out  value='${assetsUstdequipCollNoticeDTO.author}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" readonly="readonly" name="authorAlias" value="<c:out  value='${assetsUstdequipCollNoticeDTO.authorAlias}'/>">
										      <span class="input-group-addon">
									           <i class="glyphicon glyphicon-user"></i>
									          </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="deptAlias">起草单位:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="dept" name="dept" value="<c:out  value='${assetsUstdequipCollNoticeDTO.dept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" name="deptAlias" readonly="readonly" value="<c:out  value='${assetsUstdequipCollNoticeDTO.deptAlias}'/>">
									      <span class="input-group-addon">
									         <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="releasedate">日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="releasedate" id="releasedate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsUstdequipCollNoticeDTO.releasedate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="tel">联系电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="tel"  id="tel" readonly="readonly" value="<c:out  value='${assetsUstdequipCollNoticeDTO.tel}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deadline">部门上报截至日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="deadline" id="deadline" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsUstdequipCollNoticeDTO.deadline}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="noticeYear">年度:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="noticeYear"  id="noticeYear" readonly="readonly" value="<c:out  value='${assetsUstdequipCollNoticeDTO.noticeYear}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="title">标题:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="title"  id="title" readonly="readonly" value="<c:out  value='${assetsUstdequipCollNoticeDTO.title}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByDept">申请人部门:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="createdByDept"  id="createdByDept" readonly="readonly" value="<c:out  value='${assetsUstdequipCollNoticeDTO.createdByDept}'/>"/>
																	   </td>
																								   													 												 												 												 												 												 						</tr>
					</table>
			</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
			document.ready = function () {
			parent.assetsUstdequipCollNotice.formValidate($('#form'));
		};
	//form控件禁用
	setFormDisabled();
	$(document).keydown(function(event){  
		event.returnValue = false;
		return false;
	});  
	</script>
</body>
</html>