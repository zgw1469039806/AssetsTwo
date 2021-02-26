<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.session.SessionHelper"%>
<%
	String deptId = SessionHelper.getCurrentDeptId(request);
	String secretL = SessionHelper.getLoginSysUser(request).getSecretLevel();
%>
<html>
<head>

<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>

<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<title>添加移交项</title>
<style>
body td {
	font-family: Microsoft Yahei, sans-serif, Arial, Helvetica;
	font-size: 12px;
	padding-left: 0.5em;
}
</style>
<script type="text/javascript">
	 var baseurl = '<%=request.getContextPath()%>';
	$(function() {
		//选择人员
		var commonSelector = new CommonSelector("user", "userSelectCommonDialog", "receptUserId", "receptUserName", "receptDeptId", "receptDeptName", "{\"secretL\":<%=secretL%>,\"deptId\":\"<%=deptId%>\"}", true, null, null, 600, 300);
		commonSelector.init(null, null, 'n', null, "Y"); //选择人员  回填部门
		ajaxRequest("POST", "", "platform/bpm/clientbpmWorkHandAction/addWorkHand", "json", "initWorkHand");
		addTr(false);
		$(".modelType").on("click", function(){
			var self = this;
			var usd = new UserSelectDialog("selectModelDialog","300","300", "avicit/platform6/bpmclient/workhand/showCatalog.jsp", "流程业务目录");
			var buttons = [ {
				text : '清空',
				id : 'clear',
				handler : function() {
					$(self).val("");
					$(self).next("input").val("");
					usd.close();
				}
			} , {
				text : '确定',
				id : 'ok',
				handler : function() {
					var frmId = $('#selectModelDialog iframe').attr('id');
					var frm = document.getElementById(frmId).contentWindow;
					var node = frm.getData();
					if(node == null){
						$.messager.alert("操作提示", "请先选择一个业务目录!","info");
						return;
					}
					$(self).val(node.text);
					$(self).next("input").val(node.id);
					usd.close();
				}
			} ];
			usd.createButtonsInDialog(buttons);
			usd.show();
		});
	});
	/**
	 *初始化页面的回调函数
	 */
	function initWorkHand(retValue) {
		var workHandVo = retValue.workHand;
		$("#workOwnerId").attr("value", workHandVo.workOwnerId);
		$("#workOwnerName").attr("value", workHandVo.workOwnerName);
		$("#workOwnerDeptId").attr("value", workHandVo.workOwnerDeptId);
		$("#workOwnerDeptName").attr("value", workHandVo.workOwnerDeptName);
		$("#receptUserId").attr("value", workHandVo.receptUserId);
		$("#receptDeptId").attr("value", workHandVo.receptDeptId);
		$("#receptUserName").attr("value", workHandVo.receptUserName);
		$("#receptDeptName").attr("value", workHandVo.receptDeptName);
		$("#handDate").attr("value", (new Date()).Format("yyyy-MM-dd"));
	}
	function addTr(flg){
		var tr = $("#modules").find("tr").eq(0).clone(true);
		if(flg){
			var delBut = document.createElement("button");
			$(delBut).text("删除");
			$(tr).find("td").last().append($(delBut));
			$(delBut).on("click", function(){
				$(tr).remove();
			});
		}
		$(tr).show();
		$("#modules").append($(tr));
		var id = guid();
		var nameId = guid();
		$(tr).find("input[name='userId']").attr("id", id);
		$(tr).find("input[name='userName']").attr("id", nameId);
		var commonSelector = new CommonSelector("user", "userSelectCommonDialog", id, nameId, null, null, "{\"secretL\":<%=secretL%>,\"deptId\":\"<%=deptId%>\"}", true, null, null, 600, 300);
		commonSelector.init(null, null, 'n', null, "Y");
	}
	function guid() {
		return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
			var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
			return v.toString(16);
		});
	}
</script>
</head>

<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id="workhandForm" method="post">
			<table class="form_commonTable">
				<tr>
					<th width="12%">移交人:</th>
					<td width="38%"><input name="workOwnerId" id="workOwnerId" style="display:none;" /><input class="easyui-validatebox" name="workOwnerName" id="workOwnerName" readonly="readonly" /></td>
					<th width="12%">移交部门:</th>
					<td width="38%"><input name="workOwnerDeptId" id="workOwnerDeptId" style="display:none;" /><input class="easyui-validatebox" name="workOwnerDeptName" id="workOwnerDeptName" readonly="readonly" /></td>
				</tr>
				<tr>
					<th width="12%"><span class="remind">*</span>默认接受人:</th>
					<td width="38%"><input name="receptUserId" id="receptUserId" style="display:none;" /><input class="easyui-validatebox" name="receptUserName" id="receptUserName" readonly="readonly" required="true" /></td>
					<th width="12%"><span class="remind">*</span>接受部门:</th>
					<td width="38%"><input name="receptDeptId" id="receptDeptId" style="display:none;" /><input class="easyui-validatebox" id="receptDeptName" name="receptDeptName" readonly="readonly" required="true" /></td>
				</tr>
				<tr>
					<th width="12%"><span class="remind">*</span>生效日期:</th>
					<td width="38%"><input name="handEffectiveDate" id="handEffectiveDate" class="easyui-datebox" required="true" data-options="editable:false,tipPosition:'top'" /></td>
					<th width="12%"><span class="remind">*</span>返回日期:</th>
					<td width="38%"><input name="backDate" id="backDate" class="easyui-datebox" required="true" data-options="editable:false,tipPosition:'top'" /></td>
				</tr>
				<tr>
					<th width="12%">登记日期:</th>
					<td width="38%"><input name="handDate" id="handDate" class="easyui-validatebox" readonly="readonly" /></td>
					<th width="12%"><span class="remind">*</span>是否有效:</th>
					<td width="38%"><select name="validFlag" class="easyui-combobox" data-options="{required:true,panelHeight:'auto',editable:false,onShowPanel:comboboxOnShowPanel,readonly:true}">
							<option value="1">有效</option>
							<option value="0">无效</option>
					</select></td>
				</tr>
				<tr>
					<th width="12%">移交原因:</th>
					<td colspan="3"><input name="handReason" id="handReason" class="easyui-validatebox" /></td>
					<!-- <textarea id="handReason" name="handReason" rows="3" class="textareabox"></textarea> -->
				</tr>
				<tr>
					<th width="12%">到期后自动注销:</th>
					<td colspan="3">
						<input type="checkbox" id="expireAutoCancel" name="expireAutoCancel" value="1" checked />
				</tr>
			</table>
		</form>
		<small style="font-size:12px;">若配置按模块移交，则优先根据模块接受人进行移交。其他情况还是移交给默认接受人。</small>
		<table class="form_commonTable" id="modules">
			<tr style="display:none">
				<th width="12%">按模块移交:</th>
				<td width="30%"><input class="easyui-validatebox modelType" name="modelName" readonly="readonly"/><input type="hidden" name="modelId" /></td>
				<th width="12%">接受人:</th>
				<td width="30%"><input class="easyui-validatebox" name="userName" readonly="readonly"/><input type="hidden" name="userId" /></td>
				<td width="16%">
					<button onclick="addTr(true)">增加</button>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>

