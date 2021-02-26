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
<!-- ControllerPath = "platform6/mda/mdatask/mdaTaskController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value='<c:out  value='${mdaTaskDTO.version}'/>'/>
															<input type="hidden" name="id" value='<c:out  value='${mdaTaskDTO.id}'/>'/>
																																																																																																																																																																																																																			 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="taskname">任务名称:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="taskname"  id="taskname" readonly="readonly" value='<c:out  value='${mdaTaskDTO.taskname}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="crawltype">爬取类型:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="crawltype" id="crawltype" title="" isNull="true" lookupCode="MDA_ITEMTYPE" defaultValue='${mdaTaskDTO.crawltype}'/>
								    								   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="crawlconfigid">采集项:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="crawlconfigid"  id="crawlconfigid" readonly="readonly" value='<c:out  value='${mdaTaskDTO.crawlconfigid}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="timeoutmillis">超时时间:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="timeoutmillis" id="timeoutmillis" readonly="readonly" value='<c:out  value='${mdaTaskDTO.timeoutmillis}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>	
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="starttime">开始时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="starttime" id="starttime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaTaskDTO.starttime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="finishtime">结束时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="finishtime" id="finishtime" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaTaskDTO.finishtime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="outputdata">输出数据:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="outputdata"  id="outputdata" readonly="readonly" value='<c:out  value='${mdaTaskDTO.outputdata}'/>'/>
																	   </td>
																																								   													 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="runstatus">采集结果:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="runstatus" id="runstatus" title="" isNull="true" lookupCode="MDA_RUNSTATUS" defaultValue='${mdaTaskDTO.runstatus}'/>
								    								   </td>
																			</tr>
										<tr>
																																								   													 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="tasklevel">任务优先级:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="tasklevel"  id="tasklevel" readonly="readonly" value='<c:out  value='${mdaTaskDTO.tasklevel}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="classifyids">分类:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="classifyids"  id="classifyids" readonly="readonly" value='<c:out  value='${mdaTaskDTO.classifyids}'/>'/>
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
		parent.mdaTask.formValidate($('#form'));
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