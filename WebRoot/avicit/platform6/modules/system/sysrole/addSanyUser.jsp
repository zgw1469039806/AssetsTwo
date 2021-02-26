<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>三员角色添加用户</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:false,title:''" style="height:0; overflow:hidden; font-size:0;">				
		<table id="dgUser"
			data-options=" 
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarUser',
				idField :'id',
				singleSelect: false,
				checkOnSelect: true,
				selectOnCheck: true,
				striped:true
				">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
					<th data-options="field:'name',required:true,halign:'center',align:'center'"  width="220">用户名</th>
					<th data-options="field:'no',required:true,halign:'center',align:'center'"  width="220">用户编号</th>
					<th data-options="field:'loginName',halign:'center',align:'center'" width="220">登录名</th>
					<th data-options="field:'type',halign:'center',align:'center',formatter: formatType"   width="220">类型</th>
					<th data-options="field:'status',halign:'center',align:'center',formatter: formatStatus"  width="220">状态</th>
					<th data-options="field:'remark',halign:'center',align:'center'"  width="220">描述</th>
				</tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;">
    	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
            <table class="tableForm" border="0" cellspacing="1" width='100%'>
                <tr>
                    <td align="right">
                        <a title="保存" id="saveButton" class="easyui-linkbutton primary-btn" onclick="saveForm();" href="javascript:void(0);">保存</a>
                        <a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
<script type="text/javascript">
$(function(){
	$('#dgUser').datagrid({
		url:"platform/sysrole/sanyuan/sanyuanuser/${roleId}.json",
		method:"get"
	});
});
function formatType(value){
	return '虚拟用户';
};
function formatStatus(value){
	return parent.sanRole.formatValid(value);
};
function closeForm(){
	parent.sanRoleUser.closeDialog();
};

function saveForm() {
	var obj = {
		roleIds : '${roleId}'
	};//, ids: ids.join(','),appId:applicationId};
	var row = $('#dgUser').datagrid('getChecked'),ids = [],l = row.length;
	if (l > 0) {
		for (; l--;) {
			ids.push(row[l].id);
		}
	}else{
		alert("请选择用户！");
		return;
	}
	obj.ids=ids.join(',');
	parent.sanRoleUser.saveUserRole(obj);
};
</script>
</body>
</html>