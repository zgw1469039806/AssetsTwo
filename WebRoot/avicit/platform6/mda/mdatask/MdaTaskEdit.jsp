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
<title>编辑</title>
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
																		    <input class="form-control input-sm" type="text" name="taskname"  id="taskname" value='<c:out  value='${mdaTaskDTO.taskname}'/>'/>
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
																		    <input class="form-control input-sm" type="text" name="crawlconfigid"  id="crawlconfigid" value='<c:out  value='${mdaTaskDTO.crawlconfigid}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="timeoutmillis">超时时间:</label></th>
								    									<td width="39%">
																		  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="timeoutmillis" id="timeoutmillis" value='<c:out  value='${mdaTaskDTO.timeoutmillis}'/>' data-min="0" data-max="999999999999" data-step="1" data-precision="0">
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
				                	      <input class="form-control date-picker" type="text" name="starttime" id="starttime" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaTaskDTO.starttime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="finishtime">结束时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="finishtime" id="finishtime" value='<fmt:formatDate pattern="yyyy-MM-dd" value='${mdaTaskDTO.finishtime}'/>'/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="outputdata">输出数据:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="outputdata"  id="outputdata" value='<c:out  value='${mdaTaskDTO.outputdata}'/>'/>
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
																		    <input class="form-control input-sm" type="text" name="tasklevel"  id="tasklevel" value='<c:out  value='${mdaTaskDTO.tasklevel}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="classifyids">分类:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="classifyids"  id="classifyids" value='<c:out  value='${mdaTaskDTO.classifyids}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 						</tr>
					</table>
			</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="mdaTask_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="mdaTask_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
			function closeForm(){
			parent.mdaTask.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
			  parent.mdaTask.save($('#form'),"eidt");
		}
	
		$(document).ready(function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.mdaTask.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mdaTask_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#mdaTask_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																																																																																																																																		
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>