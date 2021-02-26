<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>切换当前组织或者部门</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<link href="static/css/platform/sysdept/icon.css" type="text/css"
	rel="stylesheet">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<script type="text/javascript">
var deptId = '',curDeptId,curOrgId,userId;

var closeDeptDialog = function(){
	parent.$("#change_dept_dialog").dialog("close");
}

$(function() {
	var d = $('#cc').combobox({
		valueField : 'id',
		textField : 'name',
		editable : false,
		panelHeight : 70
	});
	var org = $('#oo').combobox({
		valueField : 'id',
		textField : 'name',
		editable : false,
		panelHeight : 70,
		onSelect:function(record){
			$.ajax({
				url : 'platform/sysuser/getDeptListByOrgUser/'+userId+'/'+record.id+'.json',
				type : 'get',
				dataType : 'json',
				success : function(r) {
					if (r && r.flag == 0) {
						d.combobox('loadData', r.list);
						d.combobox('setValue', r.id);
					}
				}
			});
		}
	});
	$.ajax({
		url : 'platform/sysuser/getOrgListByUserId.json',
		type : 'get',
		dataType : 'json',
		success : function(r) {
			if (r && r.flag == 0) {
				org.combobox('loadData', r.orglist);
				org.combobox('setValue', r.currentOrgId);
				curOrgId=r.currentOrgId
				d.combobox('loadData', r.deptlist);
				d.combobox('setValue', r.selectDeptId);
				curDeptId=r.currentDeptId;
				userId=r.uid;
			}
		}
	});
});

var doChange = function() {
	if(curDeptId === $('#cc').combobox('getValue') && curOrgId === $('#oo').combobox('getValue')){//没变化
		closeDeptDialog();
		return;
	}
	$.ajax({
		url : 'platform/sysuser/updateCurrentDeptByUserId.json',
		data : {
			deptId : $('#cc').combobox('getValue'),
			orgId:$('#oo').combobox('getValue')
		},
		type : 'post',
		dataType : 'json',
		success : function(result) {
			parent&&parent.location.reload();
		}
	});
};

</script>
<body>
	<form id="changedept" name="changedept" method="post">
		<table width="100%" style="padding-top: 10px;">
			<tr>
				<td width="80" align="right"><span>切换组织：</span>
				</td>
				<td>
					<div id="oo" class="easyui-combobox" name="sysOrg"
						style="width:150px;display:inline"></div></td>
			</tr>
			<tr>
				<td width="80" align="right"><span>选择部门：</span>
				</td>
				<td>
					<div id="cc" class="easyui-combobox" name="sysDept"
						style="width:150px;display:inline"></div></td>
			</tr>
			
		</table>
	</form>
	<div style="text-align: center;">
		<div style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto;">
			<br/>
			<button id="confirmBtn" onclick="doChange();">确认</button>
			<button id="confirmBtn" onclick="closeDeptDialog();">取消</button>
		</div>
	</div>
</body>
</html>







