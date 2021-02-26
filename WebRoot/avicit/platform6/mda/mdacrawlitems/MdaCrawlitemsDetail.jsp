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
<!-- ControllerPath = "platform6/mda/mdacrawlitems/mdaCrawlitemsController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value='<c:out  value='${mdaCrawlitemsDTO.version}'/>'/>
															<input type="hidden" name="id" value='<c:out  value='${mdaCrawlitemsDTO.id}'/>'/>
																																																																																																																																																													 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="name">采集项名称:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="name"  id="name" readonly="readonly" value='<c:out  value='${mdaCrawlitemsDTO.name}'/>'/>
																	   </td>
																																								   													 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createtime">创建时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="createtime" id="createtime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaCrawlitemsDTO.createtime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="lastmodifytime">最后修改时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="lastmodifytime" id="lastmodifytime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaCrawlitemsDTO.lastmodifytime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="lasttimecrawl">最后爬取时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="lasttimecrawl" id="lasttimecrawl" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaCrawlitemsDTO.lasttimecrawl}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="lastcrawluseridAlias">最后爬取用户:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="lastcrawluserid" name="lastcrawluserid" value='<c:out  value='${mdaCrawlitemsDTO.lastcrawluserid}'/>'>
										      <input class="form-control" placeholder="请选择用户" type="text" id="lastcrawluseridAlias" name="lastcrawluseridAlias" readonly="readonly" value='<c:out  value='${mdaCrawlitemsDTO.lastcrawluseridAlias}'/>'>
										      <span class="input-group-addon" id="userbtn">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="itemtype">采集类型:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="itemtype" id="itemtype" title="" isNull="true" lookupCode="MDA_ITEMTYPE" defaultValue='${mdaCrawlitemsDTO.itemtype}'/>
								    								   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="classifyids">分类:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="classifyids"  id="classifyids" readonly="readonly" value='<c:out  value='${mdaCrawlitemsDTO.classifyids}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="status">状态:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="status" id="status" title="" isNull="true" lookupCode="MDA_STATUS" defaultValue='${mdaCrawlitemsDTO.status}'/>
								    								   </td>
																			</tr>
										<tr>
																																								   													 						</tr>
					</table>
			</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		document.ready = function () {
		parent.mdaCrawlitems.formValidate($('#form'));
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