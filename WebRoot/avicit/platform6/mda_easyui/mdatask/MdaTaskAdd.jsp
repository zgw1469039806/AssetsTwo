<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "recruit/recruitmgr/mdatask/MdaTaskController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" />
			<table class="form_commonTable">
				<tr>



					<th width="10%">ORG_IDENTITY:</th>
					<td width="40%"><input title="ORG_IDENTITY"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[32]'" style="width: 180px;"
						type="text" name="orgIdentity" id="orgIdentity" /></td>

					<th width="10%">TASKNAME:</th>
					<td width="40%"><input title="TASKNAME"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[255]'" style="width: 180px;"
						type="text" name="taskname" id="taskname" /></td>
				</tr>
				<tr>

					<th width="10%">CRAWLTYPE:</th>
					<td width="40%"><input title="CRAWLTYPE"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[1]'" style="width: 180px;"
						type="text" name="crawltype" id="crawltype" /></td>

					<th width="10%"><span class="remind">*</span> CRAWLCONFIGID:</th>
					<td width="40%"><input title="CRAWLCONFIGID"
						class="easyui-validatebox"
						data-options="required:true,validType:'maxLength[32]'"
						style="width: 180px;" type="text" name="crawlconfigid"
						id="crawlconfigid" /></td>
				</tr>
				<tr>

					<th width="10%"><span class="remind">*</span> TIMEOUTMILLIS:</th>
					<td width="40%"><input title="TIMEOUTMILLIS"
						class="easyui-numberbox easyui-validatebox"
						data-options="required:true,validType:'maxLength[22]'"
						style="width: 180px;" type="text" name="timeoutmillis"
						id="timeoutmillis" /></td>

					<th width="10%">STARTTIME:</th>
					<td width="40%"><input title="STARTTIME"
						class="easyui-datebox" editable="false" style="width: 182px;"
						type="text" name="starttime" id="starttime" /></td>
				</tr>
				<tr>

					<th width="10%">FINISHTIME:</th>
					<td width="40%"><input title="FINISHTIME"
						class="easyui-datebox" editable="false" style="width: 182px;"
						type="text" name="finishtime" id="finishtime" /></td>

					<th width="10%">PROGRESS:</th>
					<td width="40%"><input title="PROGRESS"
						class="easyui-numberbox easyui-validatebox"
						data-options="validType:'maxLength[22]'" style="width: 180px;"
						type="text" name="progress" id="progress" /></td>
				</tr>
				<tr>

					<th width="10%">MSG:</th>
					<td width="40%"><input title="MSG"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[1000]'" style="width: 180px;"
						type="text" name="msg" id="msg" /></td>

					<th width="10%">FLAG:</th>
					<td width="40%"><input title="FLAG"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[100]'" style="width: 180px;"
						type="text" name="flag" id="flag" /></td>
				</tr>
				<tr>

					<th width="10%">OUTPUTDATA:</th>
					<td width="40%"><input title="OUTPUTDATA"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[2000]'" style="width: 180px;"
						type="text" name="outputdata" id="outputdata" /></td>

					<th width="10%">PROPS:</th>
					<td width="40%"><input title="PROPS"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[1000]'" style="width: 180px;"
						type="text" name="props" id="props" /></td>
				</tr>
				<tr>

					<th width="10%"><span class="remind">*</span> RUNSTATUS:</th>
					<td width="40%"><input title="RUNSTATUS"
						class="easyui-validatebox"
						data-options="required:true,validType:'maxLength[1]'"
						style="width: 180px;" type="text" name="runstatus" id="runstatus" />
					</td>

					<th width="10%">CRAWLCONFIGSNAPSHOT:</th>
					<td width="40%"><input title="CRAWLCONFIGSNAPSHOT"
						class="easyui-numberbox easyui-validatebox"
						data-options="validType:'maxLength[22]'" style="width: 180px;"
						type="text" name="crawlconfigsnapshot" id="crawlconfigsnapshot" />
					</td>
				</tr>
				<tr>

					<th width="10%"><span class="remind">*</span> TASKLEVEL:</th>
					<td width="40%"><input title="TASKLEVEL"
						class="easyui-validatebox"
						data-options="required:true,validType:'maxLength[1]'"
						style="width: 180px;" type="text" name="tasklevel" id="tasklevel" />
					</td>

					<th width="10%">CLASSIFYIDS:</th>
					<td width="40%"><input title="CLASSIFYIDS"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[50]'" style="width: 180px;"
						type="text" name="classifyids" id="classifyids" /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>

	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="保存" id="saveButton"
						class="easyui-linkbutton primary-btn" onclick="saveForm();"
						href="javascript:void(0);">保存</a> <a title="返回" id="returnButton"
						class="easyui-linkbutton" onclick="closeForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		$.extend($.fn.validatebox.defaults.rules, {
			maxLength : {
				validator : function(value, param) {
					return param[0] >= value.length;

				},
				message : '请输入最多 {0} 字符.'
			}
		});
		$(function() {
			/* var userCommonSelector = new CommonSelector("user","userSelectCommonDialog","userName","userNameName");
			userCommonSelector.init();  */
			//选择部门
			/* var deptCommonSelector = new CommonSelector("dept","deptSelectCommonDialog","userName","userNameName");
			deptCommonSelector.init();  */
			//选择角色
			/* var roleCommonSelector = new CommonSelector("role","roleSelectCommonDialog","userName","userNameName",null,null,null);
			roleCommonSelector.init();  */
			/*  //选择群组
			 var groupCommonSelector = new CommonSelector("group","groupSelectCommonDialog","userName","userNameName",null,null,null);
			 groupCommonSelector.init(); 
			 //选择岗位
			 var positionCommonSelector = new CommonSelector("position","positionSelectCommonDialog","userName","userNameName");
			 positionCommonSelector.init();  */
		});
		function closeForm() {
			parent.mdaTask.closeDialog("#insert");
		}
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			$('#saveButton').linkbutton('disable').unbind("click");
			parent.mdaTask.save(serializeObject($('#form')), "#insert");
		}
	</script>
</body>
</html>