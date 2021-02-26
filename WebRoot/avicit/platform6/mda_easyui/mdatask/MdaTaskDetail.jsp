<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "recruit/recruitmgr/mdatask/MdaTaskController/operation/Detail/id" -->
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">
		<form id='form'>
									<input type="hidden" name="id" value='${mdaTaskDTO.id}'/>
												<input type="hidden" name="id" value='${mdaTaskDTO.id}'/>
																																																																																																																					<table width="100%" style="padding-top: 10px;">
		<tr>
																																																														<th align="right">
															ORG_IDENTITY:</th>
					<td>
																		<input title="ORG_IDENTITY" class="inputbox" style="width: 180px;" type="text" name="orgIdentity" id="orgIdentity" readonly="readonly" value='${mdaTaskDTO.orgIdentity}'/>
																</td>
																										<th align="right">
															TASKNAME:</th>
					<td>
																		<input title="TASKNAME" class="inputbox" style="width: 180px;" type="text" name="taskname" id="taskname" readonly="readonly" value='${mdaTaskDTO.taskname}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
															CRAWLTYPE:</th>
					<td>
																		<input title="CRAWLTYPE" class="inputbox" style="width: 180px;" type="text" name="crawltype" id="crawltype" readonly="readonly" value='${mdaTaskDTO.crawltype}'/>
																</td>
																										<th align="right">
											<span style="color:red;">*</span>
										CRAWLCONFIGID:</th>
					<td>
																		<input title="CRAWLCONFIGID" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="crawlconfigid" id="crawlconfigid" readonly="readonly" value='${mdaTaskDTO.crawlconfigid}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
											<span style="color:red;">*</span>
										TIMEOUTMILLIS:</th>
					<td>
																  		<input title="TIMEOUTMILLIS" class="easyui-numberbox easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="timeoutmillis" readonly="readonly" id="timeoutmillis" value='${mdaTaskDTO.timeoutmillis}'/>	
																</td>
																										<th align="right">
															STARTTIME:</th>
					<td>
																  		<input title="STARTTIME" class="easyui-datebox" style="width: 180px;" type="text" name="starttime" id="starttime" readonly="readonly" value='${mdaTaskDTO.starttime}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
															FINISHTIME:</th>
					<td>
																  		<input title="FINISHTIME" class="easyui-datebox" style="width: 180px;" type="text" name="finishtime" id="finishtime" readonly="readonly" value='${mdaTaskDTO.finishtime}'/>
																</td>
																										<th align="right">
															PROGRESS:</th>
					<td>
																  		<input title="PROGRESS" class="easyui-numberbox" style="width: 180px;" type="text" name="progress" id="progress" readonly="readonly" value='${mdaTaskDTO.progress}'/>	
																</td>
											</tr>
						<tr>
																										<th align="right">
															MSG:</th>
					<td>
																		<input title="MSG" class="inputbox" style="width: 180px;" type="text" name="msg" id="msg" readonly="readonly" value='${mdaTaskDTO.msg}'/>
																</td>
																										<th align="right">
															FLAG:</th>
					<td>
																		<input title="FLAG" class="inputbox" style="width: 180px;" type="text" name="flag" id="flag" readonly="readonly" value='${mdaTaskDTO.flag}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
															OUTPUTDATA:</th>
					<td>
																		<input title="OUTPUTDATA" class="inputbox" style="width: 180px;" type="text" name="outputdata" id="outputdata" readonly="readonly" value='${mdaTaskDTO.outputdata}'/>
																</td>
																										<th align="right">
															PROPS:</th>
					<td>
																		<input title="PROPS" class="inputbox" style="width: 180px;" type="text" name="props" id="props" readonly="readonly" value='${mdaTaskDTO.props}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
											<span style="color:red;">*</span>
										RUNSTATUS:</th>
					<td>
																		<input title="RUNSTATUS" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="runstatus" id="runstatus" readonly="readonly" value='${mdaTaskDTO.runstatus}'/>
																</td>
																										<th align="right">
															CRAWLCONFIGSNAPSHOT:</th>
					<td>
																  		<input title="CRAWLCONFIGSNAPSHOT" class="easyui-numberbox" style="width: 180px;" type="text" name="crawlconfigsnapshot" id="crawlconfigsnapshot" readonly="readonly" value='${mdaTaskDTO.crawlconfigsnapshot}'/>	
																</td>
											</tr>
						<tr>
																										<th align="right">
											<span style="color:red;">*</span>
										TASKLEVEL:</th>
					<td>
																		<input title="TASKLEVEL" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="tasklevel" id="tasklevel" readonly="readonly" value='${mdaTaskDTO.tasklevel}'/>
																</td>
																										<th align="right">
															CLASSIFYIDS:</th>
					<td>
																		<input title="CLASSIFYIDS" class="inputbox" style="width: 180px;" type="text" name="classifyids" id="classifyids" readonly="readonly" value='${mdaTaskDTO.classifyids}'/>
																</td>
											</tr>
						<tr>
																</tr>
		</table>
		</form>
	</div>
	<script type="text/javascript">
	$(function(){
																																																																							if(!"${mdaTaskDTO.starttime}"==""){
					$('#starttime').datebox('setValue', parserColumnTime("${mdaTaskDTO.starttime}").format("yyyy-MM-dd"));
				}
												if(!"${mdaTaskDTO.finishtime}"==""){
					$('#finishtime').datebox('setValue', parserColumnTime("${mdaTaskDTO.finishtime}").format("yyyy-MM-dd"));
				}
																																																																																																																																																																																																																																																																																																																																																																			});
	</script>
</body>
</html>